local QBCore = exports['qb-core']:GetCoreObject()

-- Callback to check if the player has the required item
QBCore.Functions.CreateCallback('citylife-secret:checkItem', function(source, cb, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.GetItemByName(item) then
        cb(true)
    else
        cb(false)
    end
end)

-- Function to notify the police
local function NotifyPolice(coords, propName)
    local message = "Suspicious activity reported: Someone is stealing a " .. propName
    local alertData = {
        title = "Theft in Progress",
        coords = coords,
        description = message
    }
    TriggerClientEvent('qb-policealert:client:AddPoliceAlert', -1, alertData) -- Notify all police players
    print("Police notified about theft of " .. propName)
end

-- Event to handle stealing the prop
RegisterServerEvent('citylife-secret:stealProp')
AddEventHandler('citylife-secret:stealProp', function(propIndex)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local propConfig = Config.Props[propIndex]

    -- Add reward items to the player's inventory
    for _, reward in ipairs(propConfig.rewardItems) do
        Player.Functions.AddItem(reward.name, reward.amount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[reward.name], "add")
    end

    -- Handle required item break chance
    local breakChance = propConfig.breakChance or 0 -- Default to 0 if not set
    if breakChance > 0 then
        local randomChance = math.random(1, 100)
        if randomChance <= breakChance then
            -- Remove the required item
            Player.Functions.RemoveItem(propConfig.requiredItem, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[propConfig.requiredItem], "remove")

            -- Add the broken item (if specified)
            if propConfig.brokenItem then
                Player.Functions.AddItem(propConfig.brokenItem, 1)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[propConfig.brokenItem], "add")
            end

            -- Notify the player
            QBCore.Functions.Notify("Your " .. QBCore.Shared.Items[propConfig.requiredItem].label .. " broke!", "error")
        end
    end

    -- Handle police notification chance
    local policeNotifyChance = propConfig.policeNotifyChance or 0 -- Default to 0 if not set
    if policeNotifyChance > 0 then
        local randomChance = math.random(1, 100)
        if randomChance <= policeNotifyChance then
            -- Get the player's coordinates
            local playerPed = GetPlayerPed(src)
            local playerCoords = GetEntityCoords(playerPed)
            -- Notify the police
            NotifyPolice(playerCoords, propConfig.displayName)
        end
    end
end)