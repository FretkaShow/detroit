carDealer.addCategory('police', {
	name = 'Полицейские',
	ems = true,
	icon = 'octoteam/icons-16/user_policeman_white.png',
	canUse = function(ply) return ply:isCP() and ply:Team() ~= TEAM_FBI and ply:Team() ~= TEAM_WCSO and ply:Team() ~= TEAM_MAYOR, 'Доступно только полиции' end,
	spawns = carDealer.policeSpawns,
	spawnCheck = carDealer.limits.police,
	limitGroup = 'police',
})

carDealer.addVeh('police-vapid', {
	category = 'police',
	name = 'Police Vapid',
	simfphysID = 'sim_fphys_gta4_police',
	price = 15000,
	deposit = true,
	police = true,
	radioWhitelist = carDealer.policeRadioStations,
	default = {
		mats = {
			[1] = 'octoteam/models/vehicles/stainer/sheriff_livery_clr_1',
		},
	},
})

carDealer.addVeh('police-merit', {
	category = 'police',
	name = 'Police Merit',
	simfphysID = 'sim_fphys_gta4_police2',
	price = 20000,
	deposit = true,
	police = true,
	radioWhitelist = carDealer.policeRadioStations,
	default = {
		mats = {
			[14] = 'octoteam/models/vehicles/merit/sheriff2_livery_clr_1',
		},
	},
})



-- carDealer.addVeh('police-patriot', {
-- 	category = 'police',
-- 	name = 'Police Patriot',
-- 	simfphysID = 'sim_fphys_gta4_polpatriot',
-- 	price = 50000,
-- 	deposit = true,
-- 	police = true,
-- 	canUse = carDealer.checks.dobro,
-- 	tags = { carDealer.tags.dobro },
--	radioWhitelist = carDealer.policeRadioStations,
-- })

carDealer.addVeh('police-buffalo', {
	category = 'police',
	name = 'Police Buffalo',
	simfphysID = 'sim_fphys_tbogt_police3',
	price = 50000,
	deposit = true,
	police = true,
	canUse = function(ply)
		if ply:Team() == TEAM_DPD then return true end
		if ply:isCP() and ply:Team() ~= TEAM_FBI and ply:Team() ~= TEAM_MAYOR then return carDealer.checks.dobro(ply) end
		return false
	end,
	tags = { carDealer.tags.dobro },
	radioWhitelist = carDealer.policeRadioStations,
	default = {
		mats = {
			[6] = 'octoteam/models/vehicles/buffalo/sheriff3_livery_clr_1',
		},
	},
})

-- carDealer.addVeh('police-enforcer', {
-- 	category = 'police',
-- 	name = 'Enforcer',
-- 	simfphysID = 'sim_fphys_gta4_nstockade',
-- 	price = 55000,
-- 	customFOV = 38,
-- 	deposit = true,
-- 	police = true,
-- 	bulletproof = true,
-- 	canUse = carDealer.checks.dobro,
-- 	tags = { carDealer.tags.dobro },
--	radioWhitelist = carDealer.policeRadioStations,
-- })
