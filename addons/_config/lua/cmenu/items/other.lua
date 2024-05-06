octogui.cmenu.registerItem('other', 'idea', {
	text = L.idea,
	icon = octolib.icons.silk16('lightbulb'),
	say = '/dbg_getidea',
})

octogui.cmenu.registerItem('other', 'nrp', {
	text = L.nonrp_actions,
	icon = octolib.icons.silk16('world'),
	options = {
		{
			text = L.applications_and_ticket,
			icon = octolib.icons.silk16('page_error'),
			url = 'https://discord.gg/4Ke8DVGB',
		}, {
			text = L.send_pm,
			icon = octolib.icons.silk16('email'),
			build = function(sm)
				local ply = LocalPlayer()
				local _players = player.GetAll()
				table.sort(_players, function(a, b) return a:GetName() < b:GetName() end)

				for _, v in ipairs(_players) do
					if v ~= ply then
						local name = v:Name()
						sm:AddOption(v:SteamName() .. ' (' .. name .. ')', octolib.fStringRequest(L.send_pm_hint .. v:SteamName() .. ' (' .. name .. ')', L.send_text, '', function(s)
							octochat.say('/pm', ('"%s"'):format(name), s)
						end, nil, L.ok, L.cancel)):SetColor(v:getJobTable().color)
					end
				end
			end,
		}, {
			text = L.links,
			icon = octolib.icons.silk16('link'),
			options = {
				{text = L.discord, url = 'https://discord.gg/qD2n4yWkxZ' },
				{text = L.rules, url = 'https://docs.google.com/document/d/15lSy3jHxOSRo8rPIbd_XsAsPTsxp51aQzWEXeP01atc/edit?usp=sharing' },
			},
		}
	},
})
