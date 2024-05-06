if (DarkRP.disabledDefaults.modules.hitmenu) then return end

local MODULE = GAS.Logging:MODULE()

MODULE.Category = "DarkRP"
MODULE.Name     = "Hits"
MODULE.Colour   = Color(255,0,0)

MODULE:Setup(function()
	MODULE:Hook("onHitAccepted","hitaccepted",function(hitman,target,customer)
		MODULE:LogPhrase("darkrp_hit_accepted", GAS.Logging:FormatPlayer(hitman), GAS.Logging:FormatPlayer(target), GAS.Logging:FormatPlayer(customer))
	end)

	MODULE:Hook("onHitCompleted","hitcompleted",function(hitman,target,customer)
		MODULE:LogPhrase("darkrp_hit_completed", GAS.Logging:FormatPlayer(hitman), GAS.Logging:FormatPlayer(target), GAS.Logging:FormatPlayer(customer))
	end)

	MODULE:Hook("onHitFailed","hitfailed",function(hitman,target,customer)
		MODULE:LogPhrase("darkrp_hit_failed", GAS.Logging:FormatPlayer(hitman), GAS.Logging:FormatPlayer(target), GAS.Logging:FormatPlayer(customer))
	end)

	MODULE:InferiorHook("canRequestHit","hitrequested",function(hitman,target,customer,price)
		MODULE:LogPhrase("darkrp_hit_requested", GAS.Logging:FormatPlayer(customer), GAS.Logging:FormatPlayer(target), GAS.Logging:FormatPlayer(hitman), GAS.Logging:FormatMoney(price))
	end)
end)

GAS.Logging:AddModule(MODULE)
