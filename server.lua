-- Server-side script for /do command (QBCore)

-- Command registration (can be done on client, but server-side is better for security)
RegisterCommand('do', function(source, args, rawCommand)
    if #args == 0 then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"ERROR", "Usage: /do [text]"}
        })
        return
    end

    local text = table.concat(args, " ")
    
    -- Trigger client event to display the floating text
    TriggerClientEvent('do:createFloatingText', source, text)
    
    TriggerClientEvent('chat:addMessage', source, {
        color = {0, 255, 0},
        multiline = true,
        args = {"DO", text}
    })
end, false)

RegisterCommand('removedo', function(source, args, rawCommand)
    -- Trigger client event to remove the floating text
    TriggerClientEvent('do:removeFloatingText', source)
end, false)
