local QBCore = exports['qb-core']:GetCoreObject()

-- Function to add qb-target options for default props
local function AddTargetForProps()
    for index, propConfig in ipairs(Config.Props) do
        exports['qb-target']:AddTargetModel(propConfig.propName, {
            options = {
                {
                    type = "client",
                    event = "citylife-secret:stealProp",
                    icon = "fas fa-hand",
                    label = "Steal " .. propConfig.displayName, -- Use custom display name
                    propIndex = index, -- Pass the prop index to the event
                    requiredItem = propConfig.requiredItem -- Pass the required item
                }
            },
            distance = 2.0
        })
    end
end

-- Event to handle stealing the prop
RegisterNetEvent('citylife-secret:stealProp', function(data)
    local propConfig = Config.Props[data.propIndex]

    QBCore.Functions.TriggerCallback('citylife-secret:checkItem', function(hasItem)
        if hasItem then
            QBCore.Functions.Progressbar("stealing_prop", "Stealing " .. propConfig.displayName, 5000, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = propConfig.animation.dict,
                anim = propConfig.animation.anim,
                flags = propConfig.animation.flags,
            }, {}, {}, function() -- Done
                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local prop = GetClosestObjectOfType(playerCoords, 2.0, GetHashKey(propConfig.propName), false, false, false)

                if DoesEntityExist(prop) then
                    -- Debug log to confirm the prop is found
                    print("Prop found:", propConfig.propName)

                    -- Set the prop as a mission entity to prevent it from being respawned
                    SetEntityAsMissionEntity(prop, true, true)
                    print("Prop set as mission entity:", propConfig.propName)

                    -- Delete the prop
                    DeleteEntity(prop)
                    print("Prop deleted:", propConfig.propName)

                    -- Trigger server event to give rewards and handle item break chance
                    TriggerServerEvent('citylife-secret:stealProp', data.propIndex)
                    QBCore.Functions.Notify("You stole a " .. propConfig.displayName, "success")
                else
                    -- Debug log if the prop is not found
                    print("Prop not found:", propConfig.propName)
                    QBCore.Functions.Notify("The prop is no longer available.", "error")
                end
            end, function() -- Cancel
                QBCore.Functions.Notify("Cancelled", "error")
            end)
        else
            QBCore.Functions.Notify("You need a " .. propConfig.requiredItem .. " to steal this " .. propConfig.displayName .. ".", "error")
        end
    end, propConfig.requiredItem)
end)

-- Main thread to add target options for props
CreateThread(function()
    AddTargetForProps()
end)