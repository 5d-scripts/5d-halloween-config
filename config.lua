_CONFIG = 
{
    locale = "en", -- Script Language (de/en)
    
    enableWeather = true, -- Enable Halloween Weather. Make sure to disable other weather scripts that may interfere with this.
    forceDark = true, -- Freezes Game Time at 00:00

    pumpkinItemName = "pumpkin",
    Pumpkins =  -- Possible Pumpkin Spawn Locations (Substract 11.0 from z coordinate to place pumpkin on ground)
    {
        vector3(198.7883, -807.2205, 20.0801),
        vector3(213.4520, -862.1310, 19.4323),
        vector3(173.3169, -986.0281, 19.9532),
        vector3(163.1446, -973.3223, 19.9532),
        vector3(175.8181, -951.4478, 19.9121),
        vector3(213.8375, -808.5910, 22.9223),
    },

    SpawnController = 
    {
        pumpkinAmount = 3, -- Spawn 3 Pumpkins at a random location
        delayMinutes = 30, -- Set the Spawn Delay in Minutes (Spawns 3 pumpkins every 5 minutes)
        globalAnnounceSpawn = true, -- Enable/Disable Global Announcement when a Pumpkin is spawned
        globalAnnounceCollection = true, -- Enable/Disable Global Announcement when a Pumpkin is collected
        playSound = true -- Play random scary sound when player is near a pumpkin
    },

    PumpkinNPC = -- Pumpkin NPC Trader. Collected Pumpkins can be traded for a random reward here.
    {
        ped = 
        {
            model = "pinhead",
            coords = vector4(197.5656, -934.5964, 29.6867, 144.5967)
        },
        blip = 
        {
            enabled = true,
            label = "Michael Myers",
            sprite = 84, -- https://wiki.rage.mp/index.php?title=Blips
            color = 3, -- https://wiki.rage.mp/index.php?title=Blips
            asShortRange = true, -- true = only shows blip on minimap when player is close to it
            scale = 0.9
        },
        items = -- Possible random rewards. Chances are weighted and processed using a cumulative distribution function. Chances dont have to add up to 100%!
        {
            {
                name = "WEAPON_PISTOL",
                label = "Pistole",
                type = "weapon",
                ammo = 200,
                chance = 0.3, 
            },
            {
                name = "adder",
                label = "Adder",
                type = "vehicle",
                chance = 0.85,
            },
            {
                name = "gps",
                label = "GPS",
                type = "item",
                amount = 1,
                chance = 0.3,
            },
            {
                name = "backpack",
                label = "Backpack", 
                type = "item",
                amount = 1,
                chance = 0.25,
            },
            {
                name = "water",
                label = "Water", 
                type = "item",
                amount = 10,
                chance = 0.25,
            },
            {
                name = "money",
                label = "Cash", 
                type = "account",
                amount = 50000,
                chance = 0.5,
            }
        }
    },

    sweetsItemName = "sweets",
    SweetsReward = 
    {
        delayMinutes = 15, -- Give players sweets every 15 minutes (server side, not based on client playtime)
        minSweets = 1, -- Give players a minimum of 1 sweets per 15 minutes. 
        maxSweets = 5, -- Give players a maximum of 5 sweets per 15 minutes.
    },
    globalAnnounceOffer = true, -- Enable/Disable Global Announcement when sweets are offered to Pennywise.
    SweetsNPC = -- Sweets NPC. Sweets recieved for playing on the server can be offered here. Set community goals for more rewards!
    {
        ped = 
        {
            model = "pennywise",
            coords = vector4(204.9418, -939.4309, 29.6868, 142.1200)
        },
        blip = 
        {
            enabled = true,
            label = "Pennywise",
            sprite = 84, -- https://wiki.rage.mp/index.php?title=Blips
            color = 3, -- https://wiki.rage.mp/index.php?title=Blips
            asShortRange = true, -- true = only shows blip on minimap when player is close to it
            scale = 0.9
        },
    },

    Util = -- Util Functions used by the script, feel free to modify them to your liking.
    {
        generateRandomPlate = function() -- Function used to generate a random vehicle plate
                                         -- Produces a random string in the format "AAA 111"
            local plate = ""
            for i = 1, 3 do
                plate = plate .. string.char(math.random(65, 90))
            end
            plate = plate .. " "
            for i = 1, 3 do
                plate = plate .. string.char(math.random(48, 57))
            end

            return plate
        end,

        createDBVehicle = function(xPlayer, model, plate, reward) -- We pass the entire reward object so you can add custom config entries and modify the query.
            MySQL.Async.execute("INSERT INTO owned_vehicles (owner,plate,vehicle,`stored`) VALUES(?,?,?,1)", {xPlayer.getIdentifier(), plate, json.encode({
                model = GetHashKey(model),
                plate = plate
            })})
        end
    }
}

if (not IsDuplicityVersion()) then
    RegisterNetEvent("5d-halloween:notify", function(msg)
        ESX.ShowNotification(msg)
    end)
    RegisterNetEvent("5d-halloween:announce", function(msg)
        ESX.ShowNotification(msg)
    end)

    RegisterNetEvent("5d-halloween:helpNotify:show", function(message)
        TriggerEvent("5d-helpnotify:showHelpNotification", message)
    end)

    RegisterNetEvent("5d-halloween:helpNotify:hide", function()
        TriggerEvent("5d-helpnotify:closeHelpNotification")
    end)
end


