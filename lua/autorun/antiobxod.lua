hook.Add("PlayerAuthed", "AntiShared", function(ply)
	if ply:OwnerSteamID64() != ply:SteamID64() then
		RunConsoleCommand("sg", "ban", ply:SteamID(), "0", "Пошел нахуй обходчик!")
	end
end)