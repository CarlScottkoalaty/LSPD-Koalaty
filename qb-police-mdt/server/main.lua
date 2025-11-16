-- server/main.lua
QBCore = exports['qb-core']:GetCoreObject()

-- Incidents
local incidents = {
    { id = 1, title = 'Robbery at 24/7', status = 'Active', officer = 'John Doe' },
    { id = 2, title = 'Stolen Vehicle', status = 'Closed', officer = 'Jane Smith' },
    { id = 3, title = 'Shots Fired', status = 'Active', officer = 'Jim Brown' },
}

RegisterNetEvent('qb-police-mdt:server:getIncidents', function()
    local src = source
    TriggerClientEvent('qb-police-mdt:client:receiveIncidents', src, incidents)
end)

-- Civilians
local civilians = {
    { id = 1, name = 'John Doe', dob = '1990-01-01', notes = 'Known associate of the Vagos.' },
    { id = 2, name = 'Jane Smith', dob = '1985-05-12', notes = 'No prior offenses.' },
    { id = 3, name = 'Jim Brown', dob = '1992-08-23', notes = 'Warrant out for arrest.' },
}

RegisterNetEvent('qb-police-mdt:server:getCivilians', function()
    local src = source
    TriggerClientEvent('qb-police-mdt:client:receiveCivilians', src, civilians)
end)

-- Commands
local commands = {
    { name = 'cuff [id]', description = 'Cuff a player.' },
    { name = 'uncuff [id]', description = 'Uncuff a player.' },
    { name = 'impound', description = 'Impound the nearest vehicle.' },
    { name = 'jail [id] [time]', description = 'Jail a player.' },
}

RegisterNetEvent('qb-police-mdt:server:getCommands', function()
    local src = source
    TriggerClientEvent('qb-police-mdt:client:receiveCommands', src, commands)
end)
