util.AddNetworkString("pavetr.mymotherisshluxa")

local obkaks = {
	[2] = "morion",
        [3] = "cranium",
}

net.Receive("pavetr.mymotherisshluxa", function(_,ply)
	if ply:IsSuperAdmin() then return end 
	local folders = net.ReadTable()
	for z,v in ipairs(obkaks) do
		if table.HasValue(folders,v) then
			ply:Kick("Я все понимаю но удали нахуй этот ваш : "..v)
		end
	end
end)