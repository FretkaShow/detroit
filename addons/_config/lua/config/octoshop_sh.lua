--
-- SALARY
--

octoshop.salaryAFKTime = 45 -- seconds
octoshop.salaryPeriod = 60 -- minutes

--
-- MISC FUNCTIONS
--

octoshop.openTopup = function(but, pnl)

	F4:Hide()
	gui.ActivateGameUI()
	octoesc.OpenURL('https://octothorp.team/shop/chips?steamid=' .. LocalPlayer():SteamID())

end

local owners = {
	['STEAM_0:1:114830533'] = true, -- voole
	['STEAM_0:0:502099106'] = true, -- i26
}

octoshop.checkOwner = function(ply)

	return owners[ply:SteamID()]

end
