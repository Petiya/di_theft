📖 di_theft - QBCore Prop Theft Script
A FiveM script that allows players to steal props with configurable outcomes, including item break chances, police alerts, and rewards.

📌 Features
✅ Customizable Props – Easily add new stealable props in the config.
✅ Item Requirements – Players need specific tools (e.g., wrench, drill) to steal props.
✅ Break Chance System – Tools can break, giving players a replacement item.
✅ Police Alerts – Configurable chance to notify law enforcement.
✅ Reward System – Players receive items upon successful theft.
✅ Animations – Each prop has a unique interaction animation.

📂 Installation
Download & Extract

Place the di_theft folder in your resources directory.

Dependencies

Ensure these resources are running:

qb-core

qb-target

qb-inventory (for item handling)

qb-policejob (for police alerts)

Add Required Items

Add these to your qb-core/shared/items.lua:

lua

["weapon_wrench"] = { name = "weapon_wrench", label = "Wrench", weight = 1000, type = "weapon", ... },
["drill"] = { name = "drill", label = "Drill", weight = 5000, ... },
["ac_broken"] = { name = "ac_broken", label = "Broken AC Unit", weight = 2000, ... },
["ac"] = { name = "ac", label = "AC Unit", weight = 3000, ... },
["steel"] = { name = "steel", label = "Steel Scrap", weight = 1000, ... },
["iron"] = { name = "iron", label = "Iron Scrap", weight = 1000, ... },
Start the Script

Add ensure di_theft to your server.cfg.

⚙️ Configuration
Edit config.lua to customize props:

lua
Config.Props = {
    {
        propName = "prop_oldlight_01a", -- Model name
        displayName = "AC Vent", -- Interaction label
        requiredItem = "weapon_wrench", -- Needed tool
        breakChance = 50, -- % chance the tool breaks
        brokenItem = "steel", -- Item given if tool breaks
        policeNotifyChance = 50, -- % chance cops are alerted
        animation = { -- Animation played
            dict = "mini@repair",
            anim = "fixing_a_ped",
            flags = 16
        },
        rewardItems = { -- Rewards on success
            { name = "ac_broken", amount = 1 }
        }
    },
    -- Add more props here
}
🔧 How It Works
Player Interaction

Players target a prop (e.g., AC Vent) with the required tool.

A progress bar with a custom animation plays.

Outcomes

Success: Player gets reward items.

Tool Break: If the break chance triggers, the tool is removed, and a replacement item is given.

Police Alert: If the police notify chance triggers, officers receive a dispatch alert.

Prop Removal

The stolen prop is deleted from the world.

📜 License
This project is licensed under MIT – free to use and modify.

🔗 Links
GitHub: [https://github.com/YourUsername/di_theft](https://github.com/Petiya/di_theft)

QBCore Framework: https://qbcore.org

Enjoy immersive theft mechanics in your FiveM server! 🚔🔧💰
