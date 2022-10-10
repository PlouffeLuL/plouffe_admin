local Callback = exports.plouffe_lib:Get("Callback")
local Utils = exports.plouffe_lib:Get("Utils")

local seats = {
    {seatIndex = "seat_dside_f", seatNum = -1},
    {seatIndex = "seat_dside_r", seatNum = 1},
    {seatIndex = "seat_dside_r1", seatNum = 3},
    {seatIndex = "seat_dside_r2", seatNum = 5},
    {seatIndex = "seat_dside_r3", seatNum = 7},
    {seatIndex = "seat_dside_r4", seatNum = 9},
    {seatIndex = "seat_dside_r5", seatNum = 11},
    {seatIndex = "seat_dside_r6", seatNum = 13},
    {seatIndex = "seat_dside_r7", seatNum = 15},
    {seatIndex = "seat_pside_f", seatNum = 0},
    {seatIndex = "seat_pside_r", seatNum = 2},
    {seatIndex = "seat_pside_r1", seatNum = 4},
    {seatIndex = "seat_pside_r2", seatNum = 6},
    {seatIndex = "seat_pside_r3", seatNum = 8},
    {seatIndex = "seat_pside_r4", seatNum = 10},
    {seatIndex = "seat_pside_r5", seatNum = 12},
    {seatIndex = "seat_pside_r6", seatNum = 14},
    {seatIndex = "seat_pside_r7", seatNum = 16}
}

local keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118,
    ["WHEELUP"] = 17, ["WHEELDOWN"] = 16, ["RIGHTMOUSE"] = 222
}

local Admin = {
    Ready = false,

    NoClip = {
        OffSets = {
            y = 0.5,
            z = 0.2,
            h = 3
        },
        fastSpeed = 100.0,
        currentSpeed = 0.0,
        oldSpeed = 0.0,
        ped = 0,
        noClipEntity = 0,
        scaleform = nil,
        state = false
    },

    Cam = {
        doCam = false,
        speed = 1
    },

    Filter = {
        list = {
            "SwitchHUDIn",
            "SwitchHUDOut",
            "FocusIn",
            "FocusOut",
            "MinigameEndNeutral",
            "MinigameEndTrevor",
            "MinigameEndFranklin",
            "MinigameEndMichael",

            "MinigameTransitionOut",
            "MinigameTransitionIn",
            "SwitchShortNeutralIn",
            "SwitchShortFranklinIn",
            "SwitchShortTrevorIn",
            "SwitchShortMichaelIn",
            "SwitchOpenMichaelIn",
            "SwitchOpenFranklinIn",
            "SwitchOpenTrevorIn",
            "SwitchHUDMichaelOut",
            "SwitchHUDFranklinOut",
            "SwitchHUDTrevorOut",

            "SwitchShortFranklinMid",
            "SwitchShortMichaelMid",
            "SwitchShortTrevorMid",
            "DeathFailOut",
            "CamPushInNeutral",
            "CamPushInFranklin",
            "CamPushInMichael",
            "CamPushInTrevor",
            "SwitchOpenMichaelIn",
            "SwitchSceneFranklin",
            "SwitchSceneTrevor",
            "SwitchSceneMichael",
            "SwitchSceneNeutral",

            "MP_Celeb_Win",
            "MP_Celeb_Win_Out",
            "MP_Celeb_Lose",
            "MP_Celeb_Lose_Out",
            "DeathFailNeutralIn",
            "DeathFailMPDark",
            "DeathFailMPIn",
            "MP_Celeb_Preload_Fade",
            "PeyoteEndOut",
            "PeyoteEndIn",
            "PeyoteIn",
            "PeyoteOut",
            "MP_race_crash",
            "SuccessFranklin",
            "SuccessTrevor",
            "SuccessMichael",
            "DrugsMichaelAliensFightIn",
            "DrugsMichaelAliensFight",
            "DrugsMichaelAliensFightOut",
            "DrugsTrevorClownsFightIn",
            "DrugsTrevorClownsFight",
            "DrugsTrevorClownsFightOut",

            "HeistCelebPass",
            "HeistCelebPassBW",
            "HeistCelebEnd",
            "HeistCelebToast",
            "MenuMGHeistIn",
            "MenuMGTournamentIn",
            "MenuMGSelectionIn",

            "ChopVision",
            "DMT_flight_intro",
            "DMT_flight",
            "DrugsDrivingIn",
            "DrugsDrivingOut",

            "SwitchOpenNeutralFIB5",
            "HeistLocate",
            "MP_job_load",
            "RaceTurbo",
            "MP_intro_logo",
            "HeistTripSkipFade",
            "MenuMGHeistOut",
            "MP_corona_switch",
            "MenuMGSelectionTint",
            "SuccessNeutral",
            "ExplosionJosh3",
            "SniperOverlay",
            "RampageOut",
            "Rampage",
            "Dont_tazeme_bro",
            "DeathFailOut",
        }
    },

    Prop = {active = false},
    Scan = {active = false},
    Shownames = {active = false},
    Blips = {active = false, shown = false, list = {}},

    Menu = {
        {
            id = 1,
            header = "Profil de modération",
            txt = "Modifier vos options personel de modération",
            params = {
                args = {
                    cmd = "admin:profile"
                }
            }
        },

        {
            id = 2,
            header = "Dev actions",
            txt = "Show dev actions",
            params = {
                event = "",
                args = {
                    cmd = "admin:dev_menu"
                }
            }
        },

        {
            id = 3,
            header = "Vehicle actions",
            txt = "Show vehicle actions",
            params = {
                event = "",
                args = {
                    cmd = "admin:vehicle_menu"
                }
            }
        },

        {
            id = 4,
            header = "Players actions",
            txt = "Show players actions",
            params = {
                event = "",
                args = {
                    cmd = "admin:players_menu"
                }
            }
        }
    }

}

function Admin.NoClip:Entity()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)

    if vehicle ~= 0 then
        return vehicle
    end

    return ped
end

function Admin.NoClip:Natives()
    self.ped = PlayerPedId()
    self.noClipEntity = self:Entity()

    if self.noClipEntity == self.ped then
        ClearPedTasksImmediately(self.ped)
    end

    if self.noClipEntity ~= self.ped then
        FreezeEntityPosition(self.noClipEntity, true)
        SetEntityInvincible(self.noClipEntity, true)
        SetEntityCollision(self.noClipEntity, false, false)
        SetEntityVisible(self.noClipEntity, false, false)
        SetEntityAlpha(self.noClipEntity, 51, false)
    end

    FreezeEntityPosition(self.ped, true)
    SetEntityInvincible(self.ped, true)
    SetEntityCollision(self.ped, false, false)
    SetEntityVisible(self.ped, false, false)
    SetEntityAlpha(self.ped, 51, false)
    SetEveryoneIgnorePlayer(self.ped, true)
    SetPoliceIgnorePlayer(self.ped, true)

    DisableControlAction(0, keys["W"], true)
    DisableControlAction(0, keys["S"], true)
    DisableControlAction(0, keys["A"], true)
    DisableControlAction(0, keys["D"], true)
    DisableControlAction(0, keys["SPACE"], true)
    DisableControlAction(0, keys["Z"], true)
    DisableControlAction(0, keys['H'], true)
    DisableControlAction(0, keys['Q'], true)
    DisableControlAction(0, keys['E'], true)
    DisableControlAction(0, keys['LEFTSHIFT'], true)
    DisableControlAction(0, keys['TAB'], true)
    DisableControlAction(0, keys['WHEELUP'], true)
    DisableControlAction(0, keys['WHEELDOWN'], true)

    SetLocalPlayerVisibleLocally(true)
end

function Admin.NoClip:StringLabel(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Admin.NoClip:Label()
    self.scaleform = RequestScaleformMovie("instructional_buttons")

    while not HasScaleformMovieLoaded(self.scaleform) do
        Wait(0)
    end

    BeginScaleformMovieMethod(self.scaleform, "CLEAR_ALL")
    EndScaleformMovieMethod()

    PushScaleformMovieFunction(self.scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, keys.HOME, true))
    self:StringLabel("Désactiver le noclip")
    EndScaleformMovieMethod()

    PushScaleformMovieFunction(self.scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(1)
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, keys.SPACE, true))
    self:StringLabel("Monter")
    EndScaleformMovieMethod()

    PushScaleformMovieFunction(self.scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(2)
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, keys.Z, true))
    self:StringLabel("Descendre")
    EndScaleformMovieMethod()

    PushScaleformMovieFunction(self.scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(3)
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, keys.D, true))
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, keys.A, true))
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, keys.S, true))
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, keys.W, true))
    self:StringLabel("Déplacement")
    EndScaleformMovieMethod()

    PushScaleformMovieFunction(self.scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(4)
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, keys.TAB, true))
    self:StringLabel("Au sol")
    EndScaleformMovieMethod()

    PushScaleformMovieFunction(self.scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(5)
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, keys.RIGHTMOUSE, true))
    self:StringLabel("Vitesse + 2.0")
    EndScaleformMovieMethod()

    PushScaleformMovieFunction(self.scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(5)
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, keys.WHEELUP, true))
    self:StringLabel("Vitesse + 0.1")
    EndScaleformMovieMethod()

    PushScaleformMovieFunction(self.scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(6)
    ScaleformMovieMethodAddParamPlayerNameString(GetControlInstructionalButton(1, keys.WHEELDOWN, true))
    self:StringLabel("Vitesse - 0.1")
    EndScaleformMovieMethod()

    PushScaleformMovieFunction(self.scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(7)
    self:StringLabel(("Vitess: %s"):format(self.currentSpeed))
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(self.scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    ScaleformMovieMethodAddParamInt(0)
    EndScaleformMovieMethod()

    DrawScaleformMovieFullscreen(self.scaleform, 255, 255, 255, 255, 0)
end

function Admin.NoClip:Start()
    self.state = not self.state

    CreateThread(function()
        while self.state do
            Wait(0)
            self:Natives()
            self:Label()

            local yoff = 0.0
            local zoff = 0.0

            if IsDisabledControlJustPressed(1, keys.WHEELDOWN) then
                self.currentSpeed = self.currentSpeed - 0.1
                if self.currentSpeed < 0.0 then
                    self.currentSpeed = 0.0
                end
            end

            if IsDisabledControlJustPressed(1, keys.WHEELUP) then
                self.currentSpeed = self.currentSpeed + 0.1
            end

            if IsDisabledControlJustPressed(1, keys.LEFTSHIFT) then
                self.oldSpeed = self.currentSpeed
                self.currentSpeed = self.fastSpeed
            end

            if IsDisabledControlJustReleased(1, keys.LEFTSHIFT) then
                self.currentSpeed = self.oldSpeed
            end

            if IsDisabledControlPressed(0, keys.W) then
                yoff = self.OffSets.y
            end

            if IsDisabledControlPressed(0, keys.S) then
                yoff = - self.OffSets.y
            end

            if IsControlJustPressed(0, keys.RIGHTMOUSE) then
                self.currentSpeed = self.currentSpeed + 2.0
                if self.currentSpeed > 16.0 then
                    self.currentSpeed = 0.0
                end
            end

            if IsDisabledControlPressed(0, keys.TAB) then
                local height = GetEntityHeightAboveGround(self.noClipEntity)
                local offCoords = GetOffsetFromEntityInWorldCoords(self.noClipEntity,0.0,0.0,0.0)
                SetEntityCoords(self.noClipEntity, offCoords.x, offCoords.y, offCoords.z-height)
            end

            if IsDisabledControlPressed(0, keys.A) then
                SetEntityHeading(self.noClipEntity, GetEntityHeading(self.noClipEntity) + self.OffSets.h)
            end

            if IsDisabledControlPressed(0, keys.D) then
                SetEntityHeading(self.noClipEntity, GetEntityHeading(self.noClipEntity) - self.OffSets.h)
            end

            if IsDisabledControlPressed(0, keys.SPACE) then
                zoff = self.OffSets.z
            end

            if IsDisabledControlPressed(0, keys.Z) then
                zoff = -self.OffSets.z
            end

            local newPos = GetOffsetFromEntityInWorldCoords(self.noClipEntity, 0.0, yoff * (self.currentSpeed + 0.0), zoff * (self.currentSpeed + 0.0))
            local heading = GetEntityHeading(self.noClipEntity)

            SetEntityVelocity(self.noClipEntity, 0.0, 0.0, 0.0)
            SetEntityRotation(self.noClipEntity, 0.0, 0.0, 0.0, 0, false)
            SetEntityHeading(self.noClipEntity, heading)
            SetEntityCoordsNoOffset(self.noClipEntity, newPos.x, newPos.y, newPos.z, self.state, self.state, self.state)
        end

        self:Stop()
    end)
end

function Admin.NoClip:Stop()
    if self.noClipEntity ~= self.ped then
        FreezeEntityPosition(self.noClipEntity, false)
        SetEntityInvincible(self.noClipEntity, false)
        SetEntityCollision(self.noClipEntity, true, true)
        SetEntityVisible(self.noClipEntity, true, false)
        SetLocalPlayerVisibleLocally(true)
        ResetEntityAlpha(self.noClipEntity)
    end

    FreezeEntityPosition(self.ped, false)
    SetEntityInvincible(self.ped, false)
    SetEntityCollision(self.ped, true, true)
    SetEntityVisible(self.ped, true, false)
    SetLocalPlayerVisibleLocally(true)
    ResetEntityAlpha(self.ped)
    SetEveryoneIgnorePlayer(self.ped, false)
    SetPoliceIgnorePlayer(self.ped, false)
end

function Admin.Scan:Start()
    self.active = not self.active
    CreateThread(function()
        local lastEntity = 0

        while self.active do
            local retval, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
            if lastEntity ~= entity and entity ~= 0 then
                lastEntity = entity
                local coords = GetEntityCoords(entity)
                local model = GetEntityModel(entity)
                local txt = ("{model = %s, coords = %s}"):format(model, coords)
                print(txt)
                SendNUIMessage({action = "copy", text = txt})
                while retval == 1 or retval == true do
                    retval, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
                    DrawLine(GetEntityCoords(PlayerPedId()), coords.x, coords.y, coords.z, 255 , 0 , 0 , 255 )
                    Wait(0)
                end
            end
            Wait(0)
        end
    end)
end

function Admin.Shownames:Start()
    self.active = not self.active

    if self.active then
       Utils.Notify("Name over head activée", "success", 3500)
    else
       Utils.Notify("Name over head désactivée", "error", 3500)
    end

    CreateThread(function()
        while self.active do
            local myPlayerId = PlayerId()
            for _, id in ipairs(GetActivePlayers()) do
                if id ~= myPlayerId then
                    local otherPed = GetPlayerPed(id)
                    local pedCoords = GetEntityCoords(otherPed, true)
                    local str = ("[%s] %s"):format(GetPlayerServerId(id), GetPlayerName(id))

                    if IsPedInAnyVehicle(otherPed) then
                        local seatCoords = self:GetSeatCoords(otherPed)
                        if seatCoords then
                            Utils.DrawText3D(vector3(seatCoords.x, seatCoords.y, seatCoords.z + 1.0), str)
                        else
                            Utils.DrawText3D(vector3(pedCoords.x, pedCoords.y, pedCoords.z + 1.0), str)
                        end
                    else
                        Utils.DrawText3D(vector3(pedCoords.x, pedCoords.y, pedCoords.z + 1.0), str)
                    end
                end
            end
            Wait(0)
        end
    end)
end

function Admin.Shownames:GetSeatCoords(ped)
    local vehicle = GetVehiclePedIsIn(ped)

    for k,v in pairs(seats) do
        local pedInSeat = GetPedInVehicleSeat(vehicle, v.seatNum)

        if pedInSeat == ped then
            local boneIndex = GetEntityBoneIndexByName(vehicle, v.seatIndex)
            local coords = GetWorldPositionOfEntityBone(vehicle, boneIndex)

            if coords == vector3(0,0,0) then break end
            return coords
        end
    end

    return GetEntityCoords(ped)
end

function Admin.Blips:Delete()
    for k,v in pairs(self.list) do
        RemoveBlip(v)
    end
    self.list = {}
end

function Admin.Blips:Create(coords, heading)
    local blip = AddBlipForCoord(coords.x,coords.y,coords.z)
    SetBlipSprite(blip, 1)
    ShowHeadingIndicatorOnBlip(blip, true)
    SetBlipRotation(blip, math.ceil(heading))
    SetBlipScale(blip, 0.85)
    SetBlipAsShortRange(blip, true)
    return blip
end

function Admin.Blips:Show()
    self:Delete()
    self.shown = true
    local coords_list = Callback.Sync("plouffe_admin:getPlayersCoords")

    if #coords_list > 0 then
        for k,v in pairs(coords_list) do
            self.list[k] = self:Create(v.coords,v.heading)
        end
    end
end

function Admin.Blips:Start()
    self.active = not self.active

    CreateThread(function()
        while self.active do
            if IsPauseMenuActive() then
                self:Show()
            elseif not IsPauseMenuActive() and self.shown then
                self:Delete()
                self.shown = false
            end

            Wait(2000)
        end

        self:Delete()
    end)
end

function Admin.Cam:Active(moveped)
    self.doCam = not self.doCam

    if not self.doCam then
        return
    end

    CreateThread(function()
        local ped = PlayerPedId()
        self.coords = GetEntityCoords(ped)
        self.rotation = GetEntityRotation(ped)

        self.speed = 1

        self.cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", self.coords, self.rotation, 90.00, true, 0)
        RenderScriptCams(true, false, 1000, true, true)

        self.coords = {x = self.coords.x, y = self.coords.y, z = self.coords.z}
        self.rotation = {x = self.rotation.x, y = self.rotation.y, z = self.rotation.z}

        if moveped then
            SetEntityVisible(ped, false, 0)
        end

        while self.doCam do
            DisableAllControlActions(0)
            DisableAllControlActions(1)
            DisableAllControlActions(2)
            DisableAllControlActions(4)

            if IsDisabledControlJustPressed(1, keys.WHEELDOWN) then
                self.speed = self.speed - 0.1
                if self.speed < 0.0 then
                    self.speed = 0.0
                end
            end

            if IsDisabledControlJustPressed(1, keys.WHEELUP) then
                self.speed = self.speed + 0.1
            end

            if IsDisabledControlPressed(0, keys.W) then
                self.coords.y = self.coords.y + (self.speed / 2)
            end

            if IsDisabledControlPressed(0, keys.S) then
                self.coords.y = self.coords.y - (self.speed / 2)
            end

            if IsDisabledControlPressed(0, keys.A) then
                self.coords.x = self.coords.x - (self.speed / 2)
            end

            if IsDisabledControlPressed(0, keys.D) then
                self.coords.x = self.coords.x + (self.speed / 2)
            end

            if IsDisabledControlPressed(0, keys.SPACE) then
                self.coords.z = self.coords.z + (self.speed / 2)
            end

            if IsDisabledControlPressed(0, keys.Z) then
                self.coords.z = self.coords.z - (self.speed / 2)
            end

            if IsDisabledControlPressed(0, keys.N7) then
                self.rotation.y = self.rotation.y + self.speed
            end

            if IsDisabledControlPressed(0, keys.N9) then
                self.rotation.y = self.rotation.y - self.speed
            end

            if IsDisabledControlPressed(0, keys.N5) then
                self.rotation.x = self.rotation.x - self.speed
            end

            if IsDisabledControlPressed(0, keys.N8) then
                self.rotation.x = self.rotation.x + self.speed
            end

            if IsDisabledControlPressed(0, keys.N4) then
                self.rotation.z = self.rotation.z + self.speed
            end

            if IsDisabledControlPressed(0, keys.N6) then
                self.rotation.z = self.rotation.z - self.speed
            end

            if moveped then
                SetEntityCoords(ped, self.coords.x,self.coords.y,self.coords.z)
            end

            SetCamRot(self.cam, self.rotation.x,self.rotation.y,self.rotation.z, 2)
            SetCamCoord(self.cam, self.coords.x,self.coords.y,self.coords.z)

            Wait(0)
        end

        RenderScriptCams(false, false, 1000, false, false)

        if moveped then
            SetEntityVisible(ped, true, 0)
        end

        DestroyCam(self.cam)

        local camCoords = ("coords = vector3(%s,%s,%s)"):format(self.coords.x,self.coords.y,self.coords.z)
        print(camCoords)
        local camRotation = ("rotation = vector3(%s,%s,%s)"):format(self.rotation.x,self.rotation.y,self.rotation.z)
        print(camRotation)
    end)
end

function Admin.Filter:Active(filter,loop,duration)
    if filter and filter:lower() == "show" then
        for k,v in pairs(self.list) do
            local str = ("Id: %s, filter: %s"):format(k,v)
            print(str)
        end

        return
    end

    if not filter or filter == self.filter then
        AnimpostfxStopAll()
        return
    end

    local duration = tonumber(duration) or 1000000
    local loop = loop and loop:lower() == "false" or true

    self.filter = filter

    local filter = (type(self.filter) == "string" and self.filter) or (tonumber(self.filter) and self.list[tonumber(self.filter) ]) or nil

    if not filter then
        return print(("Invalid filer %s"):format(self.filter))
    end

    AnimpostfxPlay(filter, duration, loop)
end

function Admin.Prop:place(model)
    self.active = not self.active

    if not self.active then
        return
    end

    CreateThread(function()
        local ped = PlayerPedId()
        local offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)

        local entity = Utils.CreateProp(model,{x = offset.x, y = offset.y, z = offset.z - 1.0}, nil, true, true)

        self.coords = GetEntityCoords(entity)
        self.rotation = GetEntityRotation(entity)

        self.speed = 0.1

        self.coords = {x = self.coords.x, y = self.coords.y, z = self.coords.z}
        self.rotation = {x = self.rotation.x, y = self.rotation.y, z = self.rotation.z}

        local entityCoords = nil
        local entityRotation = nil

        while self.active do
            entityCoords = GetOffsetFromEntityInWorldCoords(entity, 0.0, 0.0, -0.0)
            entityRotation = GetEntityRotation(entity)

            SetEntityCoords(diamond, entityCoords.x, entityCoords.y, entityCoords.z)
            SetEntityRotation(diamond, entityRotation.x, entityRotation.y, entityRotation.z)

            DisableAllControlActions(0)
            DisableAllControlActions(1)
            DisableAllControlActions(2)
            DisableAllControlActions(4)

            if IsDisabledControlJustPressed(1, keys.WHEELDOWN) then
                self.speed = self.speed - 0.01
                if self.speed < 0.0 then
                    self.speed = 0.0
                end
            end

            if IsDisabledControlJustPressed(1, keys.WHEELUP) then
                self.speed = self.speed + 0.01
            end

            if IsDisabledControlPressed(0, keys.W) then
                self.coords.y = self.coords.y + (self.speed / 4)
            end

            if IsDisabledControlPressed(0, keys.S) then
                self.coords.y = self.coords.y - (self.speed / 4)
            end

            if IsDisabledControlPressed(0, keys.A) then
                self.coords.x = self.coords.x - (self.speed / 4)
            end

            if IsDisabledControlPressed(0, keys.D) then
                self.coords.x = self.coords.x + (self.speed / 4)
            end

            if IsDisabledControlPressed(0, keys.SPACE) then
                self.coords.z = self.coords.z + (self.speed / 4)
            end

            if IsDisabledControlPressed(0, keys.Z) then
                self.coords.z = self.coords.z - (self.speed / 4)
            end

            if IsDisabledControlPressed(0, keys.N7) then
                self.rotation.y = self.rotation.y + self.speed
            end

            if IsDisabledControlPressed(0, keys.N9) then
                self.rotation.y = self.rotation.y - self.speed
            end

            if IsDisabledControlPressed(0, keys.N5) then
                self.rotation.x = self.rotation.x - self.speed
            end

            if IsDisabledControlPressed(0, keys.N8) then
                self.rotation.x = self.rotation.x + self.speed
            end

            if IsDisabledControlPressed(0, keys.N4) then
                self.rotation.z = self.rotation.z + self.speed
            end

            if IsDisabledControlPressed(0, keys.N6) then
                self.rotation.z = self.rotation.z - self.speed
            end

            SetEntityCoords(entity, self.coords.x,self.coords.y,self.coords.z)
            SetEntityRotation(entity, self.rotation.x,self.rotation.y,self.rotation.z, 2)

            Wait(0)
        end

        local str = (
        [[
            entityCoords = vector3(%s, %s, %s),
            entityRotation = vector3(%s, %s, %s),
        ]]):format(
            self.coords.x,self.coords.y,self.coords.z,
            self.rotation.x,self.rotation.y,self.rotation.z
        )

        print(str)

        DeleteEntity(entity)
    end)
end

function Admin:VehRepair()
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if not DoesEntityExist(vehicle) then
        return
    end

    SetVehicleEngineHealth(vehicle, 1000)
    SetVehicleEngineOn(vehicle, true, true)
    SetVehicleFixed(vehicle)

    exports.plouffe_vehicle:AdminRepairs()
end

function Admin:VehClean()
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if not DoesEntityExist(vehicle) then
        return
    end

    SetVehicleDirtLevel(vehicle,0.0)
    WashDecalsFromVehicle(vehicle,0)
end

function Admin:CopyCoords(type)
    local coords = GetEntityCoords(PlayerPedId())

    if type == 1 then
        SendNUIMessage({action = "copy", text = ("vector3(%s, %s, %s)"):format(coords.x,coords.y,coords.z)})
    elseif type == 2 then
        SendNUIMessage({action = "copy", text = ("vector2(%s, %s)"):format(coords.x,coords.y)})
    elseif type == 3 then
        local heading = GetEntityHeading(PlayerPedId())
        SendNUIMessage({action = "copy", text = ("%s"):format(heading)})
    end
end

function Admin:TpCoords(a,r)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped)
    local x,y,z,coords = nil,nil,nil,nil

    if r:find("vector3") then
        r = r:sub(10,r:len()-1)
        for word in r:gmatch("%S+") do
            local one, two = word:find(",")
            if one and two then
                word = word:sub(0,two - 1)
            end

            if not x then
                x = tonumber(word)
            elseif not y then
                y = tonumber(word)
            elseif not z then
                z = tonumber(word)
            end
        end

        coords = vector3(x,y,z)
    elseif a[1] and a[2] and a[3] then
        coords = vector3(tonumber(a[1]), tonumber(a[2]), tonumber(a[3]))
    end

    if coords then
        SetEntityCoords(Admin.NoClip:Entity(), coords.x,coords.y,coords.z)
    end
end

function Admin:TpBlip()
    local WaypointHandle = GetFirstBlipInfoId(8)

    if DoesBlipExist(WaypointHandle) then
        local blipCoords = GetBlipInfoIdCoord(WaypointHandle)
        local entity = Admin.NoClip:Entity()

        for height = 500, -500, -1 do
            Wait(0)
            SetEntityCoords(entity,blipCoords.x,blipCoords.y,height + 0.0)
            local foundGround, zPos = GetGroundZFor_3dCoord(blipCoords.x,blipCoords.y, height + 0.0)

            if foundGround then
                break
            end
        end

        local height = GetEntityHeightAboveGround(entity)
        local coords = GetEntityCoords(entity)

        SetEntityCoords(entity, coords.x, coords.y, coords.z - height)
    end
end

function Admin:RegisterEvents()
    RegisterNetEvent("plouffe_admin:createVehicle", function(model)
        local car = Utils.SpawnVehicle(model,nil,nil,true,true,true)
        TaskWarpPedIntoVehicle(PlayerPedId(), car, -1)
    end)

    RegisterNetEvent("plouffe_admin:deleteVehicle", function(dst)
        Utils.DeleteVehicle(dst)
    end)
end

function Admin.Start()
    local acces = Callback.Sync("plouffe_admin:getStaff_level")

    if acces <= 0 then
        TriggerServerEvent("plouffe_admin:invalid")
        Admin = nil
        return
    end

    if acces >= 1 then
        RegisterCommand("+noclip", function() end)
        RegisterCommand("-noclip", function()
            Admin.NoClip:Start()
        end)
        RegisterKeyMapping("+noclip", "Noclip", "keyboard", "HOME")

        RegisterCommand("tpcoords", function(s,a,r)
            Admin:TpCoords(a,r:gsub("tpcoords", ""))
        end)

        RegisterCommand("tpm", function(s,a,r)
            Admin:TpBlip()
        end)

        RegisterCommand("showNames", function()
            Admin.Shownames:Start()
        end)

        RegisterCommand("showBlips", function()
            Admin.Blips:Start()
        end)

        Admin:RegisterEvents()
    end

    if acces >= 2 then

    end

    if acces >= 3 then

    end

    if acces >= 4 then

    end

    if acces >= 5 then
        RegisterCommand("scanProps", function()
            Admin.Scan:Start()
        end)
        RegisterCommand("h", function()
            Admin:CopyCoords(3)
        end)
        RegisterCommand("c2", function()
            Admin:CopyCoords(2)
        end)
        RegisterCommand("c", function()
            Admin:CopyCoords(1)
        end)
        RegisterKeyMapping("c", "Sauvegarde des coords", "MOUSE_BUTTON", "MOUSE_EXTRABTN2")

        RegisterCommand("veh:reset", function()
            exports.plouffe_vehicle:ResetValues(GetVehiclePedIsIn(PlayerPedId()), true)
        end)
        RegisterCommand("veh:fullrepair", function()
            exports.plouffe_vehicle:AdminRepairs()
        end)
        RegisterCommand("veh:keys", function()
            exports.plouffe_carkeys:getCurrentVehicleKeys()
        end)
        RegisterCommand("veh:clean", function()
            Admin:VehClean()
        end)
        RegisterCommand("veh:repair", function()
            Admin:VehRepair()
        end)
        RegisterCommand("veh:offset", function()
            exports.plouffe_vehicle:adminOffset()
        end)
        RegisterCommand("veh:audio", function(s,a,r)
            if not a[1] then
                return
            end

            exports.plouffe_vehicle:adminAudio(a[1])
        end)
        
        RegisterCommand("weapon:comp", function(s,a,r)
            local component = GetHashKey(a[1])
            local ped = PlayerPedId()
            local hasWeapon, weaponHash = GetCurrentPedWeapon(ped, 1)

            if hasWeapon and DoesWeaponTakeWeaponComponent(weaponHash, component) then
                if not HasPedGotWeaponComponent(ped, weaponHash, component) then
                    GiveWeaponComponentToPed(ped, weaponHash, component)
                end
            end
        end)

        RegisterCommand("print_cam", function()
            local camCoords = ("coords = vector3(%s,%s,%s)"):format(Admin.Cam.coords.x,Admin.Cam.coords.y,Admin.Cam.coords.z)
            print(camCoords)
            local camRotation = ("rotation = vector3(%s,%s,%s)"):format(Admin.Cam.rotation.x,Admin.Cam.rotation.y,Admin.Cam.rotation.z)
            print(camRotation)
        end)

        RegisterCommand("doCam", function(s,a,r)
            Admin.Cam:Active(a[1] and true or false)
        end)

        RegisterCommand("filter", function(s,a,r)
            Admin.Filter:Active(a[1],a[2],a[3])
        end)

        RegisterCommand("placeProp", function(s,a,r)
            Admin.Prop:place(a[1])
        end)
    end

    return acces
end

Callback.Register("plouffe_admin:validate", Admin.Start)

local cookie
RegisterNetEvent("plouffe_admin:setpopulationmodel", function(model)
    if cookie then
        cookie = nil
        RemoveEventHandler(cookie)
        return
    end

    local newModel = model
    cookie = AddEventHandler("populationPedCreating", function(x, y, z, model, setters)
        Utils.AssureModel(newModel)
        setters.setModel(newModel)
    end)
end)