Config = {}
Config.DrawDistance = 15
Config.Size         = {x = 0.8, y = 1.0, z = 0.5}
Config.Color        = {r = 255, g = 0, b = 0}
Config.Type         = 2
Config.OnlyFirstname     = true

Config.GetPlayerMoney = function(action)
    TriggerServerEvent("bank:solde", action)
end