-- Simple client-side /do command handler
local floatingText = nil

-- Register command on client
RegisterCommand('do', function(source, args, rawCommand)
    if #args == 0 then
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"ERROR", "Usage: /do [text]"}
        })
        return
    end

    local text = table.concat(args, " ")
    floatingText = text
    
    TriggerEvent('chat:addMessage', {
        color = {0, 255, 0},
        multiline = true,
        args = {"DO", text}
    })
end, false)

RegisterCommand('removedo', function(source, args, rawCommand)
    if floatingText ~= nil then
        floatingText = nil
        TriggerEvent('chat:addMessage', {
            color = {0, 255, 0},
            multiline = true,
            args = {"DO", "Removed floating text"}
        })
    else
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"ERROR", "No floating text to remove"}
        })
    end
end, false)

-- Render the floating text on screen
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if floatingText ~= nil then
            local playerPed = PlayerPedId()
            if playerPed ~= 0 then
                local waistBone = GetPedBoneIndex(playerPed, 0x0cc49bbe) -- Waist bone
                if waistBone ~= 0 then
                    local waistCoords = GetWorldPositionOfEntityBone(playerPed, waistBone)
                    DrawText3D(waistCoords.x, waistCoords.y, waistCoords.z + 1.0, floatingText)
                end
            end
        end
    end
end)

function DrawText3D(x, y, z, text)
    local camCoords = GetGameplayCamCoords()
    local distance = #(vector3(x, y, z) - camCoords)
    
    local onScreen, screenX, screenY = World3dToScreen2d(x, y, z)
    if not onScreen then return end
    
    -- Scale based on distance
    local scale = (1.0 / distance) * 2.0
    local fov = (1.0 / GetGameplayCamFov()) * 100.0
    local finalScale = scale * fov
    
    SetTextScale(0.0 * finalScale, 0.5 * finalScale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
    SetTextCentre(1)
    
    BeginTextCommandDisplayText("STRING")
    AddTextComponentString(text)
    EndTextCommandDisplayText(screenX, screenY)
end
