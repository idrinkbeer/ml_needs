# made by 
mrlupo & duck


# ml_needs


Add ensure ml_needs to your server.cfg

Add water and bread  as a usable item in redemrp_inventory V2 config.lua
Example :
```
["water"] =
    {
        label = "Water",
        description = "Simple drink",
        weight = 0.3,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 32,
        imgsrc = "items/water.png",
        type = "item_standard",

    },

    ["bread"] =
    {
        label = "Bread",
        description = "Simple food",
        weight = 0.1,
        canBeDropped = true,
        canBeUsed = true,
        requireLvl = 0,
        limit = 20,
        imgsrc = "items/bread.png",
        type = "item_standard",


    },
```

Add water and bread  as a item for sale in your shops

# What this is
this is a basic food and water on a timer
has drinking anin
has eating anim 


resets stats after player is revived/healed just trigger this in redemrp_respawn = TriggerEvent("fsn_needs:resetall")

# req 
- redemrp_roleplay - https://github.com/RedEM-RP/redem_roleplay

 - redemrp_inventory V2 - https://github.com/RedEM-RP/redemrp_inventory

# info

please remember this is a very basic script for yous to have fun with :)
