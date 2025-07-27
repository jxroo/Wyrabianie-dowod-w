ESX = exports["es_extended"]:getSharedObject()
Locales = {}

Locales["pl"] = assert(loadfile("locales/pl.lua"))()

RegisterServerEvent("idcard:requestCreate")
AddEventHandler("idcard:requestCreate", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return end

    local itemCount = 0
    if Config.UseOxInventory then
        itemCount = exports.ox_inventory:Search(src, "count", Config.ItemName)
    else
        itemCount = xPlayer.getInventoryItem(Config.ItemName).count
    end

    if itemCount > 0 then
        SendNotification(src, GetLocalized("already_have_id"))
        return
    end

    if Config.RequirePayment and xPlayer.getMoney() < Config.Price then
        SendNotification(src, GetLocalized("not_enough_money"):format(Config.Price))
        return
    end

    if Config.RequirePayment then
        xPlayer.removeMoney(Config.Price)
    end

    Wait(Config.Wait)

    local itemMetadata = {
        first = xPlayer.get("firstName"),
        last = xPlayer.get("lastName"),
        dob = xPlayer.get("dateofbirth"),
        nationality = "Polska"
    }

    if Config.UseOxInventory then
        exports.ox_inventory:AddItem(src, Config.ItemName, 1, itemMetadata)
    else
        xPlayer.addInventoryItem(Config.ItemName, 1)
    end

    SendNotification(src, GetLocalized("id_created"))
end)

RegisterServerEvent("idcard:showid")
AddEventHandler("idcard:showid", function()
    local src = source
    local srcPed = GetPlayerPed(src)
    local srcCoords = GetEntityCoords(srcPed)

    for _, player in pairs(GetPlayers()) do
        local target = tonumber(player)
        if target ~= src then
            local ped = GetPlayerPed(target)
            if #(GetEntityCoords(ped) - srcCoords) <= Config.MaxShowDistance then
                local xPlayer = ESX.GetPlayerFromId(src)
                TriggerClientEvent("idcard:receive", target, {
                    first = xPlayer.get("firstName"),
                    last = xPlayer.get("lastName"),
                    dob = xPlayer.get("dateofbirth"),
                    nationality = "Polska"
                })
            end
        end
    end
end)