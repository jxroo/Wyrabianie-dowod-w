function SendNotification(src, msg)
    TriggerClientEvent("esx:showNotification", src, msg)
end

function GetLocalized(key)
    return Locales[Config.Locale][key] or key
end