local floatingText = nil
local floatingTextCoords = nil

-- Listen for server events
RegisterNetEvent('do:createFloatingText', function(text)
    floatingText = text
    local playerPed = PlayerPedId()
    local waistBone = GetPedBoneIndex(playerPed, 0x0cc49bbe) -- Waist bone SKEL_Spine2
    floatingTextCoords = GetWorldPositionOfEntityBone(playerPed, waistBone)
    
    TriggerEvent('chat:addMessage', {
        color = {0, 255, 0},
        multiline = true,
        args = {"DO", text}
    })
end)

RegisterNetEvent('do:removeFloatingText', function()
    if floatingText ~= nil then
        floatingText = nil
        floatingTextCoords = nil
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
end)

-- Render the floating text on screen
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if floatingText ~= nil then
            local playerPed = PlayerPedId()
            local waistBone = GetPedBoneIndex(playerPed, 0x0cc49bbe)
            local waistCoords = GetWorldPositionOfEntityBone(playerPed, waistBone)
            
            -- Display 3D text above the waist
            DrawText3D(waistCoords.x, waistCoords.y, waistCoords.z + 0.7, floatingText)
        end
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(x, y, z) - vector3(px, py, pz))
    
    local scale = (1 / dist) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    
    if onScreen then
        SetTextScale(0.0 * scale, 0.55 * scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        BeginTextCommandDisplayText("STRING")
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
    end
end
