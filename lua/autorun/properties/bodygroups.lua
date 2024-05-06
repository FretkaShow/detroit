AddCSLuaFile()

properties.Add("bodygroups", {
    MenuLabel = "#bodygroups",
    Order = 600,
    MenuIcon = "icon16/link_edit.png",

    Filter = function(self, ent, ply)
        if not IsValid(ent) or ent:IsPlayer() then return false end
        if not gamemode.Call("CanProperty", ply, "bodygroups", ent) then return false end
        if IsValid(ent.AttachedEntity) then ent = ent.AttachedEntity end

        local options = ent:GetBodyGroups()
        return options and next(options) ~= nil
    end,

    MenuOpen = function(self, option, ent, tr)
        local target = IsValid(ent.AttachedEntity) and ent.AttachedEntity or ent
        local options = target:GetBodyGroups()

        for k, v in pairs(options) do
            local submenu = option:AddSubMenu(v.name)

            for i = 0, v.num - 1 do
                local modelname = v.submodels and v.submodels[i] or "model #" .. (i + 1)
                modelname = string.Trim(modelname, ".\\/")
                modelname = string.StripExtension(modelname)

                local opt = submenu:AddOption(modelname, function()
                    self:SetBodyGroup(ent, v.id, i)
                end)
                opt:SetChecked(target:GetBodygroup(v.id) == i)
                if opt.SetCheckable then -- Проверка наличия метода
                    opt:SetCheckable(true)
                end
            end
        end
    end,

    Action = function(self, ent) end,

    SetBodyGroup = function(self, ent, body, id)
        self:MsgStart()
        net.WriteEntity(ent)
        net.WriteUInt(body, 8)
        net.WriteUInt(id, 8)
        self:MsgEnd()
    end,

    Receive = function(self, length, ply)
        local ent = net.ReadEntity()
        local body = net.ReadUInt(8)
        local id = net.ReadUInt(8)

        if not properties.CanBeTargeted(ent, ply) or not self:Filter(ent, ply) then return end

        ent = IsValid(ent.AttachedEntity) and ent.AttachedEntity or ent
        ent:SetBodygroup(body, id)
    end
})
