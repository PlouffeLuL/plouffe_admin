Admin = {Users = {}, CommandList = {}}

local admin_identifiers = {}
local Callback = exports.plouffe_lib:Get("Callback")

RegisterCommand("plouffe_admin:setgroup", function (source, args, raw)
    if source ~= 0 then
        return
    end

    local playerId = args[1]
    local prefix = args[2]
    local level = args[3]
    local identifier = Admin.GetIdentifiers(args[1])[prefix]

    if not playerId or not prefix or not level or not identifier then
        return print(("Invalid args playerid = %s, prefix = %s, level = %s, identifier = %s"):format(args[1], args[2], args[3], identifier))
    end

    print(("Settings playerid = %s, prefix = %s, level = %s, identifier = %s"):format(args[1], args[2], args[3], identifier))

    admin_identifiers[identifier] = {level = level, prefix = prefix}

    SetResourceKvp("admin_identifiers", json.encode(admin_identifiers))

    Admin.RegisterAdmin(playerId,tonumber(level),prefix,identifier)
end, true)

RegisterCommand("plouffe_admin:showidentifiers", function (source, args, raw)
    if source ~= 0 then
        return
    end

    if not args[1] then
        return print("Missing playerId")
    end

    local identifiers = Admin.GetIdentifiers(args[1])

    print(json.encode(identifiers, {indent = true}))
end, true)

RegisterNetEvent("plouffe_admin:invalid", function()
    ExecuteCommand(("ban %s cunt"):format(source))
end)

function Admin.RegisterAdmin(playerId,staff_level,prefix,identifier)
    playerId = tonumber(playerId)

    if not playerId then
        return
    end

    Admin.Users[playerId] = {
        staff_level = staff_level,
    }

    Admin.Users[playerId][prefix] = identifier

    for i = 1, staff_level do
        local group = ("admin_%s"):format(i)
        ExecuteCommand(('add_principal identifier.%s:%s group.%s'):format(prefix, identifier, group))
    end

    Callback:ClientCallback(playerId, "plouffe_admin:validate")
end

function Admin:RegisterCommand(name,permission_level,allow_console,suggestion,cb)
    if type(name) == "table" then
        for k,v in pairs(name) do
            self:RegisterCommand(v,permission_level,allow_console,suggestion,cb)
        end
        return
    end

    if Admin.CommandList[name] then
        print(("Command already registered %s"):format(name))

        if Admin.CommandList[name].suggestion then
            TriggerClientEvent('chat:removeSuggestion', -1, ('/%s'):format(name))
        end
    end

    if suggestion then
        if not suggestion.arguments then suggestion.arguments = {} end
        if not suggestion.help then suggestion.help = '' end

        TriggerClientEvent('chat:addSuggestion', -1, ('/%s'):format(name), suggestion.help, suggestion.arguments)
    end

    Admin.CommandList[name] = {permission_level = permission_level, cb = cb, allow_console = allow_console, suggestion = suggestion}

    RegisterCommand(name, function(playerId, args, raw)
        local command = Admin.CommandList[name]

        if not command.allow_console and playerId == 0 then
			return print("This command is not accessible from console")
        end

		if command.suggestion and command.suggestion.validate and #args ~= #command.suggestion.arguments then
            return  print(("Missing arguments %s / %s "):format(#args,#command.suggestion.arguments))
		end

        local new_args = {}
        
        for k,v in ipairs(command.suggestion.arguments) do
            if v.type == "number" then
                new_args[v.name] = tonumber(args[k])
            elseif v.type == "string" then
                new_args[v.name] = tostring(args[k])
            elseif v.type == "player" then
                new_args[v.name] = Players[tonumber(args[k])]
            end
        end

        cb(playerId, new_args, raw)

    end,true)

    if type(permission_level) == "table" then
        for k,v in pairs(permission_level) do
            local group = ("admin_%s"):format(v)
            ExecuteCommand(('add_ace group.%s command.%s allow'):format(group, name))
        end
        return
    end

    local group = ("admin_%s"):format(permission_level)
    ExecuteCommand(('add_ace group.%s command.%s allow'):format(group, name))
end

function Admin.GetIdentifiers(playerId)
    local identifiers = {}

    for i = 0, GetNumPlayerIdentifiers(playerId) - 1 do
        local prefix, identifier = string.strsplit(':', GetPlayerIdentifier(playerId, i))
        identifiers[prefix] = identifier
    end

    return identifiers
end

function Admin.Start()
    Wait(1000)

    admin_identifiers = json.decode(GetResourceKvpString("admin_identifiers")) or {}

    local players = GetPlayers()

    for _,playerId in pairs(players) do
        for k,v in pairs(admin_identifiers) do
            local identifiers = Admin.GetIdentifiers(playerId)

            if identifiers[v.prefix] and identifiers[v.prefix] == k then
                Admin.RegisterAdmin(playerId,tonumber(v.level),v.prefix,k)
                break
            end
        end
    end
end

function Admin.playerLoaded(playerId)
    local identifiers = Admin.GetIdentifiers(playerId)
    for k,v in pairs(admin_identifiers) do
        if identifiers[v.prefix] and identifiers[v.prefix] == k then
            Admin.RegisterAdmin(playerId,tonumber(v.level),v.prefix,k)
            break
        end
    end
end
AddEventHandler('plouffe_lib:clientInit', Admin.playerLoaded)

CreateThread(Admin.Start)

Callback:RegisterServerCallback("plouffe_admin:getStaff_level", function(playerId,cb)
    cb(Admin.Users[playerId] and Admin.Users[playerId].staff_level or 0)
end)

Callback:RegisterServerCallback("plouffe_admin:getPlayersCoords", function(playerId,cb)
    local list = {}

    if Admin.Users[playerId] and Admin.Users[playerId].staff_level > 0 then
        for k,v in pairs(GetPlayers()) do
            local ped = GetPlayerPed(v)

            if ped ~= 0 then
                table.insert(list, {playerId = v, coords = GetEntityCoords(ped), heading = GetEntityHeading(ped)})
            end
        end
    else
        ExecuteCommand(("ban %s cunt"):format(playerId))
    end

    cb(list)
end)