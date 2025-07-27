RegisterCommand("showid", function()
    TriggerServerEvent("idcard:showid")
end)

RegisterNetEvent("idcard:receive", function(data)
    SendNUIMessage({
        action = "show",
        data = data
    })
end)

Citizen.CreateThread(function()
    while true do
        local wait = 1000
        local coords = GetEntityCoords(PlayerPedId())
        local dist = #(coords - Config.CityHall)

        if dist < Config.DrawDistance then
            wait = 5
            DrawMarker(1, Config.CityHall.x, Config.CityHall.y, Config.CityHall.z - 1.0,
                0, 0, 0, 0, 0, 0, 1.3, 1.3, 0.5, 0, 200, 255, 120, false, true)

            if dist < 1.5 then
                ESX.ShowHelpNotification("Nacisnij ~INPUT_CONTEXT~ aby wyrobic dowod")
                if IsControlJustReleased(0, 38) then
                    TriggerServerEvent("idcard:requestCreate")
                end
            end
        end
        Wait(wait)
    end
end)