carDealer.addCategory('4doors', {
	name = 'Четырехдверные',
	icon = 'octoteam/icons-16/user.png',
	queue = true,
	canUse = carDealer.checks.civil,
	spawns = carDealer.civilSpawns,
})

carDealer.addVeh('premier2', {
	name = 'Premier',
	simfphysID = 'sim_fphys_gta4_premier',
	price = 13500,
})

carDealer.addVeh('esperanto2', {
	name = 'Esperanto',
	simfphysID = 'sim_fphys_gta4_esperanto',
	price = 18000,
})

carDealer.addVeh('dilettante2', {
	name = 'Dilettante',
	simfphysID = 'sim_fphys_gta4_dilettante',
	price = 11500,
})

carDealer.addVeh('merit2', {
	name = 'Merit',
	simfphysID = 'sim_fphys_gta4_merit',
	price = 20000,
})

carDealer.addVeh('df2', {
	name = 'DF8-90',
	simfphysID = 'sim_fphys_gta4_df8',
	price = 25000,

})

carDealer.addVeh('emperor2', {
	name = 'Emperor',
	simfphysID = 'sim_fphys_gta4_emperor',
	price = 27000,
})

carDealer.addVeh('schafter2', {
	name = 'Schafter',
	simfphysID = 'sim_fphys_gta4_schafter',
	price = 30000,

})

carDealer.addVeh('vincent2', {
	name = 'Vincent',
	simfphysID = 'sim_fphys_gta4_vincent',
	price = 33000,
	tags = { carDealer.tags.new },

})

carDealer.addVeh('admiral2', {
	name = 'Admiral',
	simfphysID = 'sim_fphys_gta4_admiral',
	price = 35000,
})

carDealer.addVeh('cognoscenti2', {
	name = 'Cognoscenti',
	simfphysID = 'sim_fphys_gta4_cognoscenti',
	price = 32000,
})

carDealer.addVeh('superdiamond2', {
	name = 'Super Diamond',
	simfphysID = 'sim_fphys_tbogt_superd',
	price = 32000,
	tags = { carDealer.tags.new },
})

carDealer.addVeh('superdiamond-coupe2', {
	name = 'Super Diamond Coupe',
	simfphysID = 'sim_fphys_tbogt_superd2',
	price = 50000,
	tags = { carDealer.tags.new },
})

--
-- DOBRO
--

carDealer.addVeh('hakumai2', {
	name = 'Hakumai',
	simfphysID = 'sim_fphys_gta4_hakumai',
	price = 1125000,
	bodygroups = {
		[1] = {
			name = 'Пороги',
			variants = {
				{ 'Заводские', 500 },
				{ 'Тюнер', 70000 },
			},
		},
		[2] = {
			name = 'Спойлер',
			variants = {
				{ 'Заводской', 500 },
				{ 'Тюнер', 90000 },
			},
		},
		[3] = {
			name = 'Передний бампер',
			variants = {
				{ 'Заводской', 500 },
				{ 'Тюнер', 72500 },
			},
		},
		[4] = {
			name = 'Огни',
			variants = {
				{ 'Заводские', 500 },
				{ 'Противотуманки', 47500 },
			},
		},
	},
	canUse = carDealer.checks.dobro,
	tags = { carDealer.tags.dobro },
})

--
-- EVENT
--

carDealer.addVeh('halloween_pickup', {
	name = 'Regina',
	simfphysID = 'sim_fphys_tlad_regina',
	price = 0,
	tags = { carDealer.tags.halloween },
	canSee = carDealer.checks.no,
	canUse = carDealer.checks.civil,
})
