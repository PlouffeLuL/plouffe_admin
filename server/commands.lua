local Inventory = exports.plouffe_lib:Get("Inventory")

Admin:RegisterCommand({"weather", "WEATHER", "SetWeather", "setweather", "SETWEATHER", "Setweather"},4,true,
    {help = "Changer la météo", validate = true, arguments = {
    {name = 'weather', help = 'Météo', type = 'string'}
}},function(playerId, args, raw)
    exports.plouffe_lib:SetWeather(args.weather)
end)

Admin:RegisterCommand({"freezeweather", "FREEZEWEATHER"},4,true,
    {help = "Changer la météo", validate = false, arguments = {
}},function(playerId, args, raw)
    exports.plouffe_lib:DoWeatherSync()
end)

Admin:RegisterCommand({"time", "TIME", "SetTime", "settime", "SETTIME", "Settime"},4,true,
    {help = "Changer la météo", validate = false, arguments = {
    {name = 'hour', help = 'Heurs', type = 'number'},
    {name = 'minute', help = 'Minutes', type = 'number'}
}},function(playerId, args, raw)
    exports.plouffe_lib:SetTime(args.hour,args.minute)
end)

Admin:RegisterCommand({"freezetime", "FREEZETIME"},4,true,
    {help = "Changer la météo", validate = false, arguments = {
}},function(playerId, args, raw)
    exports.plouffe_lib:DoSyncTime()
end)

Admin:RegisterCommand({"blackout", "BLACKOUT"},4,true,
    {help = "Changer la météo", validate = false, arguments = {
}},function(playerId, args, raw)
    exports.plouffe_lib:SetBlackout()
end)

Admin:RegisterCommand({"SetStatus", "setstatus", "SETSTATUS", "Setstatus"},4,true,
    {help = "Set un certain status", validate = true, arguments = {
    {name = 'target', help = 'Cible', type = 'number'},
    {name = 'status', help = 'Status', type = 'string'},
	{name = 'value', help = 'Valeur', type = 'number'}
}},function(playerId, args, raw)
    exports.plouffe_status:SetStatus(args.target, args.status, args.value)
end)

Admin:RegisterCommand({"revive", "REVIVE"}, 4, true,
    {help = "Revive", validate = false, arguments = {
        {name = 'playerId', help = 'Cible', type = 'number'}
    }
},function(playerId, args, raw)
    exports.plouffe_status:RevivePlayer(args.playerId)
end)

Admin:RegisterCommand({"heal", "HEAL"}, 4, true,
    {help = "Heal", validate = false, arguments = {
        {name = 'playerId', help = 'Cible', type = 'number'}
    }
},function(playerId, args, raw)
    exports.plouffe_status:HealPlayer(args.playerId)
end)

Admin:RegisterCommand({"armor", "ARMOR", "armour", "ARMOUR"},4,true,
    {help = "Donne de l'armure", validate = false, arguments = {
        {name = 'playerId', help = 'Cible', type = 'number'}
    }
},function(playerId, args, raw)
    local ped = GetPlayerPed(args.playerId)
    if DoesEntityExist(ped) then
        SetPedArmour(ped, 100)
    end
end)

Admin:RegisterCommand({"cardel","dv", "DV", "deletevehicle","DELETEVEHICLE"},1,true,
    {help = "Efface le vehicule le plus près", validate = false, arguments  = {
        {name = 'dst', help = 'Distance', type = 'number'}
    }
},function(playerId, args, raw)
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(playerId))
    
    if DoesEntityExist(vehicle) then
        DeleteEntity(vehicle)
    else
        TriggerClientEvent("plouffe_admin:deleteVehicle", playerId, args.dst and args.dst or 5.0)
    end
end)

Admin:RegisterCommand({"car", "CAR"},1,true,
    {help = "Efface le vehicule le plus près", validate = true, arguments = {
        {name = 'model', help = 'Model', type = 'string'}
    }
},function(playerId, args, raw)
    TriggerClientEvent("plouffe_admin:createVehicle", playerId, args.model)
end)

Admin:RegisterCommand({"bring", "BRING"},1,true,
    {help = "Apporte un joueur", validate = true, arguments = {
        {name = 'playerId', help = 'PlayerId', type = 'number'}
    }
},function(playerId, args, raw)
    local myPedCoords = GetEntityCoords(GetPlayerPed(playerId))
    local otherPed = GetPlayerPed(args.playerId)
    
    if DoesEntityExist(otherPed) then
        SetEntityCoords(otherPed, myPedCoords.x, myPedCoords.y, myPedCoords.z)
    end
end)

Admin:RegisterCommand({"goto", "GOTO"},1,true,
    {help = "Aller a un joueur", validate = true, arguments = {
        {name = 'playerId', help = 'PlayerId', type = 'number'}
    }
},function(playerId, args, raw)
    local otherPed = GetPlayerPed(args.playerId)

    if DoesEntityExist(otherPed) then
        local coords = GetEntityCoords(otherPed)
        SetEntityCoords(GetPlayerPed(playerId), coords.x, coords.y, coords.z)
    end
end)

Admin:RegisterCommand({"freeze", "FREEZE"},1,true,
    {help = "Freeze un joueur", validate = true, arguments = {
        {name = 'playerId', help = 'PlayerId', type = 'number'}
    }
},function(playerId, args, raw)
    local ped = GetPlayerPed(args.playerId)
    if DoesEntityExist(ped) then
        FreezeEntityPosition(ped, true)
    end
end)

Admin:RegisterCommand({"unfreeze", "UNFREEZE"},1,true,
    {help = "Defreeze un joueur", validate = true, arguments = {
        {name = 'playerId', help = 'PlayerId', type = 'number'}
    }
},function(playerId, args, raw)
    local ped = GetPlayerPed(args.playerId)
    if DoesEntityExist(ped) then
        FreezeEntityPosition(ped, false)
    end
end)

Admin:RegisterCommand({"clearchat", "CLEARCHAT"},1,true,
    {help = "Vide le chat", validate = false, arguments = {
    }
},function(playerId, args, raw)
    TriggerClientEvent('chat:clear', -1)
end)

Admin:RegisterCommand({"setgroup", "SETGROUP"},1,true,
    {help = "Set le group de quelqun", validate = true, arguments = {
        {name = 'playerId', help = "Id du joueur", type = 'number'},
        {name = 'group', help = "Group", type = 'string'},
        {name = 'grade', help = "Grade", type = 'number'}
    }
},function(playerId, args, raw)
    local player = Ox.GetPlayer(args.playerId)

    if player then
        player.setGroup(args.group, args.grade)
    end
end)

Admin:RegisterCommand({"jail", "JAIL"},1,true,
    {help = "Envoie quelqun en prison", validate = true, arguments = {
        {name = 'playerId', help = "Id du joueur", type = 'number'},
        {name = 'time', help = "Duré", type = 'number'}
    }
},function(playerId, args, raw)
    exports.plouffe_jail:AdminSendToJail(args.playerId, args.time)
end)

Admin:RegisterCommand({"unjail", "UNJAIL"},1,true,
    {help = "Sortir quelqun de prison", validate = true, arguments = {
        {name = 'playerId', help = "Id du joueur", type = 'number'}
    }
},function(playerId, args, raw)
    exports.plouffe_jail:AdminRemoveFromJail(args.playerId)
end)

Admin:RegisterCommand({"bennys", "BENNYS"},1,true,
    {help = "Ouvre le bennys", validate = false, arguments = {
    }
},function(playerId, args, raw)
    TriggerClientEvent('AdminBennys', playerId)
end)

Admin:RegisterCommand({"skin", "SKIN"},1,true,
    {help = "Ouvre le menu skin", validate = true, arguments = {
        {name = 'playerId', help = "Id du joueur", type = 'string'}
    }
},function(playerId, args, raw)
    TriggerClientEvent('ooc_core:openSkinMenu', args.playerId)
end)

Admin:RegisterCommand({"a", "A"},1,true,
    {help = "Chat Admin", validate = false, arguments = {}
},function(playerId, args, raw)
    for k,v in pairs(Admin.Users) do
        TriggerClientEvent("chat:addMessage",k,{
            template = '<div class="chat-message staff"><b>[STAFF] {0} | </b> {1}</div>',
            args = {GetPlayerName(playerId), raw:sub(2)}}
        )
    end
end)

Admin:RegisterCommand({"annonce", "ANNONCE"},1,true,
    {help = "Annonce global", validate = false, arguments = {}
},function(playerId, args, raw)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div class="chat-message ooc"><b>[ANNONCE]</b> {1}</div>',
        args = { nil, raw:sub(8)}
    })
end)

Admin:RegisterCommand({"giveitem", "GIVEITEM", "GiveItem", "giveItem"},4,true,
    {help = "Donner un item", validate = true, arguments = {
        {name = 'playerId', help = "Id du joueur", type = 'number'},
        {name = 'item', help = "Nom de l'item", type = 'string'},
        {name = 'count', help = "Quantité", type = 'number'}
    }
},function(playerId, args, raw)
    Inventory.AddItem(args.playerId, args.item, args.count)
end)

Admin:RegisterCommand({"removeitem", "REMOVEITEM", "RemoveItem", "removeItem"},4,true,
    {help = "Retirer un item", validate = true, arguments = {
        {name = 'playerId', help = "Id du joueur", type = 'number'},
        {name = 'item', help = "Nom de l'item", type = 'string'},
        {name = 'count', help = "Quantité", type = 'number'}
    }
},function(playerId, args, raw)
    Inventory.RemoveItem(args.playerId, args.item, args.count)
end)

-- Admin:RegisterCommand({"clearinventory", "CLEARINVENTORY"},4,true,
--     {help = "Clear inventory", validate = true, arguments = {
--         {name = 'playerId', help = "Id du joueur", type = 'number'},
--     }
-- },function(playerId, args, raw)
--     local player = exports.ooc_core:getPlayerFromId(args.playerId)

--     if player then
--         player.clearInventory()
--     end
-- end)

Admin:RegisterCommand({"weapon:ammo", "WEAPON:AMMO"},4,true,
    {help = "Clear inventory", validate = true, arguments = {
        {name = 'playerId', help = "Id du joueur", type = 'number'},
    }
},function(playerId, args, raw)
    local ammos = {
        'ammo-45',
        'ammo-50',
        'ammo-9',
        'ammo-heavysniper',
        'ammo-rifle',
        'ammo-rifle2',
        'ammo-shotgun',
        'ammo-sniper'
    }

    for k,v in pairs(ammos) do
        Inventory.AddItem(args.playerId,v,1000)
    end
end)

Admin:RegisterCommand({"weapon:comps", "WEAPON:COMPS"},4,true,
    {help = "Clear inventory", validate = true, arguments = {
        {name = 'playerId', help = "Id du joueur", type = 'number'},
    }
},function(playerId, args, raw)
    local comps = {
        'at_flashlight',
        'at_suppressor_light',
        'at_suppressor_heavy',
        'at_grip',
        'at_barrel',
        'at_clip_extended_pistol',
        'at_clip_extended_smg',
        'at_clip_extended_rifle',
        'at_clip_drum_smg',
        'at_clip_drum_rifle',
        'at_compensator',
        'at_scope_small',
        'at_scope_medium',
        'at_scope_advanced',
        'at_scope_zoom'
    }

    for k,v in pairs(comps) do
        Inventory.AddItem(args.playerId,v,10)
    end
end)

Admin:RegisterCommand({"setmodel", "SETMODEL"},4,true,
    {help = "Clear inventory", validate = true, arguments = {
        {name = 'playerId', help = "Id du joueur", type = 'number'},
        {name = 'model', help = "Model", type = 'string'}
    }
},function(playerId, args, raw)
    SetPlayerModel(args.playerId, args.model)
end)

Admin:RegisterCommand({"setpopmodel","setpopulationmodel", "SETPOPULATIONMODEL"},4,true,
    {help = "Clear inventory", validate = true, arguments = {
        {name = 'model', help = "Model", type = 'string'}
    }
},function(playerId, args, raw)
    TriggerClientEvent("plouffe_admin:setpopulationmodel", -1, args.model)
end)

Admin:RegisterCommand({"races:show", "RACES:SHOW"},4,true,
    {help = "Show Races", validate = true, arguments = {}
},function(playerId, args, raw)
    exports.plouffe_racing:ShowRaces()
end)

Admin:RegisterCommand({"races:delete", "RACES:DELETE"},4,true,
    {help = "Show Races", validate = true, arguments = {
        {name = "id", help = "Id", type = "number"}
    }
},function(playerId, args, raw)
    exports.plouffe_racing:Delete(args.id)
end)

Admin:RegisterCommand({"races:addrp", "RACES:ADDRP"},4,true,
    {help = "Show Races", validate = true, arguments = {
        {name = "id", help = "Id", type = "number"},
        {name = "amount", help = "amount", type = "number"}
    }
},function(playerId, args, raw)
    exports.plouffe_racing:AddRp(args.id, args.amount)
end)

Admin:RegisterCommand({"races:removerp", "RACES:REMOVERP"},4,true,
    {help = "Show Races", validate = true, arguments = {
        {name = "id", help = "Id", type = "number"},
        {name = "amount", help = "amount", type = "number"}
    }
},function(playerId, args, raw)
    exports.plouffe_racing:RemoveRp(args.id, args.amount)
end)

-- Admin:RegisterCommand({"veh:setpolice", "VEH:SETPOLICE"},4,true,
--     {help = "Set police vehicle", validate = false, arguments = {
--         {name = "id", help = "Id", type = "number"}
--     }
-- },function(playerId, args, raw)
--     local ped = GetPlayerPed(args.id or playerId)
--     local vehicle = GetVehiclePedIsIn(ped)
--     exports.plouffe_doj:setVehicleState(vehicle)
-- end)