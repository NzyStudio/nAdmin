ESX = nil
local PlayerData = {}
local colors = {"~p~", "~r~","~o~","~y~","~c~","~g~","~b~"}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
    end
end)

godmode, visible, gamerTags, freeze = false, false, false, {}, false

RMenu.Add('nMenuadmin', 'main', RageUI.CreateMenu("Menu Staff", " "))
RMenu.Add('nMenuadmin', 'staff', RageUI.CreateMenu("Réservé Staff", " "))
RMenu:Get('nMenuadmin', 'main'):SetSubtitle("Salut~b~ ".. GetPlayerName(PlayerId()) .. '')
RMenu.Add('nMenuadmin', 'main3', RageUI.CreateSubMenu(RMenu:Get('nMenuadmin', 'main'), "Actions Personelles", " "))
RMenu.Add('menu', 'gestion', RageUI.CreateSubMenu(RMenu:Get('nMenuadmin', 'main'), "Joueurs", " "))
RMenu.Add('menu', 'options', RageUI.CreateSubMenu(RMenu:Get('menu', 'gestion'), "Gestion du Joueur", "Actions Disponibles"))
RMenu.Add('nMenuadmin', 'main4', RageUI.CreateSubMenu(RMenu:Get('nMenuadmin', 'main'), "Actions Véhicules", " "))
RMenu.Add('nMenuadmin', 'main6', RageUI.CreateSubMenu(RMenu:Get('nMenuadmin', 'main'), "Menu Touches", " "))
RMenu.Add('nMenuadmin', 'main7', RageUI.CreateSubMenu(RMenu:Get('nMenuadmin', 'main'), "Actions Staf2f", " "))
RMenu.Add('nMenuadmin', 'main7', RageUI.CreateSubMenu(RMenu:Get('nMenuadmin', 'main'), "Actions Staff", " "))
RMenu.Add('nMenuadmin', 'temps', RageUI.CreateSubMenu(RMenu:Get('nMenuadmin', 'main'), "Temps", " "))
RMenu.Add('nMenuadmin', 'infos', RageUI.CreateSubMenu(RMenu:Get('nMenuadmin', 'main'), "Vos Informations", " "))

local affichername = false
local ShowName = true
local gamerTags = {}
local SelectedPlayer = nil
local Freeze = false
local Spectating = false
local cinematique = false

local noclip = false
local noclip_speed = 2.0
local ServersIdSession = {}

Citizen.CreateThread(function()
    while true do
        Wait(500)
        for k,v in pairs(GetActivePlayers()) do
            local found = false
            for _,j in pairs(ServersIdSession) do
                if GetPlayerServerId(v) == j then
                    found = true
                end
            end
            if not found then
                table.insert(ServersIdSession, GetPlayerServerId(v))
            end
        end
    end
end)

function aTenue()
    local model = GetEntityModel(GetPlayerPed(-1))
    TriggerEvent('skinchanger:getSkin', function(skin)
        if model == GetHashKey("mp_m_freemode_01") then
            clothesSkin = {
                ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                ['torso_1'] = 178,   ['torso_2'] = 9,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 31,
                ['pants_1'] = 77,   ['pants_2'] = 9,
                ['shoes_1'] = 55,   ['shoes_2'] = 9,
                ['helmet_1'] = 91,  ['helmet_2'] = 9,
                ['chain_1'] = 1,    ['chain_2'] = 0,
                ['mask_1'] = -1,  ['mask_2'] = 0,
                ['ears_1'] = 2,     ['ears_2'] = 0
            }
        else
            clothesSkin = {
                ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                ['torso_1'] = 178,   ['torso_2'] = 9,
                ['decals_1'] = 0,   ['decals_2'] = 0,
                ['arms'] = 31,
                ['pants_1'] = 77,   ['pants_2'] = 9,
                ['shoes_1'] = 55,   ['shoes_2'] = 9,
                ['helmet_1'] = 91,  ['helmet_2'] = 9,
                ['chain_1'] = 1,    ['chain_2'] = 0,
                ['mask_1'] = -1,  ['mask_2'] = 0,
                ['ears_1'] = 2,     ['ears_2'] = 0
            }
        end
        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end)
end


function DrawPlayerInfo(target)
    drawTarget = target
    drawInfo = true
end

function StopDrawPlayerInfo()
    drawInfo = false
    drawTarget = 0
end

Citizen.CreateThread( function()
    while true do
        Citizen.Wait(0)
        if drawInfo then
            local text = {}
            -- cheat checks
            local targetPed = GetPlayerPed(drawTarget)

            table.insert(text,"E pour stop spectate")

            for i,theText in pairs(text) do
                SetTextFont(0)
                SetTextProportional(1)
                SetTextScale(0.0, 0.30)
                SetTextDropshadow(0, 0, 0, 0, 255)
                SetTextEdge(1, 0, 0, 0, 255)
                SetTextDropShadow()
                SetTextOutline()
                SetTextEntry("STRING")
                AddTextComponentString(theText)
                EndTextCommandDisplayText(0.3, 0.7+(i/30))
            end

            if IsControlJustPressed(0,103) then
                local targetPed = PlayerPedId()
                local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

                RequestCollisionAtCoord(targetx,targety,targetz)
                NetworkSetInSpectatorMode(false, targetPed)

                StopDrawPlayerInfo()

            end

        end
    end
end)

function SpectatePlayer(targetPed,target,name)
    local playerPed = PlayerPedId() -- yourself
    enable = true
    if targetPed == playerPed then enable = false end

    if(enable)then

        local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

        RequestCollisionAtCoord(targetx,targety,targetz)
        NetworkSetInSpectatorMode(true, targetPed)
        DrawPlayerInfo(target)
        ESX.ShowNotification('~g~Mode spectateur en cours')
    else

        local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

        RequestCollisionAtCoord(targetx,targety,targetz)
        NetworkSetInSpectatorMode(false, targetPed)
        StopDrawPlayerInfo()
        ESX.ShowNotification('~b~Mode spectateur arrêtée')
    end
end

local hasCinematic = true
function openCinematique()
	hasCinematic = not hasCinematic
    if not hasCinematic then -- montrer
        TriggerEvent("ez_cinematique:cinematique", false)
        TriggerEvent("ui:off")
        TriggerEvent('ui:refresh')
		ESX.UI.HUD.SetDisplay(0.0)
		TriggerEvent('es:setMoneyDisplay', 0.0)
		TriggerEvent('esx_status:setDisplay', 0.0)
		DisplayRadar(false)
	elseif hasCinematic then -- cacher
		ESX.UI.HUD.SetDisplay(1.0)
		TriggerEvent('es:setMoneyDisplay', 1.0)
		TriggerEvent('esx_status:setDisplay', 1.0)
		DisplayRadar(true)
        TriggerEvent("ez_cinematique:cinematique", true)
        TriggerEvent("ui:on")
        TriggerEvent('ui:refresh')
	end
end

Citizen.CreateThread(function()
    while true do
        Config.GetPlayerMoney()
        Wait(2500)
    end
end)

RegisterNetEvent("solde:argent")
AddEventHandler("solde:argent", function(money, cash)
    PlayerMoney = tonumber(money)
end)

Citizen.CreateThread(function()

	while true do
		Citizen.Wait(4000)

		TriggerEvent('esx_status:getStatus', 'hunger', function(status)
			VM.Faim = status.val/1000000*100

		end)
		TriggerEvent('esx_status:getStatus', 'thirst', function(status)
			VM.Soif = status.val/1000000*100

		end)

	end

end)

VM = {
    ItemSelected = {},
    ItemSelected2 = {},
    WeaponData = {},
    Menu = false,
    Ped = PlayerPedId(),
    bank = nil,
    sale = nil,
    Faim = 0,
    Soif= 0,
    map = true,
    billing = {},
    visual = false,
    visual2 = false,
    visual3 = false,
    visual4 = false,
    visual5 = false,
    visual6 = false,
    visual7 = false,
    visual8 = false,
    visual9 = false,
    visual10 = false,
}

function SpectatePlayer(targetPed,target,name)
    local playerPed = PlayerPedId() -- yourself
    enable = true
    if targetPed == playerPed then enable = false end

    if(enable)then

        local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

        RequestCollisionAtCoord(targetx,targety,targetz)
        NetworkSetInSpectatorMode(true, targetPed)
        DrawPlayerInfo(target)
        ESX.ShowNotification('~g~Mode spectateur en cours')
    else

        local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))

        RequestCollisionAtCoord(targetx,targety,targetz)
        NetworkSetInSpectatorMode(false, targetPed)
        StopDrawPlayerInfo()
        ESX.ShowNotification('~b~Mode spectateur arrêtée')
    end
end

function no_clip()
    noclip = not noclip
    local ped = GetPlayerPed(-1)
    if noclip then
      SetEntityInvincible(ped, true)
      SetEntityVisible(ped, false, false)
      ESX.ShowAdvancedNotification("Administration", "", "NoClip : ~g~activé", "CHAR_MP_MORS_MUTUAL", 1)
    else
      SetEntityInvincible(ped, false)
      SetEntityVisible(ped, true, false)
      ESX.ShowAdvancedNotification("Administration", "", "NoClip : ~r~désactivé", "CHAR_MP_MORS_MUTUAL", 1)
    end
  end

  function ShowMarker()
	local ply = GetPlayerPed(-1)
	local pCoords = GetEntityCoords(ply, true)
    local veh = GetTargetedVehicle(pCoords, ply)
    if veh ~= 0 and GetEntityType(veh) == 2 then
        local coords = GetEntityCoords(veh)
        local x,y,z = table.unpack(coords)
        DrawMarker(2, x, y, z+1.5, 0, 0, 0, 180.0,nil,nil, 0.5, 0.5, 0.5, 0, 0, 255, 120, true, true, p19, true)
    end
end

function GetVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

function StopDrawPlayerInfo()
    drawInfo = false
    drawTarget = 0
end

function GetTargetedVehicle(pCoords, ply)
    for i = 1, 200 do
        coordB = GetOffsetFromEntityInWorldCoords(ply, 0.0, (6.281)/i, 0.0)
        targetedVehicle = GetVehicleInDirection(pCoords, coordB)
        if(targetedVehicle ~= nil and targetedVehicle ~= 0)then
            return targetedVehicle
        end
    end
    return
end

   function Keyboardput(TextEntry, ExampleText, MaxStringLength)

	AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

  function getPosition()
    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
    return x,y,z
  end

  function getCamDirection()
    local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(GetPlayerPed(-1))
    local pitch = GetGameplayCamRelativePitch()

    local x = -math.sin(heading*math.pi/180.0)
    local y = math.cos(heading*math.pi/180.0)
    local z = math.sin(pitch*math.pi/180.0)

    local len = math.sqrt(x*x+y*y+z*z)
    if len ~= 0 then
      x = x/len
      y = y/len
      z = z/len
    end

    return x,y,z
  end

  function isNoclip()
    return noclip
  end

  function KeyboardInput(TextEntry, ExampleText, MaxStringLength)

    AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

function Notify(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	DrawNotification(false, true)
end

RegisterNetEvent("admin:Freeze")
AddEventHandler("admin:Freeze",function()

    FreezeEntityPosition(GetPlayerPed(-1), not Freeze)
    Freeze = not Freeze
end)

function admin_tp_marker()

    local playerPed = GetPlayerPed(-1)
    local WaypointHandle = GetFirstBlipInfoId(8)
    if DoesBlipExist(WaypointHandle) then
        local coord = Citizen.InvokeNative(0xFA7C7F0AADF25D09, WaypointHandle, Citizen.ResultAsVector())
        SetEntityCoordsNoOffset(playerPed, coord.x, coord.y, -199.5, false, false, false, true)
  ESX.ShowAdvancedNotification("Administration", "", "TP sur Marqueur : ~g~Réussi !", "CHAR_MP_MORS_MUTUAL", 1)
    else
  ESX.ShowAdvancedNotification("Administration", "", "~r~Aucun Marqueur !", "CHAR_MP_MORS_MUTUAL", 1)
    end
end

  function GiveCash()
    local amount = KeyboardInput("Somme", "", 8)

    if amount ~= nil then
        amount = tonumber(amount)

        if type(amount) == 'number' then
            TriggerServerEvent('Administration:GiveCash', amount)
        end
    end
end

function GiveBanque()
    local amount = KeyboardInput("Somme", "", 8)

    if amount ~= nil then
        amount = tonumber(amount)

        if type(amount) == 'number' then
            TriggerServerEvent('Administration:GiveBanque', amount)
        end
    end
end

function GiveND()
    local amount = KeyboardInput("Somme", "", 8)

    if amount ~= nil then
        amount = tonumber(amount)

        if type(amount) == 'number' then
            TriggerServerEvent('Administration:GiveND', amount)
        end
    end
end

function changer_skin()
    TriggerEvent('esx_skin:openSaveableMenu', source)
end

function admin_mode_fantome()
    invisible = not invisible
    local ped = GetPlayerPed(-1)

    if invisible then
          SetEntityVisible(ped, false, false)
          ESX.ShowAdvancedNotification("Administration", "", "Invisibilité : ~g~activé", "CHAR_MP_MORS_MUTUAL", 1)
      else
          SetEntityVisible(ped, true, false)
          ESX.ShowAdvancedNotification("Administration", "", "Invisibilité : ~r~désactivé", "CHAR_MP_MORS_MUTUAL", 1)
    end
  end

  function admin_vehicle_flip()

    local player = GetPlayerPed(-1)
    posdepmenu = GetEntityCoords(player)
    carTargetDep = GetClosestVehicle(posdepmenu['x'], posdepmenu['y'], posdepmenu['z'], 10.0,0,70)
    if carTargetDep ~= nil then
            platecarTargetDep = GetVehicleNumberPlateText(carTargetDep)
    end
    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
    playerCoords = playerCoords + vector3(0, 2, 0)

    SetEntityCoords(carTargetDep, playerCoords)

    ESX.ShowAdvancedNotification("Administration", "", "~g~Véhicule retourné", "CHAR_MP_MORS_MUTUAL", 1)

end

function admin_godmode()
    godmode = not godmode
    local ped = GetPlayerPed(-1)

    if godmode then -- activé
          SetEntityInvincible(ped, true)
    ESX.ShowAdvancedNotification("Administration", "", "Invincibilité : ~g~activé", "CHAR_MP_MORS_MUTUAL", 1)
      else
          SetEntityInvincible(ped, false)
    ESX.ShowAdvancedNotification("Administration", "", "Invincibilité : ~r~désactivé", "CHAR_MP_MORS_MUTUAL", 1)
    end
  end
  local invincible = false

  function admin_tp_toplayer()
	local plyId = KeyboardInput("ID", "", "", 8)

	if plyId ~= nil then
		plyId = tonumber(plyId)

		if type(plyId) == 'number' then
			local targetPlyCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(plyId)))
			SetEntityCoords(plyPed, targetPlyCoords)
		end
	end
end

function admin_tp_playertome()
	local plyId = KeyboardInput("ID :", "", "", 8)

	if plyId ~= nil then
		plyId = tonumber(plyId)

		if type(plyId) == 'number' then
			local plyPedCoords = GetEntityCoords(plyPed)
			print(plyId)
			TriggerServerEvent('KorioZ-PersonalMenu:Admin_BringS', plyId, plyPedCoords)
		end
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if service then



            if ShowName then
                local pCoords = GetEntityCoords(GetPlayerPed(-1), false)
                for _, v in pairs(GetActivePlayers()) do
                    local otherPed = GetPlayerPed(v)

                    if otherPed ~= pPed then
                        if #(pCoords - GetEntityCoords(otherPed, false)) < 250.0 then
                            gamerTags[v] = CreateFakeMpGamerTag(otherPed, ('[%s] %s'):format(GetPlayerServerId(v), GetPlayerName(v)), false, false, '', 0)
                            SetMpGamerTagVisibility(gamerTags[v], 4, 1)
                        else
                            RemoveMpGamerTag(gamerTags[v])
                            gamerTags[v] = nil
                        end
                    end
                end
            else
                for _, v in pairs(GetActivePlayers()) do
                    RemoveMpGamerTag(gamerTags[v])
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if service then

            if ShowName then
                local pCoords = GetEntityCoords(GetPlayerPed(-1), false)
                for _, v in pairs(GetActivePlayers()) do
                    local otherPed = GetPlayerPed(v)

                    if otherPed ~= pPed then
                        if #(pCoords - GetEntityCoords(otherPed, false)) < 250.0 then
                            gamerTags[v] = CreateFakeMpGamerTag(otherPed, ('[%s] %s'):format(GetPlayerServerId(v), GetPlayerName(v)), false, false, '', 0)
                            SetMpGamerTagVisibility(gamerTags[v], 4, 1)
                        else
                            RemoveMpGamerTag(gamerTags[v])
                            gamerTags[v] = nil
                        end
                    end
                end
            else
                for _, v in pairs(GetActivePlayers()) do
                    RemoveMpGamerTag(gamerTags[v])
                end
            end

            for k,v in pairs(GetActivePlayers()) do
                if NetworkIsPlayerTalking(v) then
                    local pPed = GetPlayerPed(v)
                    local pCoords = GetEntityCoords(pPed)
                    DrawMarker(32, pCoords.x, pCoords.y, pCoords.z+1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 0, 1, 2, 0, nil, nil, 0)
                end
            end
        end
    end
end)

  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if noclip then
        local ped = GetPlayerPed(-1)
        local x,y,z = getPosition()
        local dx,dy,dz = getCamDirection()
        local speed = noclip_speed

        SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)

        if IsControlPressed(0,32) then
          x = x+speed*dx
          y = y+speed*dy
          z = z+speed*dz
        end


        if IsControlPressed(0,269) then
          x = x-speed*dx
          y = y-speed*dy
          z = z-speed*dz
        end

        SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
      end
    end
  end)

Citizen.CreateThread(function()
    while true do

                   RageUI.IsVisible(RMenu:Get('nMenuadmin', 'main'), true, true, true, function()
                    RageUI.Checkbox("Mode Modération",nil, service,{},function(Hovered,Ative,Selected,Checked)
                        if (Selected) then

                            service = Checked


                            if Checked then
                                onservice = true
                                local head = RegisterPedheadshot(PlayerPedId())
                                while not IsPedheadshotReady(head) or not IsPedheadshotValid(head) do
                                    Wait(1)
                                end
                                headshot = GetPedheadshotTxdString(head)

                            else
                                onservice = false
                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                TriggerEvent('skinchanger:loadSkin', skin)
                                end)
                            end
                        end
                    end)

                    if onservice then



players = {}
for _, player in ipairs(GetActivePlayers()) do
    local ped = GetPlayerPed(player)
    table.insert( players, player )
end
RageUI.Separator("")
RageUI.Separator("Joueur(s) en ligne  →  ~g~"..#players.."~s~/512")
RageUI.Separator("")
                        RageUI.ButtonWithStyle("Menu Administration", nil, {RightLabel = "→→"},true, function()
                        end, RMenu:Get('nMenuadmin', 'main7'))

                        RageUI.ButtonWithStyle("Menu Véhicule", nil, {RightLabel = "→→"},true, function()
                        end, RMenu:Get('nMenuadmin', 'main4'))

                        RageUI.ButtonWithStyle("Menu Santions", nil, {RightLabel = "→→"},true, function()
                        end, RMenu:Get('nMenuadmin', 'staff'))





                    end


    end, function()
	end)

RageUI.IsVisible(RMenu:Get('menu', 'gestion'), true, true, true, function()
    for k,v in ipairs(ServersIdSession) do
        if GetPlayerName(GetPlayerFromServerId(v)) == "**Invalid**" then table.remove(ServersIdSession, k) end
        RageUI.ButtonWithStyle(v.." - " ..GetPlayerName(GetPlayerFromServerId(v)), nil, {}, true, function(Hovered, Active, Selected)
            if (Selected) then
                IdSelected = v
            end
        end, RMenu:Get('menu', 'options'))
    end
end, function()
end)

RageUI.IsVisible(RMenu:Get('menu', 'options'), true, true, true, function()

    RageUI.Separator("~s~↓   ~o~Menu Administration   ~s~↓")
    if superadmin then
        RageUI.ButtonWithStyle("→~s~ ~p~Setjob le Joueur ", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
            if (Selected) then
                local job = KeyboardInput("Job ", "", 10)
                local grade = KeyboardInput("Grade ", "", 10)
                if job and grade then
                    ExecuteCommand("setjob "..IdSelected.. " " ..job.. " " ..grade)
                    ESX.ShowNotification("Vous avez setjob : ~g~"..job.. " " .. grade .. " ~b~" .. GetPlayerName(GetPlayerFromServerId(IdSelected)))
                else
                    ESX.ShowNotification("~r~Champ invalide, veuillez réessayer.")
                    RageUI.CloseAll()
                end
            end
        end)
    end

    RageUI.Checkbox("→~s~Freeze / Defreeze", description, Frigo,{},function(Hovered,Ative,Selected,Checked)
        if Selected then
            Frigo = Checked
            if Checked then
                ESX.ShowNotification("~r~Joueur Freeze ("..GetPlayerName(GetPlayerFromServerId(IdSelected))..")")
                ExecuteCommand("freeze "..IdSelected)
            else
                ESX.ShowNotification("~g~Joueur Defreeze ("..GetPlayerName(GetPlayerFromServerId(IdSelected))..")")
                ExecuteCommand("freeze "..IdSelected)
            end
        end
    end)

    RageUI.ButtonWithStyle("→~s~ ~o~Se téléporter au Joueur", nil, {}, true, function(Hovered, Active, Selected)
        if (Selected) then
            SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(IdSelected))))
            ESX.ShowAdvancedNotification("Administration", "", '~b~Vous venez de vous téléporter à~s~ '.. GetPlayerName(GetPlayerFromServerId(IdSelected)) ..'', "CHAR_MP_MORS_MUTUAL", 1)

        end
    end)
    RageUI.ButtonWithStyle("→~s~ ~o~Téléporter le Joueur à vous", nil, {}, true, function(Hovered, Active, Selected, target)
        if (Selected) then
            ExecuteCommand("bring "..IdSelected)
            ESX.ShowAdvancedNotification("Administration", "", '~b~Vous venez de téléporter ~s~ '.. GetPlayerName(GetPlayerFromServerId(IdSelected)) ..' ~b~à vous~s~ !', "CHAR_MP_MORS_MUTUAL", 1)
        end
    end)

    RageUI.ButtonWithStyle("→~s~ Regarder le joueur", nil, {}, true, function(Hovered, Active, Selected)
        if (Selected) then
        local playerId = GetPlayerFromServerId(IdSelected)
            SpectatePlayer(GetPlayerPed(playerId),playerId,GetPlayerName(playerId))
        end
    end)

    RageUI.ButtonWithStyle("→~s~ ~g~Heal le Joueur", "", {RightLabel = nilt}, true, function(Hovered, Active, Selected)
        if (Selected) then
            ExecuteCommand("heal "..IdSelected)
            ESX.ShowAdvancedNotification("Administration", "", '~g~Heal de '.. GetPlayerName(GetPlayerFromServerId(IdSelected)) ..' ~g~effectué~s~ !', "CHAR_MP_MORS_MUTUAL", 1)
        end
    end)

    RageUI.ButtonWithStyle("→~s~ ~g~Revive le Joueur",description, {RightLabel = nil}, true, function(Hovered, Active, Selected)
        if (Selected) then
            Frigo3 = Checked
            if Checked then
                ExecuteCommand("revive "..IdSelected)
                ESX.ShowNotification("~b~Vous venez de revive l'ID : ~s~" ..IdSelected)
            else
                ExecuteCommand("revive "..IdSelected)
                ESX.ShowNotification("~b~Vous venez de revive l'ID : ~s~" ..IdSelected)
            end
        end
    end)

    RageUI.Separator("↓   ~r~Wipes et Gives   ~s~↓")

    if superadmin then
        RageUI.ButtonWithStyle("→~s~ ~r~Wipe l'inventaire du Joueur", "", {RightLabel = nil}, true, function(Hovered, Active, Selected)
            if (Selected) then
                ExecuteCommand("clearinventory "..IdSelected)
            ESX.ShowAdvancedNotification("Administration", "", "Vous venez de WIPE les items de ~b~".. GetPlayerName(GetPlayerFromServerId(IdSelected)) .."~s~ !", "CHAR_MP_MORS_MUTUAL", 1)
            end
        end)
    end
    if superadmin then
        RageUI.ButtonWithStyle("→~s~ ~r~Wipe les Armes du Joueur", "", {RightLabel = nil}, true, function(Hovered, Active, Selected)
            if (Selected) then
                ExecuteCommand("clearloadout "..IdSelected)
            ESX.ShowAdvancedNotification("Administration", "", "Vous venez de WIPE les armes de ~b~".. GetPlayerName(GetPlayerFromServerId(IdSelected)) .."~s~ !", "CHAR_MP_MORS_MUTUAL", 1)
            end
        end)
    end
    RageUI.ButtonWithStyle("→~s~ ~o~Donner un Item au Joueur", "", {RightLabel = nil}, true, function(Hovered, Active, Selected)
        if (Selected) then
            local item = KeyboardInput("Item", "", 10)
            local amount = KeyboardInput("Nombre", "", 10)
            if item and amount then
                ExecuteCommand("giveitem "..IdSelected.. " " ..item.. " " ..amount)
                ESX.ShowNotification("Vous venez de donner ~g~"..amount.. " " .. item .. " ~w~à " .. GetPlayerName(GetPlayerFromServerId(IdSelected)))
            else
                    ESX.ShowNotification("~r~Champ incorrect !")
                RageUI.CloseAll()
            end
        end
    end)
    if superadmin then
        RageUI.ButtonWithStyle("→~s~ ~r~Donner une Arme au Joueur", "", {RightLabel = nil}, true, function(Hovered, Active, Selected)
            if (Selected) then
                local weapon = KeyboardInput("Nom de l'Arme", "weapon_", 100)
                local ammo = KeyboardInput("Munitions", "", 100)
                if weapon and ammo then
                    ExecuteCommand("giveweapon "..IdSelected.. " " ..weapon.. " " ..ammo)
                    ESX.ShowNotification("Vous venez de donner ~g~"..weapon.. " avec " .. ammo .. " munitions ~w~à " .. GetPlayerName(GetPlayerFromServerId(IdSelected)))
                else
                    ESX.ShowNotification("~r~Champ incorrect !")
                    RageUI.CloseAll()
                end
            end
        end)
    end


end, function()
end)

RageUI.IsVisible(RMenu:Get('nMenuadmin', 'staff'), true, true, true, function()

    RageUI.Separator("↓   ~o~Menu Sanctions   ~s~↓")
    if superadmin then

        RageUI.ButtonWithStyle("→~s~ Kick un joueur (ID)", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
            if (Selected) then
                local id = KeyboardInput("Id du joueur à kick ", "", 4)
                local raison = KeyboardInput("Raison du kick ", "", 120)
                ExecuteCommand("kick "..id.." "..raison.." ")

            end
        end)

        RageUI.ButtonWithStyle("→~s~ Bannir un joueur (ID)", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
            if (Selected) then
                local id = KeyboardInput("Id du joueur à ban ", "", 4)
                local time = KeyboardInput("Temps à ban (en jours) ", "", 4)
                local raison = KeyboardInput("Raison du ban ", "", 120)
                ExecuteCommand("sqlban "..id.." "..time.." "..raison.." ")

            end
        end)

        RageUI.ButtonWithStyle("→~s~ Débannir un joueur (Steam)", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
            if (Selected) then
                local steam = KeyboardInput("Steam du joueurs à déban ", "", 30)

                ExecuteCommand("sqlunban "..steam.." ")

            end
        end)

    end

end, function()
end)

RageUI.IsVisible(RMenu:Get('nMenuadmin', 'main6'), true, true, true, function()

    RageUI.ButtonWithStyle("→~s~ Utiliser le NoClip", "Activer/Désactiver le NoClip", {RightLabel = "F9"},true, function()
    end, RMenu:Get('menu', 'gestion'))

    RageUI.ButtonWithStyle("→~s~ Supprimer un véhicule", "Supprimer le véhicule dans lequel vous êtes.", {RightLabel = "F11"},true, function()
    end, RMenu:Get('menu', 'gestion'))

    RageUI.ButtonWithStyle("→~s~ Se téléporter sur le Marqueur", "Se téléporter sur le marqueur (sur la minimap)", {RightLabel = "ALT"},true, function()
    end, RMenu:Get('menu', 'gestion'))

    RageUI.ButtonWithStyle("→~s~ Être BG", "Tuto être BG", {RightLabel = "Être BG"},true, function()
    end, RMenu:Get('menu', 'gestion'))

end, function()
end)

RageUI.IsVisible(RMenu:Get('nMenuadmin', 'main7'), true, true, true, function()
    RageUI.Separator("~s~↓    ~o~Menu Modération   ~s~↓")

    RageUI.ButtonWithStyle("→~s~ Gestion des Joueurs", "Gérer les joueurs connectés sur le serveur.", {RightLabel = ""},true, function()
    end, RMenu:Get('menu', 'gestion'))

    RageUI.Checkbox("→~s~ Afficher les Noms (Pas en RP)", description, affichername,{},function(Hovered,Ative,Selected,Checked)
        if Selected then
            affichername = Checked
            if Checked then
                ShowName = true
                ESX.ShowNotification("Les noms sont ~g~affichés")
            else
                ShowName = false
                ESX.ShowNotification("Les noms ne sont plus ~r~affichés")
            end
        end
    end)

    RageUI.Checkbox("→~s~ Activer son Invincibilité","Devenir invincible.", checkbox2,{},function(Hovered,Active,Selected,Checked)
        if Selected then
            checkbox2 = Checked
            if Checked then
                Checked = true
                admin_godmode()
            else
                admin_godmode()
            end
        end
    end)

    RageUI.Checkbox("→~s~ Activer son Invisibilité","Devenir invisible.", checkbox3,{},function(Hovered,Active,Selected,Checked)
        if Selected then
            checkbox3 = Checked
            if Checked then
                Checked = true
                admin_mode_fantome()
            else
                admin_mode_fantome()
            end
        end
    end)

    RageUI.ButtonWithStyle("→~s~ Se donner de l'Armure",description, {RightBadge = RageUI.BadgeStyle.Armour}, true, function(Hovered, Active, Selected)
        if (Selected) then
            SetPedArmour(GetPlayerPed(-1), 200)
            Notify("Armure ~g~renouvelé ~s~!")
        end
    end)

    RageUI.ButtonWithStyle("→~s~ Se Soigner",description, {RightBadge = RageUI.BadgeStyle.Heart}, true, function(Hovered, Active, Selected)
        if (Selected) then
            SetEntityHealth(GetPlayerPed(-1), 200)
            Notify("Heal ~g~effectué ~s~!")
        end
    end)


                RageUI.ButtonWithStyle("→~s~ TP sur le Marqueur", "Se téléporter sur son marqueur.", {RightBadge = RageUI.BadgeStyle.Tick}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        admin_tp_marker()
                    end
                            end)
                        


end, function()
end)


                                        RageUI.IsVisible(RMenu:Get('nMenuadmin', 'main4'), true, true, true, function()

                                            RageUI.Separator("↓   ~g~Actions sur véhicules   ↓")


                                            RageUI.ButtonWithStyle("→~s~ Réparer le Véhicule", "Réparer le véhicule dans lequel vous êtes.", {RightBadge = RageUI.BadgeStyle.Car}, true, function(Hovered, Active, Selected)
                                                if Selected then
                                                            if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
                                                            vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                                                            if DoesEntityExist(vehicle) then
                                                            SetVehicleFixed(vehicle)
                                                            SetVehicleDeformationFixed(vehicle)
                                                         end
                                                      end
                                                   end
                                               end)

                                               RageUI.ButtonWithStyle("→~s~ Retourner le Véhicule", "Retourner le véhicule dans lequel vous êtes.", {RightBadge = RageUI.BadgeStyle.Car}, true, function(Hovered, Active, Selected)
                                                if (Selected) then
                                                    admin_vehicle_flip()
                                                end
                                            end)
                                            RageUI.ButtonWithStyle("→~s~ Spawn un Véhicule", "Faire apparaitre un véhicule.", {RightBadge = RageUI.BadgeStyle.Car}, true, function(_, _, Selected)
                                                if Selected then
                                                   local ped = GetPlayerPed(tgt)
                                                   local ModelName = KeyboardInput("Véhicule", "", 100)
                                                 if ModelName and IsModelValid(ModelName) and IsModelAVehicle(ModelName) then
                                                   RequestModel(ModelName)
                                                   while not HasModelLoaded(ModelName) do
                                                   Citizen.Wait(0)
                                                end
                                                local veh = CreateVehicle(GetHashKey(ModelName), GetEntityCoords(GetPlayerPed(-1)), GetEntityHeading(GetPlayerPed(-1)), true, true)
                                                    TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
                                                    Wait(50)
                                                else
                                                ESX.ShowNotification("~r~Vehicule invalide !")
                                                end
                                            end
                                        end)

                                        RageUI.ButtonWithStyle("→~s~ Supprimer le Véhicule", "Supprimer le véhicule dans lequel vous êtes.", {RightBadge = RageUI.BadgeStyle.Car}, true, function(_, Active, Selected)
                                            if Active then
                                                ShowMarker()
                                            end
                                            if Selected then
                                                TriggerEvent("esx:deleteVehicle")
                                            end
                                            end)


                                        RageUI.ButtonWithStyle("→~s~ Changer la Plaque", "Changer la plaque du véhicule dans lequel vous êtes.", {RightBadge = RageUI.BadgeStyle.Car}, true, function(_, Active, Selected)
                                            if Selected then
                                                if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
                                                    local plaqueVehicule = Keyboardput("Plaque", "", 8)
                                                    SetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false) , plaqueVehicule)
                                                    ESX.ShowNotification("Plaque changée en : ~g~"..plaqueVehicule)
                                                else
                                                    ESX.ShowNotification("~r~Erreur\n~s~Vous n'êtes pas dans un véhicule !")
                                                end
                                            end
                                            end)

                                            RageUI.ButtonWithStyle("→~s~ Changer la couleur", "Changer la couleur du véhicule dans lequel vous êtes.", {RightBadge = RageUI.BadgeStyle.Car}, true, function(Hovered, Active, Selected)
                                                if (Selected) then
                                                    local r, g, b = math.random(255), math.random(255), math.random(255)
                                                    local ped = PlayerPedId()
                                                    local vehicle = GetVehiclePedIsIn( ped, false )
                                                    SetVehicleColours(vehicle, r, g, b)
                                              end
                                            end)



                                        end, function()
                                        end)

                        Citizen.Wait(0)
                        end
                        end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1,57) then
                ESX.TriggerServerCallback('inspecteur:getUsergroup', function(group)
                    playergroup = group
                    if playergroup == 'superadmin' then
                        superadmin = true
                    RageUI.Visible(RMenu:Get('nMenuadmin', 'main'), not RageUI.Visible(RMenu:Get('menu', 'main')))
                    else
                        superadmin = false
                    end
                end)
            end
        end
    end)

        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
                if IsControlJustPressed(1,19) then
                        ESX.TriggerServerCallback('inspecteur:getUsergroup', function(group)
                            playergroup = group
                            if playergroup == 'superadmin' then
                                superadmin = true
                                        admin_tp_marker()
                            else
                                superadmin = false
                            end
                        end)
                    end
                end
            end)

            Citizen.CreateThread(function()
                while true do
                    Citizen.Wait(0)
                    if IsControlJustPressed(1,56) then
                            ESX.TriggerServerCallback('inspecteur:getUsergroup', function(group)
                                playergroup = group
                                if playergroup == 'superadmin' then
                                    superadmin = true
                                    no_clip()

                                else
                                    superadmin = false
                                end
                            end)
                        end
                    end
                end)

                Citizen.CreateThread(function()
                    while true do
                        Citizen.Wait(0)
                        if IsControlJustPressed(1,344) then
                                ESX.TriggerServerCallback('inspecteur:getUsergroup', function(group)
                                    playergroup = group
                                    if playergroup == 'superadmin' then
                                        superadmin = true
                                        TriggerEvent("esx:deleteVehicle")
                                    else
                                        superadmin = false
                                    end
                                end)
                            end
                        end
                    end)

                    Citizen.CreateThread(function()
                        while true do
                           Citizen.Wait(400)
                           if CouleurRandom == "~r~" then CouleurRandom = "~s~" else CouleurRandom = "~r~" end
                       end
                    end)
