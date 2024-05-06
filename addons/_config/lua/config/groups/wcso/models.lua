local function addAll(...)
	local result = {}
	for _, tbl in ipairs({...}) do
		for _, v in ipairs(tbl) do
			result[#result + 1] = table.Copy(v)
		end
	end
	return result
end

local function addBgs(source, bgs)
	local result = table.Copy(source)
	for _, mdl in ipairs(result) do
		mdl.bgs = mdl.bgs or {}
		for k, v in pairs(bgs) do
			mdl.bgs[k] = v
		end
	end
	return result
end

local function addRequiredBgs(source, bgs)
	local result = table.Copy(source)
	for _, mdl in ipairs(result) do
		mdl.requiredBgs = mdl.requiredBgs or {}
		for k, v in pairs(bgs) do
			mdl.requiredBgs[k] = v
		end
	end
	return result
end

local function removeBgs(source, ...) -- in honor of kilo-7
	local result = table.Copy(source)
	for _, mdl in ipairs(result) do
		if not mdl.bgs then continue end
		for _, bg in ipairs({...}) do
			mdl.bgs[bg] = nil
		end
		if not next(mdl.bgs) then mdl.bgs = nil end
	end
	return result
end

local function modify(source, modify)
	local result = table.Copy(source)
	for _, mdl in ipairs(result) do
		for k, v in pairs(modify) do
			mdl[k] = v
		end
	end
	return result
end

local patrolModels, utilityModels, everydayModels, swatModels = {}, {}, {}, {}

local clothesData = {
	icon = 'sheriff',
	['models/player/octo_sheriff/'] = {
		{
			sm = 'Головной убор',
			icon = 'hat',
			bodygroup = 3,
			vals = {
				[0] = { 'Надеть шляпу', 'bullet_blue', '/me надевает шляпу на голову' },
				[1] = { 'Надеть шлем', 'bullet_black', '/me надевает шлем на голову' },
				[2] = { 'Снять убор', 'cross', '/me снимает головной убор' },
			},
		},{
			sm = 'Перчатки',
			icon = 'hand',
			bodygroup = 6,
			vals = {
				[0] = { 'Снять', 'cross', '/me снимает перчатки' },
				[1] = { 'Надеть черные перчатки', 'bullet_black', '/me надевает черные перчатки' },
				[2] = { 'Надеть белые перчатки', 'bullet_white', '/me надевает белые перчатки' },
			},
		},{
			sm = 'Кобура тазера',
			icon = 'gun',
			bodygroup = 2,
			vals = {
				[0] = { 'Надеть кобуру тазера слева', 'arrow_left', '/me надевает кобуру с тазером слева' },
				[1] = { 'Надеть кобуру тазера справа', 'arrow_right', '/me надевает кобуру с тазером справа' },
				[2] = { 'Снять кобуру с тазером', 'cross', '/me снимает шлем с головы' },
			},
		},{
			bodygroup = 7,
			vals = {
				[0] = { 'Надеть рацию', 'bullet_blue', '/me надевает рацию себе на грудь' },
				[1] = { 'Снять рацию', 'cross', '/me снимает рацию с груди' },
			},
		},{
			bodygroup = 5,
			vals = {
				[0] = { 'Надеть дубинку', 'bullet_blue', '/me вешает дубинку обратно на пояс' },
				[1] = { 'Снять дубинку', 'cross', '/me снимает дубинку с пояса' },
			},
		},{
			bodygroup = 4,
			vals = {
				[0] = { 'Надеть галстук', 'bullet_blue', '/me надевает галстук себе на шею, плотно его затягивая' },
				[1] = { 'Снять галстук', 'cross', '/me снимает галстук, расслабяя воротник' },
			},
		},
	},
	['models/player/octo_swat_team/'] = {
		{
			bodygroup = 1,
			vals = {
				[0] = { 'Надеть бронежилет с разгрузками', 'bullet_blue', '/me надевает бронежилет на тело' },
				[1] = { 'Снять бронежилет с разгрузками', 'cross', '/me снимает бронежилет с груди' },
			},
		},{
			bodygroup = 2,
			vals = {
				[0] = { 'Снарядить низ', 'bullet_blue', '/me нацепляет снаряжения на ноги' },
				[1] = { 'Снять всё с ног', 'cross', '/me снимает все снаряжение с ног' },
			},
		},{
			bodygroup = 3,
			vals = {
				[0] = { 'Распрямить рукава', 'arrow_down', '/me распрямляет рукава' },
				[1] = { 'Засучить рукава', 'arrow_up', '/me засучивает рукава' },
			},
		},{
			bodygroup = 4,
			vals = {
				[0] = { 'Снять перчатки', 'cross', '/me снимает тактические перчатки с рук' },
				[1] = { 'Надеть перчатки', 'bullet_blue', '/me надевает перчатки на руки' },
			},
		},{
			bodygroup = 5,
			vals = {
				[0] = { 'Снять часы', 'cross', '/me снимает часы с рук' },
				[1] = { 'Надеть часы', 'bullet_blue', '/me застегивает часы на руке' },
			},
		},{
			bodygroup = 9,
			vals = {
				[0] = { 'Надеть шлем', 'bullet_blue', '/me надевает шлем на голову' },
				[1] = { 'Снять шлем', 'cross', '/me снимает шлем с головы' },
			},
		},{
			bodygroup = 10,
			vals = {
				[0] = { 'Надеть наушники', 'bullet_blue', '/me надевает наушники' },
				[1] = { 'Снять наушники', 'cross', '/me снимает наушники' },
			},
		},{
			bodygroup = 11,
			vals = {
				[0] = { 'Надеть прозрачные очки', 'bullet_white', '/me надевает прозрачные тактические очки на глаза' },
				[1] = { 'Надеть затемненные очки', 'bullet_black', '/me надевает затемненные тактические очки на глаза' },
				[2] = { 'Снять очки', 'cross', '/me снимает тактические очки с глаз' },
			},
		},{
			bodygroup = 12,
			vals = {
				[0] = { 'Надеть камеру на шлем', 'bullet_blue', '/me надевает камеру на шлем' },
				[1] = { 'Снять камеру со шлема', 'cross', '/me снимает камеру со шлема' },
			},
		},
	},
}

local wcsoBgs = {
	[1] = {
		name = 'Внешний бронежилет',
	},
	[2] = {
		name = 'Тазер',
		vals = {
			{ 'Слева', 0, true },
			{ 'Справа', 1 },
			{ 'Снять', 2 },
		},
	},
	[3] = {
		name = 'Головной убор',
		vals = {
			{ 'Шляпа', 0, true },
			{ 'Шлем', 1 },
			{ 'Снять', 2 },
		},
	},
	[4] = {
		name = 'Форма',
		vals = {
			{ 'Строгая', 0, true },
			{ 'Повседневная', 1 },
			{ 'Легкая', 2 },
		},
	},
	[5] = {
		name = 'Снять дубинку',
	},
	[6] = {
		name = 'Перчатки',
		vals = {
			{ 'Без перчаток', 0, true },
			{ 'Черные', 1 },
			{ 'Белые', 2 },
		},
	},
	[7] = {
		name = 'Снять рацию',
	},
}



local patrolModels, decModels = {}
for i, v in ipairs({1, 2, 3, 4, 5, 6, 8, 9}) do
	patrolModels[#patrolModels + 1] = {
		name = '%s ' .. i,
		model = ('models/player/octo_sheriff/male_%02i.mdl'):format(v),
		unisex = true,
		bgs = wcsoBgs,
	}
end

local sebNames = {
	{'Westbrook', 0},
	{'Sandstorm', 1},
	{'Moore', 2},
	{'Miller', 3},
	{'Bartels', 4},
	{'Marler', 5},
	{'Mckenney', 6},
	{'Rain', 7},
	{'Thompson', 8},
	{'Rose', 9},
	{'Cramble', 10},
	{'Phillips', 11},
	{'Nelson', 12},
	{'Anderson', 13},
	{'Kertis', 14},
	{'Campbell', 15},
	{'Bradley', 16},
	{'Archuleta', 17},
	{'Murphy', 18},
	{'Rumberger', 19},
	{'Ter Stegen', 20},
	{'Gvidichi', 21},
	{'Coleman', 22},
	{'Без имени', 26},
}

local sebBgs = {
	[7] = {
		name = 'Позывной',
		vals = sebNames,
	},
	[13] = {
		name = 'Патч на шлеме',
		vals = {
			{'Без патча', 0},
			{'Патч "Punisher Thin Blue Line"', 1},
			{'Патч 715 Team', 2},
			{'Патч "Bang one, bang em\' all"', 3},
			{'Патч "My idea of help"', 4},
			{'Патч "Respect all, fear none', 5},
		},
	},
	[11] = {
		name = 'Очки',
		vals = {
			{'Прозрачные очки', 0},
			{'Затемненные очки', 1},
			{'Без очков', 2},
		},
	},
	[1] = {
		name = 'Стандартный вверх',
	},
	[2] = {
		name = 'Стандартный низ',
	},
	[3] = {
		name = 'Засученные рукава',
	},
	[4] = {
		name = 'Тактические перчатки',
	},
	[5] = {
		name = 'Часы',
	},
	[6] = {
		name = 'Медицинский патч на разгрузку',
	},
	[9] = {
		name = 'Снять шлем',
	},
	[10] = {
		name = 'Снять наушники',
	},
	[12] = {
		name = 'Снять камеру на шлеме',
	},
}

local everyday_maleBgs = {
	[3] = {
		name = 'Тактический пояс',
		vals = {
			{'Нет', 0},
			{'Пустой', 1},
			{'Со значком без пистолета', 2},
			{'Без значка и с пистолетом', 3},
			{'Со значком и с пистолетом', 4},
		},
	},
	[4] = {
		name = 'Бронежилет',
	},
	[5] = {
		name = 'Головной убор',
	},
	[6] = {
		name = 'Очки',
	},
}

local everyday_femaleBgs = {
	[4] = {
		name = 'Головной убор',
	},
	[5] = {
		name = 'Очки',
	},
}

local patrolBgs_hatAll = {
	[3] = {
		name = 'Бронежилет',
	},
	[4] = {
		name = 'Головной убор',
		vals = {
			{'Нет', 0},
			{'Кепка', 1},
			{'Фуражка', 2},
		},
	}
}

local decBgs = {
	[1] = {
		name = 'Пояс',
		vals = {
			{'Полное вооружение', 0},
			{'Только фонарик и табель', 1},
			{'Только фонарик', 2},
		},
	},

	[2] = {
		name = 'Защита',
		vals = {
			{'Бронежилет детектива', 0},
			{'Бронежилет инспектора', 1},
			{'Бейдж инспектора', 2},
			{'Бейдж детектива', 3},
		}
	},

	[3] = {
		name = 'Значок',
		vals = {
			{'Значок детектива', 0},
			{'Значок инспектора', 1},
			{'Нет', 2},
		}
	},
}
local decSkin = {
	name = 'Одежда',
	vals = {
		{'Серая рубашка, черные брюки', 0},
		{'Черная рубашка, зеленые брюки', 1},
		{'Серая рубашка, синие брюки', 2},
		{'Серая рубашка, желтые брюки', 3},
		{'Голубая рубашка, черные брюки', 4},
	}
}
local civilSkins = {
	name = 'Одежда',
	vals = {
		{'Коричневый пиджачок', 0},
		{'Синяя клетчатая рубашка с белыми рукавами', 2},
		{'Темно-синяя кофта с белыми рукавами', 3},
		{'Серый мешок, измазан дерьмом, джинсы тоже', 4},
		{'Красная рубашка с белыми рукавами, коричневые джинсы', 5},
		{'Бежевая кофта с логотипом, черные брюки', 6},
		{'Черная куртка с логотипом скелета, бежевые брюки', 7},
		{'Оранжевая рубашка с узором "Такси" и белыми рукавами, темные джинсы', 8},
		{'Черная кофта с белыми рукавами и перчатками', 9},
		{'Черная кофта с логотипом, перчатки', 10},
		{'Серая кофта в зеленую полоску и белыми рукавами', 11},
		{'Красная кофта, бежевые джинсы', 12},
		{'Черная куртка, белая майка, серые джинсы', 13},
		{'Зеленая кофта, светлые брюки', 14},
		{'Черная куртка, серая майка, светлые брюки', 15},
		{'Красная клетчатая рубашка с черными рукавами и перчатками', 16},
		{'Синяя спортивка', 17},
		{'Черная куртка, черная рубашка', 18},
		{'Салатовая куртка, белая майка, светлые брюки', 19},
		{'Синяя куртка, салатовая майка, рваные джинсы', 20},
		{'Черный пиджак, бежевая кофта, салатовая майка, светлые брюки', 21},
		{'Зеленая куртка, бордовая кофта, светлые брюки', 22},
		{'Синяя кофта в белую полоску и белыми рукавами', 23},
	}
}

local dizcordumMale = {
	[1] = {
		name = 'Верх',
		vals = {
			{'Куртка болотного цвета', 0},
			{'Серая куртка, клетчатая рубашка', 1},
			{'Серая куртка, серая кофта с капюшоном', 2},
			{'Серо-синяя куртка, клетчатая рубашка, синий шарф', 3},
			{'Черно-бирюзовая куртка, рубашка в полоску, красный шарф', 4},
			{'Черно-красная куртка, серый свитер, синий шарф', 5},
			{'Серо-синяя куртка с воротником', 6},
			{'Черно-бирюзовая куртка с воротником', 7},
			{'Черно-красная куртка с воротником', 8},
		},
	},

	[2] = {
		name = 'Низ',
		vals = {
			{'Синие джинсы', 0},
			{'Темно-синие джинсы', 1},
			{'Серые джинсы', 2},
			{'Синие свободные джинсы', 3},
			{'Темные свободные джинсы', 4},
			{'Серые болоневые штаны', 5},
			{'Синие болоневые штаны', 6},
			{'Серые рабочие брюки', 7},
			{'Камуфляжные рабочие брюки', 8},
		},
	},

	[3] = {
		name = 'Перчатки',
	},
}

local dizcordumFemale = {
	[1] = {
		name = 'Верх',
		vals = {
			{'Куртка болотного цвета', 0},
			{'Бирюзовая куртка, расстегнута', 1},
			{'Бирюзовая куртка, застегнута', 5},
			{'Синяя куртка, расстегнута', 2},
			{'Синяя куртка, застегнута', 4},
			{'Красная куртка, расстегнута', 3},
			{'Красная куртка, застегнута', 6},
		},
	},

	[2] = {
		name = 'Низ',
		vals = {
			{'Синие джинсы + Ботинки', 0},
			{'Брюки + Сапоги', 1},
			{'Штаны с полоской + Ботинки', 2},
			{'Синие испачканные штаны + Ботинки', 3},
			{'Серые испачканные штаны + Ботинки', 4},
			{'Серые болоневые штаны', 5},
			{'Светлые болоневые штаны', 6},
			{'Серые рабочие брюки', 7},
		},
	},

	[3] = {
		name = 'Перчатки'
	},
}

for i = 1, 9 do
	patrolModels[#patrolModels + 1] = {
		name = '%s ' .. i,
		male = true,
		model = ('models/player/octo_sheriff/male_%02i.mdl'):format(i),
		bgs = patrolBgs_hatAll_male,
	}
end
for i = 1, 9 do
	utilityModels[#utilityModels + 1] = {
		name = '%s (утилитарная) ' .. i,
		male = true,
		model = ('models/player/octo_sheriff/male_%02i.mdl'):format(i),
		bgs = utilityBgs,
		requiredBgs = utilityBgs_req,
	}
end

local decModels = {}

local skins = {[1] = 2, [2] = 2, [3] = 6, [4] = 3, [5] = 4, [6] = 4, [7] = 5, [8] = 4, [9] = 3}
for i = 1, 9 do

	everydayModels[#everydayModels + 1] = {
		name = 'Повседневная форма ' .. i,
		model = ('models/dpdac/male_%02i_01.mdl'):format(i),
		male = true,
		bgs = everyday_maleBgs,
		everyday = true,
	}
	decModels[#decModels + 1] = {
		name = 'Детектив ' .. i,
		model = ('models/kerry/detective_dbg/male_%02i.mdl'):format(i),
		male = true,
		bgs = decBgs,
		skin = decSkin,
	}
	swatModels[#swatModels + 1] = {
		name = 'Форма ' .. i,
		male = true,
		model = ('models/player/octo_swat_team/male_%02i.mdl'):format(i),
		bgs = swatBgs,
		skin = {
			name = 'Внешность',
			vals = {},
		},
		subMaterials = swatSubMats,
	}

	for n = 0, skins[i] do
		swatModels[i].skin.vals[#swatModels[i].skin.vals + 1] = { 'Внешность ' .. (n + 1), n }
	end

end

for num, i in ipairs({ 1, 2, 3, 4, 6, 7 }) do
	patrolModels[#patrolModels + 1] = {
		name = '%s ' .. num,
		male = false,
		model = ('models/humans/dpdfem/female_%02i.mdl'):format(i),
		bgs = patrolBgs_hatAll,
	}
	everydayModels[#everydayModels + 1] = {
		name = 'Повседневная форма ' .. num,
		model = ('models/humans/dpdfeminv/female_%02i.mdl'):format(i),
		male = false,
		bgs = everyday_femaleBgs,
		everyday = true,
	}
	decModels[#decModels + 1] = {
		name = 'Детектив ' .. num,
		model = ('models/humans/dpdfeminv/female_%02i.mdl'):format(i),
		male = false,
		bgs = {
			[4] = {
				name = 'Головной убор',
			},
			[5] = {
				name = 'Очки',
			},
		},
		requiredSkin = 4,
	}
end

for num, i in ipairs({1, 2, 4, 6}) do
	decModels[#decModels + 1] = {
		name = 'Офисный работник ' .. num,
		model = ('models/humans/dpdfemsuits/female_%02i.mdl'):format(i),
		male = false,
		skin = {
			name = 'Цвет пиджака',
			vals = {
				{'Темный', 0},
				{'Синий', 1},
			},
		},
	}
end

for i = 1, 8 do
	decModels[#decModels + 1] = {
		name = 'Теплая одежда ' .. i,
		male = true,
		model = ('models/dizcordum/citizens/playermodels/pm_male_%02i.mdl'):format(i),
		bgs = dizcordumMale,
	}
end

for i, v in ipairs({'p_female_01', 'p_female_02', 'p_female_03', 'p_female_04', 'p_female_06', 'p_female_05'}) do
	decModels[#decModels + 1] = {
		name = 'Теплая одежда ' .. i,
		male = false,
		model = 'models/dizcordum/citizens/playermodels/' .. v .. '.mdl',
		bgs = dizcordumFemale,
	}
end

for i, v in ipairs({'07_01', '07_02', '07_06', '09_03', '06_04', '01_02', '08_01', '08_02', '08_03', '08_04'}) do
	decModels[#decModels + 1] = {
		name = 'Гражданский ' .. i,
		male = true,
		model = 'models/humans/octo/male_' .. v .. '.mdl',
		skin = civilSkins,
	}
end

decModels[#decModels + 1] = {
	name = 'Гражданский 1',
	male = false,
	model = 'models/humans/octo/female_01.mdl',
	skin = {
		name = 'Верх',
		vals = {
			{'Коричневое пальто и темные джинсы', 0},
			{'Темно-синяя куртка на молнии', 1},
			{'Зеленая клетчатая рубашка', 2},
			{'Светло-зеленая куртка на пуговицах', 3},
			{'Синяя кофта', 4},
			{'Коричневый худи с белыми шнурками', 5},
			{'Голубая спортивка', 6},
			{'Зеленая кофта с белым поясом', 7},
			{'Белая кофта с черным рисунком зайца', 8},
			{'Кофта "Hello Kitty"', 9},
			{'Красная полосатая куртка', 10},
			{'Сиреневая куртка', 11},
			{'Бордовое пальто', 12},
			{'Коричневая кожаная куртка', 13},
			{'Жилетка цвета хаки', 14},
		},
	},
}

decModels[#decModels + 1] = {
	name = 'Гражданский 2',
	male = false,
	model = 'models/humans/octo/female_02.mdl',
	skin = {
		name = 'Верх',
		vals = {
			{'Белая клетчатая рубашка', 0},
			{'Куртка армейской расцветки', 1},
			{'Серая куртка на молнии', 2},
			{'Куртка кирпичного цвета', 3},
			{'Красная кофта', 4},
			{'Джинсовка', 5},
			{'Голубая спортивка', 7},
			{'Зеленая кофта с белым поясом', 8},
			{'Белая кофта с черным рисунком зайца', 9},
			{'Кофта "Hello Kitty"', 10},
			{'Красная полосатая куртка', 11},
			{'Сиреневая куртка', 12},
			{'Серое пальто', 13},
			{'Черная кожаная куртка', 14},
		},
	},
}

local function highRankBg(val)
	return {
		[11] = {
			name = 'Воротник застегнут?',
			vals = {
				{'Да', val},
				{'Нет', val+6},
			},
		}
	}
end

local patrolModels = {}
for i, v in ipairs({1, 2, 3, 4, 5, 6, 8, 9}) do
	patrolModels[#patrolModels + 1] = {
		name = '%s ' .. i,
		model = ('models/player/octo_sheriff/male_%02i.mdl'):format(v),
		unisex = true,
		bgs = wcsoBgs,
	}
end

local sebMdls = {}
local skins = {[1] = 2, [2] = 2, [3] = 6, [4] = 3, [5] = 4, [6] = 4, [7] = 5, [8] = 4, [9] = 3}
for i = 1, 9 do
	sebMdls[#sebMdls + 1] = {
		name = 'Форма ' .. i,
		male = true,
		model = ('models/player/octo_swat_team/male_%02i.mdl'):format(i),
		bgs = sebBgs,
		requiredMats = {
			[4] = 'models/octo_swat_team/body_01_seb',
			[5] = 'models/octo_swat_team/armor_seb',
			[6] = 'models/octo_swat_team/patch_seb',
			[7] = 'models/octo_swat_team/lowr_01_seb',
			[11] = 'models/octo_swat_team/hlem_seb',
		},
		skin = {
			name = 'Внешность',
			vals = {},
		},
	}

	for n = 0, skins[i] do
		sebMdls[i].skin.vals[#sebMdls[i].skin.vals + 1] = { 'Внешность ' .. (n + 1), n }
	end

end

table.Add(sebMdls, patrolModels, decModels)

simpleOrgs.addOrg('wcso', {
	name = 'Офис Шерифа',
	title = 'Работа в Офисе Шерифа',
	shortTitle = 'Работа в WCSO',
	team = 'wcso',
	police = true,
	talkieFreq = 'ems',
	clothes = clothesData,
	rankOrder = { 'cad', 'ins', 'det', 'ds1', 'ds2', 'crp', 'srg', 'lie', 'cap', 'ass', 'she', 'seb' },
	multirank = true,
	ranks = {
		cad = { -- Cadet
			shortName = 'Кадет',
			name = 'Кадет офиса Шерифа',
			mdls = patrolModels,
			icon = octolib.icons.silk16('sheriff'),
			weps = { 'weapon_octo_air_glock17', 'weapon_octo_air_m4a1', 'weapon_octo_air_m3' },
			skin = 0,
		},
		ins = { -- Instructor
			shortName = 'Инструктор',
			name = 'Инструктор офиса Шерифа',
			mdls = patrolModels,
			icon = octolib.icons.silk16('sheriff'),
			weps = { 'weapon_octo_air_glock17', 'weapon_octo_air_m4a1', 'weapon_octo_air_m3' },
			skin = 3,
		},
		det = { -- detective
			shortName = 'Детектив',
			name = 'Детектив офиса Шерифа',
			mdls = decModels,
			icon = octolib.icons.silk16('sheriff'),
			skin = 3,
		},
		ds1 = { -- Deputy Sheriff I
			shortName = 'Помощник Шерифа I',
			name = 'Помощник Шерифа I',
			mdls = patrolModels,
			icon = octolib.icons.silk16('sheriff'),
			skin = 0,
		},
		ds2 = { -- Deputy Sheriff II
			shortName = 'Помощник Шерифа II',
			name = 'Помощник Шерифа II',
			mdls = patrolModels,
			icon = octolib.icons.silk16('sheriff'),
			skin = 1,
		},
		crp = { -- Corporal
			shortName = 'Капрал',
			name = 'Капрал офиса Шерифа',
			mdls = patrolModels,
			icon = octolib.icons.silk16('sheriff'),
			skin = 2,
		},
		srg = { -- Sergeant
			shortName = 'Сержант',
			name = 'Сержант офиса Шерифа',
			mdls = patrolModels,
			icon = octolib.icons.silk16('sheriff'),
			skin = 3,
		},
		lie = { -- Lieutenant
			shortName = 'Лейтенант',
			name = 'Лейтенант офиса Шерифа',
			mdls = patrolModels,
			icon = octolib.icons.silk16('sheriff'),
			skin = 4,
		},
		cap = { -- Captain
			shortName = 'Капитан',
			name = 'Капитан офиса Шерифа',
			mdls = patrolModels,
			icon = octolib.icons.silk16('sheriff'),
			skin = 5,
		},
		ass = { -- Assistant Sheriff
			shortName = 'Ассистент Шерифа',
			name = 'Ассистент Шерифа',
			mdls = patrolModels,
			icon = octolib.icons.silk16('sheriff'),
			skin = 6,
		},
		she = { -- Sheriff
			shortName = 'Шериф',
			name = 'Шериф',
			mdls = patrolModels,
			icon = octolib.icons.silk16('sheriff'),
			skin = 7,
		},

		seb = { -- S. E. B.
			shortName = 'Оператор S.E.B.',
			name = 'Оператор S.E.B.',
			armor = 100,
			mdls = sebMdls,
			icon = octolib.icons.silk16('lightning'),
			weps = {'weapon_octo_m4a1', 'weapon_octo_usps', 'weapon_octo_xm1014', 'weapon_octo_sg550', 'weapon_octo_beanbag', 'weapon_octo_p90', 'weapon_octo_tmp', 'door_ram', 'dbg_shield'},
			excludeWeps = {'weapon_octo_glock17', 'dbg_speedometer'},
		},
	}
})

netstream.Hook('wcso.gloves', function(ply, val)
	if not (ply:GetActiveRank('wcso') and octolib.math.inRange(val, 0, 2)) then return end
	ply:SetBodygroup(6, val)
end)