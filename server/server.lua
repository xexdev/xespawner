-- Made by xex#2192 | https://discord.gg/hQkNP48PSm

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('xedev:spawnerPrice')
AddEventHandler('xedev:spawnerPrice', function(price)
    if price > 0 then
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeAccountMoney('bank', price)
    end
end)