carDealer.addCategory('pickups', {
	name = 'Пикапы',
	icon = 'octoteam/icons-16/user.png',
	queue = true,
	canUse = carDealer.checks.civil,
	spawns = carDealer.civilSpawns,
})

carDealer.addVeh('bobcat2', {
	name = 'Bobcat',
	simfphysID = 'sim_fphys_gta4_bobcat',
	price = 15000,
	bodygroups = {
		[1] = {
			name = 'Стойка',
			variants = {
				{ 'Заводская', 500 },
				[5] = { 'Укрепленная', 35000 },
			},
		},
		[2] = {
			name = 'Багажник',
			variants = {
				{ 'Заводской', 500 },
				{ 'Маленький', 25000 },
				{ 'Полный', 60000 },
			},
		},
		[3] = {
			name = 'Бампер',
			variants = {
				{ 'Заводской', 500 },
				{ 'Кенгурятник', 40000 },
			},
		},
	},
})

carDealer.addVeh('rancher2', {
	name = 'Rancher',
	simfphysID = 'sim_fphys_gta4_rancher',
	price = 30000,
	bodygroups = {
		[1] = {
			name = 'Кузов',
			variants = {
				{ 'Заводской', 1000 },
				{ 'Короб', 550000 },
				{ 'Стойка', 180000 },
			},
		},
		[2] = {
			name = 'Бампер',
			variants = {
				{ 'Заводской', 1000 },
				{ 'Кенгурятник', 90000 },
				{ 'Фонари', 95000 },
			},
		},
	},
})

carDealer.addVeh('contender2', {
	name = 'Contender',
	simfphysID = 'sim_fphys_gta4_e109',
	price = 40000,
	bodygroups = {
		[1] = {
			name = 'Кузов',
			variants = {
				{ 'Заводской', 1000 },
				{ 'Козырек + покрытие', 325000 },
				{ 'Жеское покрытие', 280000 },
				{ 'Козырек', 65000 },
				{ 'Стойка + покрытие', 450000 },
			},
		},
		[2] = {
			name = 'Бампер',
			variants = {
				{ 'Заводской', 1000 },
				{ 'Кенгурятник', 145000 },
			},
		},
	},
})
