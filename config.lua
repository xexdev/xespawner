-- Made by xex#2192 | https://discord.gg/hQkNP48PSm

xedevCfg = {}
xedevCfg.spawnerButton = 38 -- FiveM keylist (https://docs.fivem.net/docs/game-references/controls/)
xedevCfg.enablePrice = false -- Enable a price to spawn in vehicles
xedevCfg.drawMarkerText = true -- Enable text above the marker
xedevCfg.markerText = 'Press [~b~E~w~] to spawn a vehicle' -- Text above the marker
xedevCfg.markerDistance = 15.0 -- Distance at which marker becomes visible to players
xedevCfg.markerWidth = 2.0 -- Width of the marker
xedevCfg.markerHeight = 1.0 -- Height of the marker
xedevCfg.markerBounce = false -- Whether or not the marker will bounce
xedevCfg.markerId = 1 -- FiveM marker id's (https://docs.fivem.net/docs/game-references/markers/)
xedevCfg.markerColor = {r = 0, g = 201, b = 255, a = 100} -- Color of the marker id

-- Locations of vehicle spawners.
xedevCfg.spawnerLocations = {
    {name = 'Grove Street', spawnerCoords = vector3(108.36, -1943.07, 19.8), carSpawnCoords = vector3(99.33, -1935.15, 19.8), carSpawnHeading = 49.01},
    {name = 'Example', spawnerCoords = vector3(0.0, 0.0, 0.0), carSpawnCoords = vector3(0.0, 0.0, 0.0), carSpawnHeading = 0.0},
}

-- Put vehicle names and prices here.
xedevCfg.spawnerList = {
    {label = 'Adder', modelName = 'adder', price = 2000},
    {label = 'Elegy', modelName = 'elegy2', price = 0},
}