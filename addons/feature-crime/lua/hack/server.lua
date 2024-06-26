local commands = {}
local function registerCommand(cmd, handler)
	if not isstring(cmd) or not isfunction(handler) then return end
	commands[string.lower(cmd)] = handler
end

--============= UTILITY FUNCTIONS =============--
local function stop(ply)
	netstream.Start(ply, 'dbg-hack.cancel')
	if ply.hacking and IsValid(ply.hacking.target) then
		hook.Run('onKeypadHack', ply, false, ply.hacking.target)
	end
	if ply.hacking and isfunction(ply.hacking.cancel) then ply.hacking.cancel() end
	timer.Remove('dbg-hack.load' .. ply:SteamID())
	ply.hacking = nil
end

local function lock(ply, locked)
	ply.hacking.blocked = (locked == true)
	netstream.Start(ply, 'dbg-hack.updateLockStatus', locked == true)
end

local function invalidEnt(ply)
	local tgt = ply.hacking.target
	return not IsValid(tgt) or ply:GetShootPos():DistToSqr(tgt:GetPos()) > 2500
end

local function invalid(ply)
	if not IsValid(ply) or not ply.hacking then return true end
	if invalidEnt(ply) then return true, stop(ply) end
	return false
end

local function requestInput(ply, cback)
	if invalid(ply) then return end
	ply.hacking.pendingInput = cback
	netstream.Start(ply, 'dbg-hack.requestInput')
	lock(ply)
end

local function beep(ply)
	ply:EmitSound('buttons/button15.wav')
end

local function print(ply, text, append)
	if not IsValid(ply) or not ply.hacking then return false end
	beep(ply)
	netstream.Start(ply, 'dbg-hack.print', text, append == true)
	return true
end

local function input(ply, data)
	local cmd = string.lower(data[1])
	if isfunction(commands[cmd]) then
		table.remove(data, 1)
		commands[cmd](ply, data)
	else
		print(ply, cmd .. ': command not found')
		lock(ply)
	end
end

-- Player types something in terminal and presses the Enter key
netstream.Hook('dbg-hack.input', function(ply, data)

	if not isstring(data) or invalid(ply) then return end
	if ply.hacking.blocked then return lock(ply, true) end
	lock(ply, true)

	local h = ply.hacking
	if h.pendingInput then
		h.pendingInput(data)
		h.pendingInput = nil
		return
	end
	input(ply, string.Split(data, ' '))

end)

-- Player closes the terminal window (need to stop hacking process)
netstream.Hook('dbg-hack.cancel', function(ply)
	if not ply.hacking then return end
	if isfunction(ply.hacking.cancel) then ply.hacking.cancel() end
	timer.Remove('dbg-hack.load' .. ply:SteamID())
	ply.hacking = nil
end)
hook.Add('PlayerDisconnected', 'dbg-hack.cancel', function(ply)
	if ply.hacking and isfunction(ply.hacking.cancel) then ply.hacking.cancel() end
	timer.Remove('dbg-hack.load' .. ply:SteamID())
end)

--================= COMMANDS =================--
registerCommand('pwdserver', function(ply)
	hook.Run('dbg-hack.1stCommand', ply, ply.hacking.target)
	print(ply, ply.hacking.target.pwdserver)
	lock(ply)
end)

registerCommand('traceroute', function(ply, data)
	if not data[1] then
		print(ply, 'Usage: traceroute target_ip')
		return lock(ply)
	end
	if data[1] ~= ply.hacking.target.pwdserver then
		print(ply, 'Не удалось подключиться к ' .. data[1] .. ': соединение было неожиданно закрыто.')
		return lock(ply)
	end
	print(ply, 'трассировка к ' .. data[1] .. ', 30 переходов максимум, пакеты по 38 байт')

	local tm, i = 0, 0
	local function printNext()

		if invalid(ply) then return end
		i = i + 1
		if not ply.hacking.target.traceroute[i] then return lock(ply) end

		print(ply, string.format('%2d', i))

		local time = math.Rand(0.1, 0.4)
		local ip = ply.hacking.target.traceroute[i]
		timer.Simple(time, function()
			if not invalid(ply) then
				print(ply, '    ' .. ip, true)
			end
		end)

		time = time + math.Rand(0.5, 0.7)
		timer.Simple(time, function()
			if invalid(ply) then return end
			print(ply, string.rep(' ', 15 - #ip + 1), true)
			local timeStr = ''
			for j = 1, 3 do
				tm = tm + math.Rand(0.001, 0.5)
				timeStr = timeStr .. string.format('%.3f ms  ', tm)
			end
			print(ply, timeStr, true)
			printNext()
		end)

	end
	printNext()

end)

registerCommand('./inject.sh', function(ply, data)
	local ip = data[1]
	if not isstring(ip) then
		print(ply, 'Usage: ./inject.sh target_ip')
		return lock(ply)
	end
	local attNum = 0
	for i,v in ipairs(ply.hacking.target.traceroute) do
		if v == ip then
			attNum = i
			break
		end
	end
	if attNum == 0 then
		print(ply, 'Не удалось внедрить перехватчик в ' .. ip .. ': соединение было неожиданно закрыто.')
		return lock(ply)
	end
	ply.hacking.interceptor = attNum
	print(ply, 'успешно внедренный перехватчик на ' .. ip)
	lock(ply)
end)

local alphabet = '123456789'
local function randomPass()
	local str = ''
	for i = 1, 4 do
		str = str .. alphabet[math.random(#alphabet)]
	end
	return str
end

registerCommand('./unhash.sh', function(ply, data)
	if not isstring(data[1]) then
		print(ply, 'Usage: ./unhash.sh target_hash')
		return lock(ply)
	end
	local ans = {}
	if data[1] ~= ply.hacking.target.problem then
		local seed = tonumber(tostring(data[1]), 16)
		if not seed then
			print(ply, 'Incorrect hash')
			return lock(ply)
		end
		math.randomseed(tonumber(tostring(data[1]), 16))
		for i = 1, 5 do
			ans[#ans + 1] = randomPass()
		end
		math.randomseed(CurTime())
	else ans = ply.hacking.target.passs end

	local i = 0
	local function printNext()
		if invalid(ply) then return end
		i = i + 1
		if not ans[i] then return lock(ply) end
		print(ply, string.format('%2d.  %s', i, ans[i]))
		timer.Simple(math.Rand(0.1, 3), printNext)
	end
	print(ply, 'Possible combinations:')
	timer.Simple(math.Rand(0.1, 3), printNext)

end)

registerCommand('sudo', function(ply, data)

	if not isstring(data[1]) then
		print(ply, 'Использование: sudo command command_args')
		return lock(ply)
	end
	local cmd = string.lower(data[1])
	if cmd ~= 'unlock' then
		return input(ply, data)
	end

	local hashPart
	if ply.hacking.interceptor then
		local h, ind = ply.hacking.target.problem, ply.hacking.target.hashpts[ply.hacking.interceptor]
		hashPart = ''
		for i = 1, ind-1 do
			hashPart = hashPart .. '**'
		end
		hashPart = hashPart .. h[ind * 2 - 1] .. h[ind * 2]
		for i = ind + 1, 4 do
			hashPart = hashPart .. '**'
		end
		hashPart = hashPart
	end

	print(ply, '[sudo] пароль для kpad: ')
	requestInput(ply, function(pwd)
		if hashPart then
			print(ply, 'Полученная хэш-часть pwd: ' .. hashPart)
		end
		if pwd == ply.hacking.target:GetPassword() then
			print(ply, 'Unlocked.')
			ply.hacking.target:Process(true)
			hook.Run('onKeypadHack', ply, true, ply.hacking.target)
			if isfunction(ply.hacking.succeed) then ply.hacking.succeed() end
		else
			print(ply, 'Прости, повтори снова.')
			ply.hacking.target:Process(false)
			if isfunction(ply.hacking.fail) then ply.hacking.fail() end
		end
		lock(ply)
	end)

end)

--================ EASTER EGGS ================--
local files = {
	{'-rwxrwx--x', '1176', 'Feb', '16', '00:19', 'inject.sh'},
	{'-rwxrwxr--', '484', 'Mar', '29', '22:18', 'README.TXT'},
	{'-rwxrwx--x', '9008', 'May', '10', '22:54', 'unhash.sh'},
}

registerCommand('ls', function(ply)
	print(ply, 'total ' .. #files)
	for _,v in ipairs(files) do
		print(ply, string.format('%10s 1 crackr crackr %4s %3s %2s %5s %s', unpack(v)))
	end
	lock(ply)
end)

registerCommand('cat', function(ply, args)
	if not isstring(args[1]) then
		print(ply, 'Usage: cat имя_файла')
		return lock(ply)
	end
	if string.lower(args[1]) ~= 'readme.txt' then
		print(ply, '[cat] Файл ' .. args[1] .. ' не найдено или отказано в разрешении для пользователя kpad')
		return lock(ply)
	end

	print(ply, [[    КАК ИСПОЛЬЗОВАТЬ ЭТОТ КУСОК ДЕРЬМА:
	1. Определите текущий IP-адрес источника клавиатуры с помощью команды "pwdserver":
	> pwdserver
	37.212.16.22
  2. Проверьте путь пакетов с помощью команды "traceroute":
	> traceroute 37.212.16.22
	traceroute к 37.212.16.22, максимум 30 переходов, 38-байтовые пакеты
	...
  3. Установите перехватчики на один из IP-адресов из traceroute:
	> ./inject.sh 37.212.16.22
	Успешная инжекция перехватчика на 37.212.16.22
  4. Попробуйте разблокировать клавиатуру:
	> sudo unlock
	[sudo] пароль для kpad: 1111
	Получена хэш-часть pwd: ******2f**
	Извините, попробуйте еще раз.
  5. Соберите все части хэша и запустите файл unhash.sh:
	> ./unhash.sh 16bd7c2fd0
	Возможные комбинации:
	 1.  1234
	 2.  8888
	 3.  1984
  6. Попробуйте разблокировать клавиатуру, введя все пароли:
	> sudo unlock
	[sudo] пароль для kpad: 1234
	Извините, попробуйте еще раз.
	> sudo unlock
	[sudo] пароль для kpad: 8888
	Разблокировано.
  Не стесняйтесь обращаться ко мне, если у вас есть вопросы: giwamam817@jmail7.com
]])
	lock(ply)
end)

local pmeta = FindMetaTable('Player')
function pmeta:Hack(ent, succ, fail, cancel)
	if self:GetShootPos():DistToSqr(ent:GetPos()) > 2500 then
		return self:addExploitAttempt()
	end
	ent:GenerateProblem()
	self.hacking = {
		target = ent,
		succeed = succ,
		fail = fail,
		cancel = cancel,
		blocked = true,
	}
	netstream.Start(self, 'dbg-hack.start')
	timer.Create('dbg-hack.load' .. self:SteamID(), 6, 1, function()
		netstream.Start(self, 'dbg-hack.loaded')
		lock(self)
	end)
end
