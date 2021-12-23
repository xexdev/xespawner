-- Made by xex#2192 | https://discord.gg/hQkNP48PSm

xex = {}
xex.spawnTimer = 0

ESX = nil

CreateThread(function()
    while ESX == nil do Wait(0)
    	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)

local _, error = pcall(function()
    CreateThread(function()
        while true do Wait(0)
            xex.playerCoords = GetEntityCoords(PlayerPedId())
            for _, spawnerInfo in pairs(xedevCfg.spawnerLocations) do
                xex.dist = #(xex.playerCoords - spawnerInfo.spawnerCoords)
                if xex.dist <= tonumber(xedevCfg.markerDistance) then
                    DrawMarker(1, spawnerInfo.spawnerCoords, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, xedevCfg.markerWidth, xedevCfg.markerWidth, xedevCfg.markerHeight, xedevCfg.markerColor.r, xedevCfg.markerColor.g, xedevCfg.markerColor.b, xedevCfg.markerColor.a, xedevCfg.markerBounce, false, false, false, false, false)
                    if xedevCfg.drawMarkerText then
                        xex.drawMarkerText(spawnerInfo.spawnerCoords.x, spawnerInfo.spawnerCoords.y, spawnerInfo.spawnerCoords.z + 1.0, xedevCfg.markerText)
                    end
                    if xex.dist <= tonumber(xedevCfg.markerWidth) - 0.5 then
                        if IsControlJustPressed(0, xedevCfg.spawnerButton) then
                            xex.spawnerMenyoo(spawnerInfo.carSpawnCoords, spawnerInfo.carSpawnHeading)
                        end
                    end
                end
            end
        end
    end)

    function xex.spawnerMenyoo(vehicleSpawnCoords, vehicleSpawnHeading)
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'general_menu', {
            title = 'Vehicle Spawner',
            align = "right",
            elements = xedevCfg.spawnerList
        },  function(data, menu)
            menu.close()
            xex.isMenuOpen = false

            if data.current.modelName then
                xex.spawnVehicle(data.current.modelName, data.current.price, vehicleSpawnCoords, vehicleSpawnHeading)
            end
        end,
        function(data, menu)
            menu.close()
            xex.isMenuOpen = false
        end)
    end

    function xex.spawnVehicle(vehicleModel, vehiclePrice, vehicleSpawnCoords, vehicleSpawnHeading)
        if vehicleModel then
            xex.vehicleHash = GetHashKey(vehicleModel)
            RequestModel(xex.vehicleHash)

            while not HasModelLoaded(xex.vehicleHash) do Wait(100) 
                xex.vehicleWait = xex.vehicleWait + 100
                if xex.vehicleWait > 10000 then
                    break
                end
            end

            xex.createdVehicle = CreateVehicle(xex.vehicleHash, vehicleSpawnCoords, vehicleSpawnHeading, true, false)
            SetPedIntoVehicle(PlayerPedId(), xex.createdVehicle, -1)
            SetVehicleEngineOn(xex.createdVehicle, true, true, false)
            SetVehRadioStation(xex.createdVehicle, "OFF")

            if xedevCfg.enablePrice then
                TriggerServerEvent('xedev:spawnerPrice', vehiclePrice)
            end

            xex.spawnTimer = 1500
            while xex.spawnTimer > 0 do Wait(0)
                xex.spawnTimer = xex.spawnTimer - 1
                xex.vehicleList = GetGamePool("CVehicle")
                for i = 1, #xex.vehicleList do
                    xex.vehiclesListed = xex.vehicleList[i]
                    SetEntityNoCollisionEntity(xex.createdVehicle, xex.vehiclesListed, true)
                    SetEntityNoCollisionEntity(xex.vehiclesListed, xex.createdVehicle, true)
                end
            end
        end
    end

    function xex.drawMarkerText(x, y, z, text)
        xex.onScreen, xex._x, xex._y = World3dToScreen2d(x, y, z)
        xex.camCoords = GetGameplayCamCoords()
        xex.distance = GetDistanceBetweenCoords(xex.camCoords.x, xex.camCoords.y, xex.camCoords.z, x, y, z, 1)
        xex.scale = (1 / xex.distance) * 2
        xex.fov = (1 / GetGameplayCamFov()) * 100
        xex.scale = xex.scale * xex.fov

        if xex.onScreen then
    		SetTextScale(0.35, 0.35)
    		SetTextFont(4)
    		SetTextProportional(1)
    		SetTextColour(255, 255, 255, 215)
    		SetTextEntry("STRING")
    		SetTextCentre(1)
    		AddTextComponentString(text)
    		DrawText(xex._x,xex._y)
    	    xex.factor = (string.len(text)) / 370
    		DrawRect(xex._x, xex._y+0.0125, 0.015+ xex.factor, 0.03, 0, 0, 0, 68)
        end
    end
end)

if error then
    print('^5[XeSpawner] ^2[ERROR]: ' .. error)
end