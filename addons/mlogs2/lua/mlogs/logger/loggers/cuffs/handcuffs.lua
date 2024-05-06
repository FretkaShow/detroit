--[[
	mLogs 2 (M4D Logs 2)
	Created by M4D | http://m4d.one/ | http://steamcommunity.com/id/m4dhead |
	Copyright © 2018 M4D.one All Rights Reserved
	All 3rd party content is public domain or used with permission
	M4D.one is the copyright holder of all code below. Do not distribute in any circumstances.
--]]

local category = "cuffs"
// Handcuff Logs
mLogs.addLogger("Handcuffs","handcuffs",category)
mLogs.addHook("OnHandcuffed", category, function(ply,target)
    if (not IsValid(ply) or not IsValid(target)) then return end
    mLogs.log("handcuffs",category,{player1=mLogs.logger.getPlayerData(ply),target=mLogs.logger.getPlayerData(ply)})
end)