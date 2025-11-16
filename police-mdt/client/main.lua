-- client/main.lua
local mdtOpen = false

RegisterCommand("mdt", function()
    mdtOpen = not mdtOpen
    SetNuiFocus(mdtOpen, mdtOpen)
    SendNUIMessage({
        type = "ui",
        status = mdtOpen
    })
end, false)

RegisterNUICallback("closeMDT", function(data, cb)
    mdtOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "ui",
        status = mdtOpen
    })
    cb("ok")
end)

-- Data fetching
RegisterNUICallback("getIncidents", function(data, cb)
    TriggerServerEvent('qb-police-mdt:server:getIncidents')
    cb("ok")
end)

RegisterNetEvent('qb-police-mdt:client:receiveIncidents', function(incidents)
    SendNUIMessage({
        type = "receiveIncidents",
        data = incidents
    })
end)

RegisterNUICallback("getCivilians", function(data, cb)
    TriggerServerEvent('qb-police-mdt:server:getCivilians')
    cb("ok")
end)

RegisterNetEvent('qb-police-mdt:client:receiveCivilians', function(civilians)
    SendNUIMessage({
        type = "receiveCivilians",
        data = civilians
    })
end)

RegisterNUICallback("getCommands", function(data, cb)
    TriggerServerEvent('qb-police-mdt:server:getCommands')
    cb("ok")
end)

RegisterNetEvent('qb-police-mdt:client:receiveCommands', function(commands)
    SendNUIMessage({
        type = "receiveCommands",
        data = commands
    })
end)
