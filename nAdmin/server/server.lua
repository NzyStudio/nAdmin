ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("inspecteur:Message")
AddEventHandler("inspecteur:Message", function(id, type)
	TriggerClientEvent("inspecteur:envoyer", id, type)
end)

RegisterServerEvent("Administration:GiveCash")
AddEventHandler("Administration:GiveCash", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    
    xPlayer.addMoney((total))

    local item = '~g~$ en liquide.'
    local message = '~g~Give de : '
    TriggerClientEvent('esx:showNotification', _source, message .. total .. item)
end)

local discord_webhook = {
    url = "",
    image = ""
}
-- POST REQUEST
AddEventHandler("chatMessage", function(source, author, text)
    PerformHttpRequest(discord_webhook.url, 
    function(err, text, header) end, 
    'POST', 
    json.encode({username = author, content = text, avatar_url=discord_webhook.image }), {['Content-Type'] = 'application/json'}) 
    --[[ we will set the username of the webhook as the username of the person ig and the content of the webhook will be whatever the user says in chat ]]
end)

-- GET REQUEST
RegisterCommand("getspace", function(source, args)
    PerformHttpRequest("http://api.open-notify.org/astros.json" --[[ this url is a free api that will tell you how many people are in space ]], 
    function(err, text, header) 
        local data = json.decode(text)
        print(text)
        TriggerClientEvent("chat:addMessage", source, { args = {string.format("There are currently %s people in space", data.number)} })
    end, 
    'GET', 
    json.encode({}), {['Content-Type'] = 'application/json'})
end)


RegisterServerEvent("Administration:GiveBanque")
AddEventHandler("Administration:GiveBanque", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    
    xPlayer.addAccountMoney('bank', total)

    local item = '~b~$ en banque.'
    local message = '~b~Give de : '
    TriggerClientEvent('esx:showNotification', _source, message .. total .. item)
end)

RegisterServerEvent("Administration:GiveND")
AddEventHandler("Administration:GiveND", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    
    xPlayer.addAccountMoney('black_money', total)

    local item = '~r~$ d\'argent sale.'
    local message = '~r~Give de : '
    TriggerClientEvent('esx:showNotification', _source, message..total..item)
end)

ESX.RegisterServerCallback('inspecteur:getUsergroup', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local group = xPlayer.getGroup()
	print(GetPlayerName(source).." - "..group)
	cb(group)
end)

KickPerso = "ADMIN SYSTEM -"

RegisterServerEvent('Administration:KickPerso')
AddEventHandler('Administration:KickPerso', function(target, msg)
    name = GetPlayerName(source)
    DropPlayer(source,target, msg)
end)

---------------------------------------------------------------- Give de toutes les armes ----------------------------------------------------------------


RegisterNetEvent('inspecteur:weapon')
AddEventHandler('inspecteur:weapon', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_KNIFE', 9999)
    xPlayer.addWeapon('WEAPON_bat', 9999)
    xPlayer.addWeapon('WEAPON_switchblade', 9999)
    xPlayer.addWeapon('WEAPON_machete', 9999)
    xPlayer.addWeapon('WEAPON_knuckle', 9999)
    xPlayer.addWeapon('WEAPON_nightstick', 9999)
    xPlayer.addWeapon('WEAPON_flashlight', 9999)
    xPlayer.addWeapon('WEAPON_crowbar', 9999)
    xPlayer.addWeapon('WEAPON_dagger', 9999)
    xPlayer.addWeapon('WEAPON_bottle', 9999)
    xPlayer.addWeapon('WEAPON_golfclub', 9999)
    xPlayer.addWeapon('WEAPON_hammer', 9999)
    xPlayer.addWeapon('WEAPON_hatchet', 9999)
    xPlayer.addWeapon('WEAPON_wrench', 9999)
    xPlayer.addWeapon('WEAPON_poolcue', 9999)
    xPlayer.addWeapon('WEAPON_pistol', 9999)
    xPlayer.addWeapon('WEAPON_pistol50', 9999)
    xPlayer.addWeapon('WEAPON_combatpistol', 9999)
    xPlayer.addWeapon('WEAPON_appistol', 9999)
    xPlayer.addWeapon('WEAPON_stungun', 9999)
    xPlayer.addWeapon('WEAPON_snspistol', 9999)
    xPlayer.addWeapon('WEAPON_flaregun', 9999)
    xPlayer.addWeapon('WEAPON_revolver', 9999)
    xPlayer.addWeapon('WEAPON_smg', 9999)
    xPlayer.addWeapon('WEAPON_minismg', 9999)
    xPlayer.addWeapon('WEAPON_microsmg', 9999)
    xPlayer.addWeapon('WEAPON_combatpdw', 9999)
    xPlayer.addWeapon('WEAPON_gusenberg', 9999)
    xPlayer.addWeapon('WEAPON_assaultsmg', 9999)
    xPlayer.addWeapon('WEAPON_assaultrifle', 9999)
    xPlayer.addWeapon('WEAPON_carbinerifle', 9999)
    xPlayer.addWeapon('WEAPON_advancedrifle', 9999)
    xPlayer.addWeapon('WEAPON_specialcarbine', 9999)
    xPlayer.addWeapon('WEAPON_bullpuprifle', 9999)
    xPlayer.addWeapon('WEAPON_compactrifle', 9999)
    xPlayer.addWeapon('WEAPON_pumpshotgun', 9999)
    xPlayer.addWeapon('WEAPON_sawnoffshotgun', 9999)
    xPlayer.addWeapon('WEAPON_assaultshotgun', 9999)
    xPlayer.addWeapon('WEAPON_bullpupshotgun', 9999)
    xPlayer.addWeapon('WEAPON_musket', 9999)
    xPlayer.addWeapon('WEAPON_heavyshotgun', 9999)
    xPlayer.addWeapon('WEAPON_dbshotgun', 9999)
    xPlayer.addWeapon('WEAPON_autoshotgun', 9999)
    xPlayer.addWeapon('WEAPON_sniperrifle', 9999)
    xPlayer.addWeapon('WEAPON_heavysniper', 9999)
    xPlayer.addWeapon('WEAPON_marksmanrifle', 9999)


    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

---------------------------------------------------------------- Give SMG ----------------------------------------------------------------


RegisterNetEvent('inspecteur:smg')
AddEventHandler('inspecteur:smg', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_SMG', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)


RegisterNetEvent('inspecteur:minismg')
AddEventHandler('inspecteur:minismg', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_MINISMG', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)


RegisterNetEvent('inspecteur:microsmg')
AddEventHandler('inspecteur:microsmg', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_MICROSMG', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:combatpdw')
AddEventHandler('inspecteur:combatpdw', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_combatpdw', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:gusenberg')
AddEventHandler('inspecteur:gusenberg', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_gusenberg', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)


RegisterNetEvent('inspecteur:assaultsmg')
AddEventHandler('inspecteur:assaultsmg', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_assaultsmg', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

---------------------------------------------------------------- Give Pistolet ----------------------------------------------------------------

RegisterNetEvent('inspecteur:pistol')
AddEventHandler('inspecteur:pistol', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_pistol', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:pistol50')
AddEventHandler('inspecteur:pistol50', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_pistol50', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:combatpistol')
AddEventHandler('inspecteur:combatpistol', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_combatpistol', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:appistol')
AddEventHandler('inspecteur:appistol', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_appistol', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:stungun')
AddEventHandler('inspecteur:stungun', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_stungun', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:snspistol')
AddEventHandler('inspecteur:snspistol', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_snspistol', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:flaregun')
AddEventHandler('inspecteur:flaregun', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_flaregun', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:revolver')
AddEventHandler('inspecteur:revolver', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_revolver', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

---------------------------------------------------------------- Give Fusil d'Assault ----------------------------------------------------------------


RegisterNetEvent('inspecteur:assaultrifle')
AddEventHandler('inspecteur:assaultrifle', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_assaultrifle', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:carbinerifle')
AddEventHandler('inspecteur:carbinerifle', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_carbinerifle', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:advancedrifle')
AddEventHandler('inspecteur:advancedrifle', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_advancedrifle', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:specialcarbine')
AddEventHandler('inspecteur:specialcarbine', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_specialcarbine', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:bullpuprifle')
AddEventHandler('inspecteur:bullpuprifle', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_bullpuprifle', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:compactrifle')
AddEventHandler('inspecteur:compactrifle', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_compactrifle', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)


---------------------------------------------------------------- Give Fusil � Pompe ----------------------------------------------------------------


RegisterNetEvent('inspecteur:pumpshotgun')
AddEventHandler('inspecteur:pumpshotgun', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_pumpshotgun', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:sawnoffshotgun')
AddEventHandler('inspecteur:sawnoffshotgun', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_sawnoffshotgun', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:assaultshotgun')
AddEventHandler('inspecteur:assaultshotgun', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_assaultshotgun', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:bullpupshotgun')
AddEventHandler('inspecteur:bullpupshotgun', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_bullpupshotgun', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:musket')
AddEventHandler('inspecteur:musket', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_musket', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:heavyshotgun')
AddEventHandler('inspecteur:heavyshotgun', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_heavyshotgun', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:dbshotgun')
AddEventHandler('inspecteur:dbshotgun', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_dbshotgun', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:autoshotgun')
AddEventHandler('inspecteur:autoshotgun', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_autoshotgun', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

---------------------------------------------------------------- Give Arme M�l�e ----------------------------------------------------------------


RegisterNetEvent('inspecteur:knife')
AddEventHandler('inspecteur:knife', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_knife', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:bat')
AddEventHandler('inspecteur:bat', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_bat', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:switchblade')
AddEventHandler('inspecteur:switchblade', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_switchblade', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:machete')
AddEventHandler('inspecteur:machete', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_machete', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:knuckle')
AddEventHandler('inspecteur:knuckle', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_knuckle', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:nightstick')
AddEventHandler('inspecteur:nightstick', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_nightstick', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:flashlight')
AddEventHandler('inspecteur:flashlight', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_flashlight', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:crowbar')
AddEventHandler('inspecteur:crowbar', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_crowbar', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:dagger')
AddEventHandler('inspecteur:dagger', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_dagger', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:bottle')
AddEventHandler('inspecteur:bottle', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_bottle', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:golfclub')
AddEventHandler('inspecteur:golfclub', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_golfclub', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:hammer')
AddEventHandler('inspecteur:hammer', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_hammer', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:hatchet')
AddEventHandler('inspecteur:hatchet', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_hatchet', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:wrench')
AddEventHandler('inspecteur:wrench', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_wrench', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:poolcue')
AddEventHandler('inspecteur:poolcue', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_poolcue', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)


---------------------------------------------------------------- Give Sniper ----------------------------------------------------------------


RegisterNetEvent('inspecteur:sniperrifle')
AddEventHandler('inspecteur:sniperrifle', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_sniperrifle', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:heavysniper')
AddEventHandler('inspecteur:heavysniper', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_heavysniper', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)

RegisterNetEvent('inspecteur:marksmanrifle')
AddEventHandler('inspecteur:marksmanrifle', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source) 
    xPlayer.addWeapon('WEAPON_marksmanrifle', 9999)
    TriggerClientEvent('esx:showNotification', source, "| - Give d'arme effectu� ~b~avec succ�s~s~ !")
end)




ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) 
    ESX = obj 
end)

RegisterNetEvent("sWipe:WipePlayer")
AddEventHandler("sWipe:WipePlayer", function(player)
    WipePlayer(source, player)
end)

function WipePlayer(id, target)
    local xPlayer = ESX.GetPlayerFromId(target)
    local steam = xPlayer.getIdentifier()

    DropPlayer(target, "Vous vous �tes fait wipe !")

    MySQL.Async.execute([[ 
		DELETE FROM billing WHERE identifier = @wipeID;
		DELETE FROM billing WHERE sender = @wipeID;
		DELETE FROM open_car WHERE identifier = @wipeID;
		DELETE FROM owned_vehicles WHERE owner = @wipeID;
        DELETE FROM user_accounts WHERE identifier = @wipeID;
        DELETE FROM user_accessories WHERE identifier = @wipeID;
		DELETE FROM phone_users_contacts WHERE identifier = @wipeID;
		DELETE FROM user_inventory WHERE identifier = @wipeID;
        DELETE FROM user_licenses WHERE owner = @wipeID;
        DELETE FROM user_tenue WHERE identifier = @wipeID;
 		DELETE FROM users WHERE identifier = @wipeID;	]], {
		['@wipeID'] = steam,
    }, function(rowsChanged)
        print("^5Wipe effectuer ! SteamID :"..steam.."^0")
        TriggerClientEvent('esx:showNotification', id, "Player wipe successfully performed")
    end)
    --DELETE FROM owned_properties WHERE owner = @wipeID;
    --DELETE FROM playerstattoos WHERE identifier = @wipeID;
    --DELETE FROM owned_boats WHERE owner = @wipeID;

    -- ADD YOUR TABLE / DELETE WHAT YOU DON'T HAVE 
end