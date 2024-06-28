local mysql = exports['oxmysql']

RegisterServerEvent('useTestDepoudre')
AddEventHandler('useTestDepoudre', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Vérifier si le joueur est EMS et a l'item "testdepoudre" dans son inventaire
    if xPlayer.job.name == 'ambulance' and xPlayer.getInventoryItem('testdepoudre').count > 0 then
        local closestPlayerId = GetClosestPlayer()

        if closestPlayerId then
            local twoHoursAgo = os.time() - (2 * 60 * 60) 
            
            local selectQuery = [[
                SELECT COUNT(*) AS count
                FROM player_shots
                WHERE player_id = @player_id AND shot_time >= @two_hours_ago
            ]]
            local selectParams = {
                ['player_id'] = closestPlayerId,
                ['two_hours_ago'] = twoHoursAgo
            }
            mysql:scalar(selectQuery, selectParams, function(count)
                if count > 0 then
                    TriggerClientEvent('displayMessage', _source, 'Le joueur le plus proche a tiré il y a environ 2 heures.')
                else
                    TriggerClientEvent('displayMessage', _source, 'Le joueur le plus proche n\'a pas tiré il y a 2 heures.')
                end
            end)
        else
            TriggerClientEvent('displayMessage', _source, 'Aucun joueur à proximité pour utiliser testdepoudre.')
        end
    else
        -- Si les conditions ne sont pas remplies, envoyer un message d'erreur au client
        TriggerClientEvent('displayMessage', _source, 'Vous n\'avez pas la permission d\'utiliser cet item ou vous n\'avez pas cet item dans votre inventaire.')
    end
end)

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayerId = nil

    for _, playerId in ipairs(players) do
        local playerPed = GetPlayerPed(playerId)
        local playerCoords = GetEntityCoords(playerPed)
        local distance = #(GetEntityCoords(GetPlayerPed(-1)) - playerCoords)

        if closestDistance == -1 or distance < closestDistance then
            closestDistance = distance
            closestPlayerId = playerId
        end
    end

    return closestPlayerId
end

function GetPlayers()
    local players = {}

    for _, playerId in ipairs(GetActivePlayers()) do
        table.insert(players, playerId)
    end

    return players
end
