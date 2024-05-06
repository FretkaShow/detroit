local hook_Add = hook.Add
local floor = math.floor

if _G.LOGSLOADED then
    log({
        title = 'LUA перезапущено',
        text = '**Хз какие-то непонятные изменение в файлах**'
    })
else
    log({
        title = 'Сервер запущен',
        text = ('Название сервера: **%s**\n\tКарта сервера: **%s**\n\tIP сервера: **%s**'):format(GetHostName(), game.GetMap(), game.GetIPAddress()),
        tags = '#runtime'
    })
    _G.LOGSLOADED = true
end


function date(number)
    local hours = floor(number/3600)
    local minutes = floor(number%3600/60)
    local seconds = floor(number%3600%60)
    return ('%s:%s:%s'):format(hours, minutes, seconds)
end

hook_Add('ShutDown', 'doberman.logs', function()
    log({
        title = 'Сервер выключен',
        text = ('Сервер выключен ожидаемо (ShutDown).\n\tВремя работы сервера: *%s*\n\tОнлайн: **%s**/**%s**')
        :format(date(CurTime()),player.GetCount(),game.MaxPlayers()),
        tags = '#shutdown'
    })
end)

hook_Add('PlayerInitialSpawn', 'doberman.logs', function(pl)
    log({
        text = ('Игрок подключился к серверу\n\t**%s** (%s)\n\tОнлайн: **%s**/**%s**')
        :format(pl:Name(),pl:IsBot() and 'Бот' or pl:SteamID(),player.GetCount(),game.MaxPlayers()),
        tags = '#connect'
    })
end)

hook_Add('PlayerDisconnected', 'doberman.logs', function(pl)
    log({
        text = ('Игрок отключился от сервера\n\t**%s** (%s)\n\tОнлайн: **%s**/**%s**')
        :format(pl:Name(),pl:IsBot() and 'Бот' or pl:SteamID(),player.GetCount()-1,game.MaxPlayers()),
        tags = '#disconnect'
    })
end)

hook_Add('serverguard.PostPlayerBanned', 'doberman.logs', function(admin, player, reason, time)
    local adminName = IsValid(admin) and '**' .. admin:Name() .. '** ('..admin:SteamID()..')' or '_**CONSOLE**_'
    local playerName = IsEntity(player) and '**' .. player:Name() .. '** ('..player:SteamID()..')' or player
    local time = time == 0 and '**перманентно**' or time .. ' минут'
    log({
        title = 'Наказание',
        text = ('Администратор: %s\n\tНарушитель: %s\n\tСрок: %s\n\tПричина: *%s*')
        :format(adminName, playerName, time, reason),
        color = 11862062,
        tags = '#ban'
    },"https://discord.com/api/webhooks/1221853021797875822/O3MgQcoVg2JilrdKcklrcp_XyegrzySH669F7NnzDPOVLwjXf7dZeNXXBJbuLGxYxMhw")
end)

hook_Add('serverguard.PostPlayerUnBanned', 'doberman.logs', function(admin, steamid)
    local adminName = IsValid(admin) and '**' .. admin:Name() .. '** ('..admin:SteamID()..')' or '_**CONSOLE**_'
    log({
        title = 'Снятие наказания',
        text = ('Администратор: %s\n\tSteamID забаненного: %s'):format(adminName, steamid),
        color = 3277026,
        tags = '#unban'
    },"https://discord.com/api/webhooks/1221853021797875822/O3MgQcoVg2JilrdKcklrcp_XyegrzySH669F7NnzDPOVLwjXf7dZeNXXBJbuLGxYxMhw")
end)

hook.Add('OnPlayerChangedTeam', 'doberman.logs', function(ply, old, new)
    if not IsValid(ply) then return end
	if not ply:IsPlayer() then return end

    log({
        title = 'Смена работы',
        text = ('Игрок: **%s** ([%s](%s))\n\tСменил работу: **%s** ➞ **%s**'):format(ply:Name(), ply:SteamID(), ply:GetURL(), team.GetName(old), team.GetName(new)),
        tags = '#job-change'
    },"https://discord.com/api/webhooks/1221852951065137333/dR3O3VBnIt2w19Wav-EksgOkuARtusk9TQiVl0BaUuplqpZZj2Bh2i1Yvrtg8bkQ9uiu")
end)

hook.Add('PlayerSay', 'doberman.logs', function(ply, text)
    if not IsValid(ply) then return end
	if text == "" then return end

    log({
        title = 'Лог чата',
        text = ('Игрок: **%s** ([%s](%s))\n\tнаписал: **%s**'):format(ply:Name(), ply:SteamID(), ply:GetURL(), text),
        tags = '#chat'
    },"https://discord.com/api/webhooks/1221853185447301141/Op70j7KR4n_tQcRdD_qFO4tzXnO9-fqOF26NHKlAXK_scSDfG_SdufZRNXqXXMA2lFfZ")
end)

hook.Add('PlayerSpawnedProp', 'doberman.logs', function(ply, model, ent)
	if not IsValid(ply) then return end
	if table.HasValue({}, weapon) then return end

    log({
        title = 'Лог спавна пропов',
        text = ('Игрок: **%s** ([%s](%s))\n\tзаспавнил проп: **%s**'):format(ply:Name(), ply:SteamID(), ply:GetURL(), model),
        tags = '#prop-spawn'
    },"https://discord.com/api/webhooks/1221853284940255323/Zz5uSiH1x0yq5-UnoWZ6bQ4WCvy8SrkJkjaDHLw1MG1gJuFCfsBOnLmAdi6unJV66XP_")
end)

hook.Add('fspectate.start', 'doberman.logs', function(ply, target)
    log({
        title = 'Вход в режим spectate',
        text = ('Админ: **%s** ([%s](%s))\n\tНачал следить за: **%s** ([%s](%s))'):format(ply:Name(), ply:SteamID(), ply:GetURL(), IsValid(target) and target:Name() or "pidor", IsValid(target) and target:SteamID() or "nothing", target:GetURL()),
        tags = '#start-spectate'
    },"https://discord.com/api/webhooks/1221853021797875822/O3MgQcoVg2JilrdKcklrcp_XyegrzySH669F7NnzDPOVLwjXf7dZeNXXBJbuLGxYxMhw")
end)

hook.Add('fspectate.end', 'doberman.logs', function(ply)
	log({
        title = 'Выход из режима spectate',
        text = ('Админ: **%s** ([%s](%s))\n\tВышел из режима spectate'):format(ply:Name(), ply:SteamID(), ply:GetURL()),
        tags = '#end-spectate'
    },"https://discord.com/api/webhooks/1221853021797875822/O3MgQcoVg2JilrdKcklrcp_XyegrzySH669F7NnzDPOVLwjXf7dZeNXXBJbuLGxYxMhw")
end)

hook.Add('PlayerDeath', 'doberman.logs', function(ply, ent, killer)
    if killer:IsPlayer() then
        local weapon = (IsValid(killer:GetActiveWeapon()) and killer:GetActiveWeapon():GetClass() or 'unknown')
        log({
            title = 'Логи убийство игроков',
            text = ('Игрок: **%s** ([%s](%s))\n\tУбил игрока: **%s** ([%s](%s))\n\t используя оружие: **%s**\n\tПолиции онлайн: **%s**'):format(killer:Name(), killer:SteamID(), killer:GetURL(), ply:Name(), ply:SteamID(), ply:GetURL(), weapon, tostring(#player.GetPolice())),
            tags = '#kill-players'
        },"https://discord.com/api/webhooks/1221852577403109397/FitPLnyVeb0KcoMcZEVhzxtc484q8KZz5-IwT0PeemcGiGjdcLLHxKo4YvRMePxpy4yB")
    end
end)

hook.Add('EntityTakeDamage', 'doberman.logs', function( ent, dmginfo )
    if not ent:IsPlayer() then return end
	local weapon = ''
	local attacker = dmginfo:GetAttacker()

	if not IsValid(attacker) or not attacker:IsPlayer() then return end
	local dmg = math.Round(dmginfo:GetDamage(), 0)
	if dmg < 1 then return end

	local killer = attacker:Name()
	local killerid = attacker:SteamID()
	local killerurl = attacker:GetURL()

	weapon = (IsValid(attacker:GetActiveWeapon()) and attacker:GetActiveWeapon():GetClass() or 'unknown')

	log({
        title = 'Логи урона игроков',
        text = ('Игрок: **%s** ([%s](%s))\n\tПолучил урон в: **%s единиц**\n\t Игрок наснесший урон: **%s** ([%s](%s))\n\t используемое оружие: **%s**\n\tПолиции онлайн: **%s**'):format(ent:Name(), ent:SteamID(), ent:GetURL(), dmg, killer, killerid, killerurl, weapon, tostring(#player.GetPolice())),
        tags = '#damage-players'
    },"https://discord.com/api/webhooks/1221852646940610661/Zcv43_UJksGY343KO3G8WfPBg509D27I1fttWNv0Iij1ux36et_Vzgpu20uOujU_AXCW")
end)

hook.Add('playerArrested', 'doberman.logs', function(ply, time, cop, reason)
	log({
        title = 'Логи ареста игроков',
        text = ('Офицер: **%s** ([%s](%s))\n\tарестовал игрока: **%s** ([%s](%s))\n\t Причина: **%s**'):format(cop:Name(), cop:SteamID(), cop:GetURL(), ply:Name(), ply:SteamID(), ply:GetURL(), reason),
        tags = '#arrest-players'
    },"https://discord.com/api/webhooks/1221852795507048528/QDuH-KLTdR5ANjN63_aHoohPb0H8z5OBz9HsEXevqhQ9x52M8kmfFQdpTd-YHNNNJN3x")
end)

hook.Add('playerUnArrested', 'doberman.logs', function(ply, time, cop, reason)
	log({
        title = 'Логи ареста игроков',
        text = ('Офицер: **%s** ([%s](%s))\n\tснял арест игроку: **%s** ([%s](%s))'):format(cop:Name(), cop:SteamID(), cop:GetURL(), ply:Name(), ply:SteamID(), ply:GetURL()),
        tags = '#unarrest-players'
    },"https://discord.com/api/webhooks/1221852795507048528/QDuH-KLTdR5ANjN63_aHoohPb0H8z5OBz9HsEXevqhQ9x52M8kmfFQdpTd-YHNNNJN3x")
end)

local noLogCmds = octolib.array.toKeys({ 'mute', 'gag', 'invisible' })
hook.Add('serverguard.RanCommand', 'doberman.logs', function(ply, commandTable, silent, _args)

	local cmdStr = commandTable.command
	if noLogCmds[cmdStr] or noLogCmds[cmdStr:gsub('un', '')] then return end

	if _args and #_args > 0 then
		cmdStr = cmdStr .. ' ' .. table.concat(_args, ' ')
	end
    log({
        title = 'Логи админ комманд',
        text = ('Админ: **%s** ([%s](%s))\n\tИспользовал комманду: **%s**'):format(ply:Name(), ply:SteamID(), ply:GetURL(), cmdStr),
        tags = '#admin-commands'
    },"https://discord.com/api/webhooks/1221853021797875822/O3MgQcoVg2JilrdKcklrcp_XyegrzySH669F7NnzDPOVLwjXf7dZeNXXBJbuLGxYxMhw")
end)

hook.Add('octoinv.adminGive', 'doberman.logs', function(ply, item)
	if item and IsValid(ply) and ply:IsPlayer() then
		local class = item.class
		local name = item.name or octoinv.items[item.class].name
		local itemStr = ('%sx[%s, %s]'):format(item.amount or 1, class, name)
        log({
            title = 'Логи выдачи предметов через инвентарь',
            text = ('Админ: **%s** ([%s](%s))\n\tВыдал себе в инвентарь: **%s**'):format(ply:Name(), ply:SteamID(), ply:GetURL(), itemStr),
            tags = '#inventory-give'
        },"https://discord.com/api/webhooks/1221853480801669263/At9rmKb59-GT9482fOjQC5sFd1B9Bp7sKC_7jJ1IhaRl-CHD2Qz3LTC1Xmz8Qi5o9gKV")
	end
end)

hook.Add('dbg-admin.tell', 'doberman.logs', function(ply, time, title, msg, target)
    log({
        title = 'Логи оповещений(admintell)',
        text = ('Админ: **%s** ([%s](%s))\n\tОтправил оповещение\n\tЗаголовок: **%s**\n\tСообщение: **%s**\n\tВремя действия: **%s**\n\tОтправлено: **%s**'):format(ply:Name(), ply:SteamID(), ply:GetURL(), title, msg, time, IsValid(target) and target:Name() or "всем"),
        tags = '#admin-tell'
    },"https://discord.com/api/webhooks/1221853541577130084/HTT3HzW24C6hlcwl38pxWZLIQ7kyW5c7ZyD9eaHRhq4vNsdovCjMmeo5HKXj8NwOkEzr")
end)

hook.Add('cats.created', 'doberman.logs', function(senderID)
    local sender = player.GetBySteamID(senderID)
    log({
        title = 'Игрок открыл тикет',
        text = ('Игрок: **%s** ([%s](%s)) Открыл тикет'):format(sender and sender:Name() or sender:SteamID(), sender:SteamID(), sender and sender:GetURL() or ""),
        tags = '#ticket-opened'
    },"https://discord.com/api/webhooks/1221853021797875822/O3MgQcoVg2JilrdKcklrcp_XyegrzySH669F7NnzDPOVLwjXf7dZeNXXBJbuLGxYxMhw")
end)

hook.Add('cats.message', 'doberman.logs', function(senderID, ticketID, msg)
    local sender = player.GetBySteamID(senderID)
    local owner = player.GetBySteamID(ticketID)
    log({
        title = 'Игрок отправил сообщение в тикет',
        text = ('Игрок: **%s** ([%s](%s))\n\t Отправил сообщение: **%s**\n\t В тикет: **%s** ([%s](%s))'):format(IsValid(sender) and sender:Name() or senderID, senderID, IsValid(sender) and sender:GetURL() or "", msg, IsValid(owner) and owner:Name() or ticketID, ticketID, IsValid(owner) and owner:GetURL() or ""),
        tags = '#ticket-message'
    },"https://discord.com/api/webhooks/1221853021797875822/O3MgQcoVg2JilrdKcklrcp_XyegrzySH669F7NnzDPOVLwjXf7dZeNXXBJbuLGxYxMhw")
end)

hook.Add('cats.claim', 'doberman.logs', function(senderID, ticketID, doClaim)
    local sender = player.GetBySteamID(senderID)
    local owner = player.GetBySteamID(ticketID)
    log({
        title = 'Админ принял/отклонил тикет',
        text = ('Админ: **%s** ([%s](%s))\n\t %s тикет **%s** ([%s](%s))'):format(IsValid(sender) and sender:Name() or senderID, senderID, IsValid(sender) and sender:GetURL() or "", doClaim and "принял" or "отклонил", IsValid(owner) and owner:Name() or ticketID, ticketID, IsValid(owner) and owner:GetURL() or ""),
        tags = '#ticket-claimed/unclaimed'
    },"https://discord.com/api/webhooks/1221853021797875822/O3MgQcoVg2JilrdKcklrcp_XyegrzySH669F7NnzDPOVLwjXf7dZeNXXBJbuLGxYxMhw")
end)

hook.Add('cats.closed', 'doberman.logs', function(senderID, ticketID)
    local sender = player.GetBySteamID(senderID)
    local owner = player.GetBySteamID(ticketID)
    log({
        title = 'Админ закрыл тикет',
        text = ('Админ: **%s** ([%s](%s))\n\t закрыл тикет **%s** ([%s](%s))'):format(IsValid(sender) and sender:Name() or senderID, senderID, IsValid(sender) and sender:GetURL() or "", IsValid(owner) and owner:Name() or ticketID, ticketID, IsValid(owner) and owner:GetURL() or ""),
        tags = '#ticket-closed'
    },"https://discord.com/api/webhooks/1221853021797875822/O3MgQcoVg2JilrdKcklrcp_XyegrzySH669F7NnzDPOVLwjXf7dZeNXXBJbuLGxYxMhw")
end)

local dontLogTools = octolib.array.toKeys({ 'remover','precision','material','submaterial','weld','rope','colour','advmat','shadowremover', 'imgscreen' })
hook.Add('CanTool', 'doberman.logs', function(ply, tr, tool)
	if dontLogTools[tool] then return end

    log({
        title = 'Логи использования инструментов',
        text = ('Игрок: **%s** ([%s](%s))\n\t использовал инструмент **%s**'):format(ply:Name(), ply:SteamID(), ply:GetURL(), tool),
        tags = '#tool-used'
    },"https://discord.com/api/webhooks/1221853396861059122/3eV1co2nSrpy4Dhl3zUXEMZK2OHDMcKrCcypLrQc-Fzz6084rir-JSQ6k9pdH4qMBtoH")
end)

hook.Add('atm.withdraw', 'doberman.logs', function(ply, amount)
    log({
        title = 'Логирование Bank',
        text = ('Игрок: **%s** ([%s](%s))\n\t снял с своего счета в банке: **%s**'):format(ply:Name(), ply:SteamID(), ply:GetURL(), DarkRP.formatMoney(amount)),
        tags = '#withdraw-atm'
    },"https://discord.com/api/webhooks/1221852878147289231/nI06z8FwWH7JyEN8JgT9MO0VHT_X9RHj4yi2g1xFZPfT3VNY0LgigdC3quPYB184riHx")
end)

hook.Add('atm.deposit', 'doberman.logs', function(ply, amount)
    log({
        title = 'Логирование Bank',
        text = ('Игрок: **%s** ([%s](%s))\n\t внес на свой счет в банке: **%s**'):format(ply:Name(), ply:SteamID(), ply:GetURL(), DarkRP.formatMoney(amount)),
        tags = '#deposit-atm'
    },"https://discord.com/api/webhooks/1221852878147289231/nI06z8FwWH7JyEN8JgT9MO0VHT_X9RHj4yi2g1xFZPfT3VNY0LgigdC3quPYB184riHx")
end)

hook.Add('dbg-police.call', 'doberman.logs', function(ply, nick, text, sentPos)
    log({
        title = 'Звонок в 911',
        text = ('Игрок: **%s** ([%s](%s)) Вызвал полицию\n\t Описание ситуации: **%s**\n\t Координаты вызова: **%s**\n\tПолиции онлайн: **%s**'):format(ply:Name(), ply:SteamID(), ply:GetURL(), text, ply:GetPos(), tostring(#player.GetPolice())),
        tags = '#call-police'
    },"https://discord.com/api/webhooks/1221852795507048528/QDuH-KLTdR5ANjN63_aHoohPb0H8z5OBz9HsEXevqhQ9x52M8kmfFQdpTd-YHNNNJN3x")
end)

hook.Add('tazer.tazed', 'doberman.logs', function(ply, victim)
	log({
        title = 'Логи полицейского тайзера',
        text = ('Офицер: **%s** ([%s](%s))\n\t Использовал тайзер на игрока: **%s** ([%s](%s))\n\tПолиции онлайн: **%s**'):format(ply:Name(), ply:SteamID(), ply:GetURL(), victim:Name(), victim:SteamID(), victim:GetURL(), tostring(#player.GetPolice())),
        tags = '#police-tazer'
    },"https://discord.com/api/webhooks/1221852795507048528/QDuH-KLTdR5ANjN63_aHoohPb0H8z5OBz9HsEXevqhQ9x52M8kmfFQdpTd-YHNNNJN3x")
end)

hook.Add('OnHandcuffed', 'octologs', function(cop, ply, cuff)
    log({
        title = 'Логи использования наручников',
        text = ('Игрок: **%s** ([%s](%s))\n\t Заковал игрока игрока: **%s** ([%s](%s))\n\tТип наручников: **%s**\n\tПолиции онлайн: **%s**'):format(cop:Name(), cop:SteamID(), cop:GetURL(), ply:Name(), ply:SteamID(), ply:GetURL(), cuff.CuffType, tostring(#player.GetPolice())),
        tags = '#cuff-log'
    },"https://discord.com/api/webhooks/1221852795507048528/QDuH-KLTdR5ANjN63_aHoohPb0H8z5OBz9HsEXevqhQ9x52M8kmfFQdpTd-YHNNNJN3x")
end)

hook.Add('OnHandcuffBreak', 'octologs', function(ply, cuff, mate)
    log({
        title = 'Логи использования наручников',
        text = ('Игрок: **%s** ([%s](%s))\n\t был освобожден из наручников: **%s**\n\tПолиции онлайн: **%s**'):format(ply:Name(), ply:SteamID(), ply:GetURL(), cuff.CuffType or 'unknown', tostring(#player.GetPolice())),
        tags = '#uncuff-log'
    },"https://discord.com/api/webhooks/1221852795507048528/QDuH-KLTdR5ANjN63_aHoohPb0H8z5OBz9HsEXevqhQ9x52M8kmfFQdpTd-YHNNNJN3x")
end)

hook.Add('dbg.evacuation', 'octologs', function(car, cop, owner)
    log({
        title = 'Логи эвакуации транспорта',
        text = ('Офицер: **%s** ([%s](%s))\n\t запросил эвакуацию автомобиля\n\t Владелец автомобиля: **%s** ([%s](%s))\n\tМодель автомобиля: **%s**'):format(cop:Name(), cop:SteamID(), cop:GetURL(), owner:Name(), owner:SteamID(), owner:GetURL(), car),
        tags = '#evacuation-log'
    },"https://discord.com/api/webhooks/1221852795507048528/QDuH-KLTdR5ANjN63_aHoohPb0H8z5OBz9HsEXevqhQ9x52M8kmfFQdpTd-YHNNNJN3x")
end)