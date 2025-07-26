
Config = {}

Config.Props = {
    {
        propName = "prop_oldlight_01a", -- Model name of the prop
        displayName = "AC Vent", -- Custom display name for the prop
        requiredItem = "weapon_wrench", -- Item required to steal the prop
        breakChance = 50, -- 50% chance the required item will break
        brokenItem = "steel", -- Item to give if the required item breaks
        policeNotifyChance = 50, -- 50% chance the police will be notified
        animation = { -- Custom animation for this prop
            dict = "mini@repair",
            anim = "fixing_a_ped",
            flags = 16
        },
        rewardItems = {
            { name = "ac_broken", amount = 1 }--, -- Item the player receives
            --{ name = "cash", amount = 500 } -- Additional reward
        }
    },
    {
        propName = "prop_aircon_m_06", -- Model name of the prop
        displayName = "Air Conditioner", -- Custom display name for the prop
        requiredItem = "drill", -- Item required to steal the prop
        breakChance = 50, -- 50% chance the required item will break
        brokenItem = "iron", -- Item to give if the required item breaks
        policeNotifyChance = 100, -- 100% chance the police will be notified
        animation = { -- Custom animation for this prop
            dict = "amb@world_human_hammering@male@base",
            anim = "base",
            flags = 16
        },
        rewardItems = {
            { name = "ac", amount = 2 }--, -- Item the player receives
            --{ name = "cash", amount = 300 } -- Additional reward
        }
    },
    -- Add more props as needed
}