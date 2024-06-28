function DisplayNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, false)
end

RegisterCommand('testdepoudre', function()
    TriggerServerEvent('useTestDepoudre')
end)

RegisterNetEvent('displayMessage')
AddEventHandler('displayMessage', function(message)
    DisplayNotification(message)
end)
