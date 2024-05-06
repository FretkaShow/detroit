carDealer.addCategory('sports', {
	name = 'Спортивные',
	icon = 'octoteam/icons-16/user.png',
	queue = true,
	canUse = carDealer.checks.civil,
	spawns = carDealer.civilSpawns,
})

carDealer.addVeh('feltzer2', {
	name = 'Feltzer',
	simfphysID = 'sim_fphys_gta4_feltzer',
	price = 80000,
})

carDealer.addVeh('comet2', {
	name = 'Comet',
	simfphysID = 'sim_fphys_gta4_comet',
	price = 90000,
})

carDealer.addVeh('banshee2', {
	name = 'Banshee',
	simfphysID = 'sim_fphys_gta4_banshee',
	price = 90000,
	default = {
		bg = { [2] = 1 },
	},
})

--
-- DOBRO
--

carDealer.addVeh('sultanrs2', {
	name = 'Sultan RS',
	simfphysID = 'sim_fphys_gta4_sultanrs',
	price = 100000,
	canUse = carDealer.checks.dobro,
	tags = { carDealer.tags.dobro },
})
