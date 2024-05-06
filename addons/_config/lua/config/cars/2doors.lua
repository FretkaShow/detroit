carDealer.addCategory('2doors', {
	name = 'Двухдверные',
	icon = 'octoteam/icons-16/user.png',
	queue = true,
	canUse = carDealer.checks.civil,
	spawns = carDealer.civilSpawns,
})

-- carDealer.addVeh('faction2', {
-- 	name = 'Faction',
-- 	simfphysID = 'sim_fphys_gta4_faction',
-- 	price = 0,
-- 	bodygroups = {
-- 		[1] = {
-- 			name = 'Крыша',
-- 			variants = {
-- 				{ 'Заводская', 1000 },
-- 				{ 'Стекло', 35000 },
-- 			},
-- 		},
-- 		[2] = {
-- 			name = 'Капот',
-- 			variants = {
-- 				{ 'Заводской', 1000 },
-- 				{ 'С выступом', 50000 },
-- 			},
-- 		},
-- 	},
-- })

carDealer.addVeh('fortune2', {
	name = 'Fortune',
	simfphysID = 'sim_fphys_gta4_fortune',
	price = 30000,
})

carDealer.addVeh('vigero2', {
	name = 'Vigero',
	simfphysID = 'sim_fphys_gta4_vigero',
	price = 35000,
})

carDealer.addVeh('rhapsody2', {
	name = 'Rhapsody',
	simfphysID = 'sim_fphys_tlad_rhapsody',
	price = 40000,
	tags = { carDealer.tags.new },
})

carDealer.addVeh('sabre2', {
	name = 'Sabre',
	simfphysID = 'sim_fphys_gta4_sabre',
	price = 25000,
})

carDealer.addVeh('manana2', {
	name = 'Manana',
	simfphysID = 'sim_fphys_gta4_manana',
	price = 35000,
	bodygroups = {
		[1] = {
			name = 'Крыша',
			variants = {
				{ 'Заводская', 500 },
				{ 'Закрытая', 95000 },
			},
		},
	},
})

carDealer.addVeh('ruiner2', {
	name = 'Ruiner',
	simfphysID = 'sim_fphys_gta4_ruiner',
	price = 40000,
	tags = { carDealer.tags.new },
	default = {
		bg = { [2] = 1, [3] = 1 },
	},
	bodygroups = {
		[1] = {
			name = 'Капот',
			variants = {
				{ 'Заводской', 500 },
				{ 'С вентиляцией', 37500 },
			},
		},
		[2] = {
			name = 'Крыша',
			variants = {
				{ 'Панорамная', 87500 },
				{ 'Заводская', 500 },
			},
		},
		[3] = {
			name = 'Багажник',
			variants = {
				{ 'Открытый', 40000 },
				{ 'Заводской', 500 },
			},
		},
	},
})

carDealer.addVeh('sabregt2', {
	name = 'Sabre GT',
	simfphysID = 'sim_fphys_gta4_sabregt',
	price = 50000,
	tags = { carDealer.tags.new },
	bodygroups = {
		[1] = {
			name = 'Капот',
			variants = {
				{ 'Заводской', 500 },
				{ 'С воздухозаборником', 62500 },
				{ 'С выступом', 22500 },
			},
		},
	},
})

carDealer.addVeh('futo2', {
	name = 'Futo',
	simfphysID = 'sim_fphys_gta4_futo',
	price = 50000,
	bodygroups = {
		[1] = {
			name = 'Бампер',
			variants = {
				{ 'Заводской', 500 },
				{ 'Тюнер', 37500 },
			},
		},
		[2] = {
			name = 'Тюнинг',
			variants = {
				{ 'Заводской', 500 },
				{ 'Рама, пороги, труба и сидение', 117500 },
			},
		},
		[3] = {
			name = 'Спойлер',
			variants = {
				{ 'Заводской', 500 },
				{ 'Тюнер', 47500 },
			},
		},
		[4] = {
			name = 'Капот',
			variants = {
				{ 'Заводской', 500 },
				{ 'Карбон', 80000 },
			},
		},
	},
})

--
-- EVENT
--

carDealer.addVeh('halloween_sedan', {
	name = 'Peyote',
	simfphysID = 'sim_fphys_gta4_peyote',
	price = 0,
	tags = { carDealer.tags.halloween },
	canSee = carDealer.checks.no,
	canUse = carDealer.checks.civil,
	bodygroups = {
		[1] = {
			name = 'Крыша',
			variants = {
				{ 'Заводская', 500 },
				{ 'Закрытая', 160000 },
			},
		},
		[2] = {
			name = 'Заднее крепление',
			variants = {
				{ 'Ничего', 500 },
				{ 'Запаска', 92500 },
			},
		},
		[3] = {
			name = 'Сидения',
			variants = {
				{ 'Заводские', 500 },
				{ 'Зебра', 105000 },
				{ 'Черные', 37500 },
			},
		},
	},
})
