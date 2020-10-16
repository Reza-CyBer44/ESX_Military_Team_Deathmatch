local firstSpawn = true
local isDead = false

 local PlayerData              = {}
 ESX                           = nil
local deadPlayers = {}
local blipRUSSIA = {}
local blipUSA = {}
local idRUSSIA = {}
local idUSA = {}
local isRadarOn = false
local RadarAngle = 0
local radarblips = {}
local crouched = false
local proned = false
local medkit = 0
Citizen.CreateThread(function()
	  while ESX == nil do
		  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		  Citizen.Wait(0)
	  end
  
	  while ESX.GetPlayerData().job == nil do
		  Citizen.Wait(10)
	  end
  
	  PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	  while ESX == nil do
		  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		  Citizen.Wait(0)
	  end
  
	  while ESX.GetPlayerData().job == nil do
		  Citizen.Wait(10)
	  end
  
	  PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
PlayerData = playerData
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	TriggerEvent('updateBlip')
end)
-- Prevent Stucking


RegisterNetEvent('playerSpawned')
AddEventHandler('playerSpawned', function()

   SetPedDropsWeaponsWhenDead(PlayerPedId(),false)
   while PlayerData.job == nil do
   Citizen.Wait(1)
   end
   while Config.USABASE == nil or Config.RUSSIABASE == nil do
   Citizen.Wait(10)
   end
   	StopScreenEffect('DeathFailOut')
  AddRelationshipGroup('russia')
  AddRelationshipGroup('usa')

  SetRelationshipBetweenGroups(5, 'usa', 'russia')
  SetRelationshipBetweenGroups(5, 'russia', 'usa')
	isDead = false
 --   print('spawned')
	if firstSpawn == true then
	    TriggerServerEvent('Cyber:SetJob','unemployed')
	    while PlayerData.job.name ~= 'unemployed' do 
	    Citizen.Wait(1)
	    end
	   -- print('setautospawnfalse')
		exports.spawnmanager:setAutoSpawn(false) -- disable respawn
		firstSpawn = false
		CheckTheTeam()
	end
	if PlayerData.job.name == 'russia' then
    while Config.RUSSIABASE.respawn == nil do
    Citizen.Wait(10)
    end
	FreezeEntityPosition(PlayerPedId(),true)
	SetPlayerInvincible(PlayerPedId(),true)
    ESX.Game.Teleport(PlayerPedId(), Config.RUSSIABASE.respawn, function()
     
    end)
    while not HasCollisionLoadedAroundEntity(PlayerPedId()) do 
	Citizen.Wait(10)
	end
	Citizen.Wait(5000)
	FreezeEntityPosition(PlayerPedId(),false)
	SetPlayerInvincible(PlayerPedId(),false)
    elseif PlayerData.job.name == 'usa' then
   
    while Config.USABASE.respawn == nil do
    Citizen.Wait(10)
    end
	FreezeEntityPosition(PlayerPedId(),true)
	SetPlayerInvincible(PlayerPedId(),true)
    ESX.Game.Teleport(PlayerPedId(), Config.USABASE.respawn, function()
     
    end)
    while not HasCollisionLoadedAroundEntity(PlayerPedId()) do 
	Citizen.Wait(10)
	end
	Citizen.Wait(5000)
	SetPlayerInvincible(PlayerPedId(),false)
	FreezeEntityPosition(PlayerPedId(),false)
   
    end 	
   
end)
-- FORCE PED
Citizen.CreateThread(function()
  while Config.USABASE == nil or Config.RUSSIABASE == nil do
   Citizen.Wait(10)
   end
  while PlayerData.job == nil do 
  Citizen.Wait(10)
  end
  while PlayerData.job.name == 'unemployed' do 
  Citizen.Wait(1000)
  end
  while true do
  Citizen.Wait(Config.AntiOtherPedTimer)
  if PlayerData.job.name == 'usa' then
  
  if GetEntityModel(PlayerPedId()) ~= GetHashKey(Config.USABASE.PED) and PlayerData.job.grade < 7 then
  RequestModel(GetHashKey(Config.USABASE.PED))
  while not HasModelLoaded(GetHashKey(Config.USABASE.PED)) do
   
  Citizen.Wait(100)
   
  end
  SetPlayerModel(PlayerId(),GetHashKey(Config.USABASE.PED))
  
  elseif GetEntityModel(PlayerPedId()) ~= GetHashKey(Config.USABASE.PEDCommander) and PlayerData.job.grade > 6 then
  
  RequestModel(GetHashKey(Config.USABASE.PEDCommander))
  while not HasModelLoaded(GetHashKey(Config.USABASE.PEDCommander)) do
   
  Citizen.Wait(100)
   
  end
  SetPlayerModel(PlayerId(),GetHashKey(Config.USABASE.PEDCommander))
  
  end
  elseif PlayerData.job.name == 'russia' then
   if GetEntityModel(PlayerPedId()) ~= GetHashKey(Config.RUSSIABASE.PED) and PlayerData.job.grade < 7 then
   RequestModel(GetHashKey(Config.RUSSIABASE.PED))
   while not HasModelLoaded(GetHashKey(Config.RUSSIABASE.PED)) do
   
  Citizen.Wait(100)
   
   end
   SetPlayerModel(PlayerId(),GetHashKey(Config.RUSSIABASE.PED))
   
  elseif GetEntityModel(PlayerPedId()) ~= GetHashKey(Config.RUSSIABASE.PEDCommander) and PlayerData.job.grade > 6 then  
   
  RequestModel(GetHashKey(Config.RUSSIABASE.PEDCommander))
  while not HasModelLoaded(GetHashKey(Config.RUSSIABASE.PEDCommander)) do
   
  Citizen.Wait(100)
   
  end
  SetPlayerModel(PlayerId(),GetHashKey(Config.RUSSIABASE.PEDCommander)) 
  end
  end

  end

end)


function CheckTheTeam()
   local response = false
   while Config.USABASE == nil or Config.RUSSIABASE == nil do
   Citizen.Wait(10)
   end
    while PlayerData.job == nil do
	  Citizen.Wait(10)
	end

   if PlayerData.job.name == 'usa' then
    FreezeEntityPosition(PlayerPedId(),true)
	SetPlayerInvincible(PlayerPedId(),true)
    ESX.Game.Teleport(PlayerPedId(), Config.USABASE.respawn, function()
    SetPedRelationshipGroupHash(PlayerPedId(), 'usa')
	SetEntityCanBeDamagedByRelationshipGroup(PlayerPedId(),false,'usa')
    end)
    while not HasCollisionLoadedAroundEntity(PlayerPedId()) do 
	Citizen.Wait(10)
	end
	Citizen.Wait(5000)
    FreezeEntityPosition(PlayerPedId(),false)
	SetPlayerInvincible(PlayerPedId(),false)
   elseif PlayerData.job.name == 'russia' then
    FreezeEntityPosition(PlayerPedId(),true)
	SetPlayerInvincible(PlayerPedId(),true)
    ESX.Game.Teleport(PlayerPedId(), Config.RUSSIABASE.respawn, function()
     SetPedRelationshipGroupHash(PlayerPedId(), 'russia')
	 SetEntityCanBeDamagedByRelationshipGroup(PlayerPedId(),false,'russia')
    end)
    while not HasCollisionLoadedAroundEntity(PlayerPedId()) do 
	Citizen.Wait(10)
	end
	Citizen.Wait(5000)
    FreezeEntityPosition(PlayerPedId(),false)
    SetPlayerInvincible(PlayerPedId(),false)
   else
  
   SeeWhatPlayerWants()
   
   end
  CheckTheCurrentGame()
end
-- Command Part
RegisterCommand('die', function(source,args)

  SetEntityHealth(PlayerPedId(), 0)
end,false)

TriggerEvent('chat:addSuggestion', '/die', 'Suicide', {})

RegisterCommand('RequestAirSupport', function(source,args)

TriggerServerEvent('Cyber:RequestAirSupport')

end,false)

TriggerEvent('chat:addSuggestion', 'RequestAirSupport', 'Request Air Support', {})


RegisterCommand('RequestSupplySupport', function(source,args)

TriggerServerEvent('Cyber:RequestSupplySupport')

end,false)

TriggerEvent('chat:addSuggestion', 'RequestSupplySupport', 'Request Supply Support', {})

RegisterCommand('RequestGroundSupport', function(source,args)

TriggerServerEvent('Cyber:RequestGroundSupport')

end,false)

TriggerEvent('chat:addSuggestion', 'RequestGroundSupport', 'Request Ground Support', {})

RegisterCommand('RequestTransport', function(source,args)

TriggerServerEvent('Cyber:RequestTransport')

end,false)

TriggerEvent('chat:addSuggestion', 'RequestTransport', 'Request Transport', {})

RegisterCommand('startengage', function(source,args)

TriggerServerEvent('Cyber:EngagingTheEnemy')

end,false)

TriggerEvent('chat:addSuggestion', 'startengage', 'Engaging The Enemy', {})


RegisterCommand('delete', function(source,args)
     
	 local dist1 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Config.USABASE.divisionmark)
	 local dist2 = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Config.RUSSIABASE.divisionmark)
	 
	 if dist1 < 2000 or dist2 < 2000 then
	 
	 if IsPedInAnyVehicle(PlayerPedId(),false) then
	 
	  local int = GetVehiclePedIsIn(PlayerPedId(),false)
	  DeleteEntity(int)
	 
	 end
	 
	 end
	 
end,false)

TriggerEvent('chat:addSuggestion', '/delete', 'Delete Your Current Vehicle', {})
AddEventHandler('esx:onPlayerDeath', function(data)
   
	isDead = true
	OnPlayerDeath()
	
end)

function OnPlayerDeath()
   PlaySoundFrontend(-1,  "CHECKPOINT_NORMAL", "HUD_MINI_GAME_SOUNDSET", false)
   StartDeathScreen()

end

function StartDeathScreen()
 timeHeld = 0
  TriggerServerEvent('Cyber:DIED')
  while isDead do 
  SetPlayerInvincible(PlayerPedId(),true)
  StartScreenEffect('DeathFailOut',0,true)
  DisableAllControlActions(0)
  DrawGenericTextThisFrame()
  SetTextEntry("STRING")
  EnableControlAction(0,178,true)
  AddTextComponentString('Hold [~b~DELETE~s~] To Respawn Again ')
  DrawText(0.5, 0.8)
  if IsControlPressed(0,178) and timeHeld > 60 then
   
   RespawnFromBase()
   break
  end
  if IsControlPressed(0, 178) then
				timeHeld = timeHeld + 1
  else
				timeHeld = 0
  end
  
  Citizen.Wait(0)
 end
end

function RespawnFromBase()
  
        Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end
		 TriggerServerEvent('Cyber:REVIVED')
		if PlayerData.job.name == 'russia' then
		TriggerServerEvent('Cyber:SetJob','russia')
        RespawnPed(PlayerPedId(), Config.RUSSIABASE.spawn, 0)
		SetPedRelationshipGroupHash(PlayerPedId(), 'russia')
		SetEntityCanBeDamagedByRelationshipGroup(PlayerPedId(),false,'russia')
        elseif PlayerData.job.name == 'usa' then
		TriggerServerEvent('Cyber:SetJob','usa')
		RespawnPed(PlayerPedId(), Config.USABASE.spawn, 0)
		SetPedRelationshipGroupHash(PlayerPedId(), 'usa')
		SetEntityCanBeDamagedByRelationshipGroup(PlayerPedId(),false,'usa')
		else
		SeeWhatPlayerWants()
		end
		StopScreenEffect('DeathFailOut')
	    DoScreenFadeIn(800)

  end)
end


function RespawnPed(ped, coords, heading)
    SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	FreezeEntityPosition(PlayerPedId(),true)
	Citizen.Wait(5000)
	FreezeEntityPosition(PlayerPedId(),false)
	ClearPedBloodDamage(ped)
end

function DrawGenericTextThisFrame()
	SetTextFont(4)
	SetTextScale(0.0, 0.8)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end

function SeeWhatPlayerWants()
    local response = nil
	while Config.USABASE == nil or Config.RUSSIABASE == nil do
   Citizen.Wait(10)
   end
    Citizen.CreateThread(function()
	while response == nil do
	        DisableAllControlActions(1)
			FreezeEntityPosition(PlayerPedId(), true)
			SetPlayerInvincible(PlayerPedId(), true)
			EnableControlAction(1,45,true)
			EnableControlAction(1,303,true)
	       -- DoScreenFadeOut(1)
		    DrawRect(0.5,0.5,-1.0,-1.0,0,0,0,255)
	        SetTextFont(4)
	        SetTextScale(1.0, 2.0)
	        SetTextColour(255, 255, 255, 255)
	        SetTextDropshadow(0, 0, 0, 0, 255)
	        SetTextDropShadow()
	        SetTextOutline()
         	SetTextCentre(true)
			SetTextEntry("STRING")
			AddTextComponentString('Press [~b~U~s~] To Join USA | Press [~b~R~s~] To Join Russia ')
			DrawText(0.5, 0.5)
			
			if IsControlJustPressed(1,  303) then
            ESX.TriggerServerCallback('Cyber:CheckBalance',function(responser)
	
			if responser then
			TriggerServerEvent('Cyber:SetJob','usa')
			while PlayerData.job.name ~= 'usa' do 
			Citizen.Wait(100)
			end 
			if Config.MumbleVoice then
			exports["rp-radio"]:GivePlayerAccessToFrequencies(1, 2, 3, 4, 5)
			ESX.ShowNotification('Press SHIFT+F2 to Open Radio | Your Team Frequencies = 1,2,3,4,5')
			end
			response = true
			FreezeEntityPosition(PlayerPedId(), false)
			SetPlayerInvincible(PlayerPedId(),false)
			CheckTheTeam()
			else
		
			ESX.ShowNotification('~b~USA Is Currently Full',false,true,120)
			end
			end,'usa')
            end
			if IsControlJustPressed(1,  45) then
			ESX.TriggerServerCallback('Cyber:CheckBalance',function(responserr)
		
			if responserr then
			TriggerServerEvent('Cyber:SetJob','russia')
			while PlayerData.job.name ~= 'russia' do 
			Citizen.Wait(100)
			end 
			if Config.MumbleVoice then
			exports["rp-radio"]:GivePlayerAccessToFrequencies(6, 7, 8, 9, 10)
			ESX.ShowNotification('Press SHIFT+F2 to Open Radio | Your Team Frequencies = 6,7,8,9,10')
			end
			response = true
			FreezeEntityPosition(PlayerPedId(), false)
			SetPlayerInvincible(PlayerPedId(),false)
			CheckTheTeam()
            
			else

			ESX.ShowNotification('~r~RUSSIA Is Currently FULL',false,true,120)
			end
			end,'russia')
			end
	   		Citizen.Wait(0)
    end
	
	end)
	FreezeEntityPosition(PlayerPedId(), false)
	SetPlayerInvincible(PlayerPedId(),false)
	--DoScreenFadeIn(800)
end

--                                                  USA PART


--                   RADAR PART
-- Adjust Radar Angle
Citizen.CreateThread(function()
 while true do 
  if isRadarOn then
     if RadarAngle > 500.0 then
	  
      RadarAngle = 0.0
  
     else
	  RadarAngle = RadarAngle + 3.0
	 end
  end 
  Citizen.Wait(0)
 end
end)
-- Blip Making

-- radius blip
local angleblip = nil
local mainangleblip = nil
Citizen.CreateThread(function()
while Config.USABASE == nil or Config.RUSSIABASE == nil do
   Citizen.Wait(10)
   end
 while true do 
    if angleblip then
	RemoveBlip(angleblip)
	angleblip = nil
	end
	if mainangleblip then
	RemoveBlip(mainangleblip)
	mainangleblip = nil
	end
    if isRadarOn then
	 
      local coords = GetEntityCoords(PlayerPedId())
      local mblip = AddBlipForRadius(coords,500.0)
	  SetBlipSprite(mblip,9)
	  SetBlipColour(mblip,6)
	  SetBlipAlpha(mblip,50)
	  mainangleblip = mblip
	  
	  local ablip = AddBlipForRadius(coords,RadarAngle)
	  SetBlipSprite(ablip,9)
	  SetBlipColour(ablip,32)
	  SetBlipAlpha(ablip,150)
	  angleblip = ablip

    end
 Citizen.Wait(0)
 end
end)

-- enemy blip
Citizen.CreateThread(function()
 while Config.USABASE == nil or Config.RUSSIABASE == nil do
   Citizen.Wait(10)
   end
 while true do 
   if isRadarOn then
   
   for k, existingBlip in (radarblips) do
		  RemoveBlip(existingBlip)
   end
   radarblips = {}
   for k, id in pairs(idRUSSIA) do

	  if NetworkIsPlayerActive(id) then
		 local source = id
		 local ped = GetPlayerPed(source)
		 local tcords = GetEntityCoords(ped)
		 local pcords = GetEntityCoords(PlayerPedId())
		 local dist = GetDistanceBetweenCoords(tcords,pcords,false)

		 if dist < 500 then
		  if IsPedInAnyVehicle(ped) then
		    local vehicle = GetVehiclePedIsIn(ped,false)
			if GetEntityModel(vehicle) ~= GetHashKey('strikeforce') then
			 local blip  = AddBlipForCoord(tcords)
			 SetBlipSprite(blip, 1)
		     SetBlipScale(blip, 0.85) -- set scale
		     SetBlipAsShortRange(blip, true)
		     SetBlipColour(blip,6)
			 BeginTextCommandSetBlipName('STRING')
             AddTextComponentString('ENEMY')
             EndTextCommandSetBlipName(blip)
		     table.insert(radarblips, blip) -- add blip to array so we can remove it later
			end
		   end
		 end 
	  end
   end
   
   Citizen.Wait(1000) 
   else
    if radarblips ~= {} then
    for k, existingBlip in pairs(radarblips) do
		  RemoveBlip(existingBlip)
    end
    radarblips = {}
	end
   end
   
   Citizen.Wait(0)
 end
end)
lastvehicle = nil
-- RADAR Bricakde
radarheld = 0

Citizen.CreateThread(function()
  while Config.USABASE == nil or Config.RUSSIABASE == nil do
   Citizen.Wait(10)
   end
  while PlayerData.job == nil do 
  Citizen.Wait(10)
  end
  while true do 
  if PlayerData.job.name == 'usa' and PlayerData.job.grade == 5 then  
   if GetEntityHealth(PlayerPedId()) > 0 then 
    if IsPedInAnyVehicle(PlayerPedId(),false) then
	  local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
	  lastvehicle = vehicle
	    if GetEntityModel(vehicle) == GetHashKey('brickade') then
		
		
	      if isRadarOn then
		  
		    DrawGenericTextThisFrame()
            SetTextEntry("STRING")
            EnableControlAction(0,178,true)
            AddTextComponentString('Hold [~b~F5~s~] To Turn [~r~Off~s~] The Radar ')
            DrawText(0.5, 0.9)
		  
		  else 
		    
			DrawGenericTextThisFrame()
            SetTextEntry("STRING")
            EnableControlAction(0,178,true)
            AddTextComponentString('Hold [~b~F5~s~] To Turn [~g~On~s~] The Radar ')
            DrawText(0.5, 0.9)
		  
		  
		  end
		  if IsControlPressed(0,318) and radarheld > 120 then
		  
		  isRadarOn = not isRadarOn
		  
		  FreezeEntityPosition(vehicle,isRadarOn)
		  radarheld = 0
		  end
		  if IsControlPressed(0,318) then
		  
		  radarheld = radarheld + 1
		  
		  else
		  radarheld = 0
		  end
		  
        end
		
	  else 
	  if lastvehicle then
	  FreezeEntityPosition(lastvehicle,false)
	  print('unfreezed')
	  lastvehicle = nil
	  end
      isRadarOn = false	  
	  end
	else
	
    end
  end

  Citizen.Wait(0) 
  end
end)

local USAairblip = nil
local USAgroundblip = nil
--‌‌BLIP
Citizen.CreateThread(function()
 while Config.USABASE == nil or Config.RUSSIABASE == nil do
   Citizen.Wait(10)
   end
-- main blip
  local main = AddBlipForCoord(Config.USABASE.divisionmark)
  SetBlipSprite(main,119)
  SetBlipDisplay(main,4)
  SetBlipScale(main,2.0)
  SetBlipColour(main,12)
  SetBlipAsShortRange(main,false)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('USA Army')
  EndTextCommandSetBlipName(main)
-- Air Vehicle

  local bmain = AddBlipForCoord(Config.USABASE.avehmark)
  SetBlipSprite(bmain,16)
  SetBlipDisplay(bmain,9)
  SetBlipScale(bmain,1.7)
  SetBlipColour(bmain,12)
  SetBlipAsShortRange(bmain,true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('AIr')
  EndTextCommandSetBlipName(bmain)
  USAairblip = bmain
-- Ground Vehicle
  
  local hmain = AddBlipForCoord(Config.USABASE.gvehmark)
  SetBlipSprite(hmain,426)
  SetBlipDisplay(hmain,9)
  SetBlipScale(hmain,1.7)
  SetBlipColour(hmain,12)
  SetBlipAsShortRange(hmain,true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Ground')
  EndTextCommandSetBlipName(hmain)
  USAgroundblip = hmain



end)

-- Draw USA Markers
Citizen.CreateThread(function()
    while Config.USABASE == nil or Config.RUSSIABASE == nil do
   Citizen.Wait(10)
   end
    while PlayerData.job == nil do
	  Citizen.Wait(10)
	end
   while true do
     if  PlayerData.job.name == 'usa' then
	 
	 
	 
      local coords = GetEntityCoords(PlayerPedId())
	 -- Division Marker
        local dist =  GetDistanceBetweenCoords(Config.USABASE.divisionmark.x,Config.USABASE.divisionmark.y,Config.USABASE.divisionmark.z,coords.x,coords.y,coords.z,true)
	    if dist < 50 then
	    DrawMarker(Config.USABASE.divmarktype, Config.USABASE.divisionmark, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.5, 1.5, 1.0, 255, 255, 255, 50, false, true, 2, nil, nil, false) 
	    if dist < 1.0 then
	    local dv = vector3(Config.USABASE.divisionmark.x,Config.USABASE.divisionmark.y,Config.USABASE.divisionmark.z + 1.0)
	    ESX.Game.Utils.DrawText3D(dv, 'Press [~b~E~s~] To Open Menu',1.5)
		if IsControlJustPressed(0,38) then
		   OpenUSAdivisionMenu()
		end
		
		else 
		
		if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(),'cyber_menu_division') then
		
		   ESX.UI.Menu.Close('default',GetCurrentResourceName(),'cyber_menu_division')
		
		end
		
	    end
		end
	-- Vehicle Marker
	   if PlayerData.job.grade == 5 then
		   local vdist =  GetDistanceBetweenCoords(Config.USABASE.gvehmark.x,Config.USABASE.gvehmark.y,Config.USABASE.gvehmark.z,coords.x,coords.y,coords.z,true)
	       if vdist < 50 then
		   
	        DrawMarker(Config.USABASE.gvehmarktype, Config.USABASE.gvehmark, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 255, 128, 0, 50, false, true, 2, nil, nil, false) 
	       if vdist < 2 then
	       local vdv = vector3(Config.USABASE.gvehmark.x,Config.USABASE.gvehmark.y,Config.USABASE.gvehmark.z + 1.0)
	       ESX.Game.Utils.DrawText3D(vdv, 'Press [~b~E~s~] To Open Menu',1.5)
		   if IsControlJustPressed(0,38) then
		   OpenUSAvehicleMenu()
		   end
		   
		   else
		   if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(),'cyber_menu_vehicle') then
		
		   ESX.UI.Menu.Close('default',GetCurrentResourceName(),'cyber_menu_vehicle')
		
		   end
		   
	       end
		  
           end
       end
	  -- AIrcraft MARKER
	  if PlayerData.job.grade == 6 or PlayerData.job.grade == 8 then
		   local vdist =  GetDistanceBetweenCoords(Config.USABASE.avehmark.x,Config.USABASE.avehmark.y,Config.USABASE.avehmark.z,coords.x,coords.y,coords.z,true)
	       if vdist < 50 then
	        DrawMarker(Config.USABASE.avehmarktype, Config.USABASE.avehmark, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 255, 128, 0, 50, false, true, 2, nil, nil, false) 
	       if vdist < 2 then
	       local vdv = vector3(Config.USABASE.avehmark.x,Config.USABASE.avehmark.y,Config.USABASE.avehmark.z + 1.0)
	       ESX.Game.Utils.DrawText3D(vdv, 'Press [~b~E~s~] To Open Menu',1.5)
		   if IsControlJustPressed(0,38) then
		   OpenUSAaircraftMenu()
		   end
		   
		   else
		   if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(),'cyber_menu_aircraft') then
		
		   ESX.UI.Menu.Close('default',GetCurrentResourceName(),'cyber_menu_aircraft')
		
		 end
		   
	       end
		  
           end
       end
	  
	  
	  else
	  Citizen.Wait(100)
	  end
     
     Citizen.Wait(0)
   end
end)
-- USa Division Menu
function OpenUSAdivisionMenu()
     

     local labelm = nil
      local elements = {
		{label = 'Commando Rifle.Main Weapon: Special Carbine', value = 'comrifle'},
		{label = 'Commando Artillery.Main Weapon : RPG',value = 'comartillery'},
		{label = 'Commando Shotgun.Main Weapon : Shotgun',value = 'comshotgun'},
		{label = 'Commando Sniper.Main Weapon : Marksman Sniper',value = 'comsniper'},
		{label = 'Ground Pilot.Can Spawn Ground Vehicles',value = 'gpilot'},
		{label = 'Aircraft Pilot.Can Spawn Aircraft',value = 'apilot'}
	}
   local didgotcallback = false
	 ESX.TriggerServerCallback('Cyber:CheckPlayerForCommanding',function(data)
	 didgotcallback = true
     if data then
	 table.insert(elements,{label = 'Ground Squad Commander',value = 'gcommander'})
	 table.insert(elements,{label = 'Aircraft Squad Commander',value = 'acommander'})
	 end
     end)
	 
   while didgotcallback == false do
   Wait(10)
   end
	if  labelm == nil then 
	
	  if PlayerData.job.grade == 0 then
	  labelm = ' UNSELECTED'
	  elseif PlayerData.job.grade == 1 then
	  labelm = ' Commando Rifle'
	  elseif PlayerData.job.grade == 2 then
	  labelm = ' Commando Artillery' 
	  elseif PlayerData.job.grade == 3 then
	  labelm = ' Commando Shotgun' 
	  elseif PlayerData.job.grade == 4 then
	  labelm = ' Commando Sniper' 
	  elseif PlayerData.job.grade == 5 then
	  labelm = ' Ground Pilot' 
	  elseif PlayerData.job.grade == 6 then
	  labelm = ' AirCraft Pilot'
	  elseif PlayerData.job.grade == 7 then
	  labelm = ' Ground Squad Commander'
	  elseif PlayerData.job.grade == 8 then
	  labelm = ' Aircraft Squad Commander'
	  end
	 
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cyber_menu_division', {
		title    = 'Your Current Division : ' .. labelm,
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
	
	  SetPlayerParachuteTintIndex(PlayerId(),6)
		SetPlayerParachuteSmokeTrailColor(PlayerId(),0,0,0)
		if data.current.value == 'comrifle' then
		SetPedArmour(PlayerPedId(),100)
		SetEntityHealth(PlayerPedId(),200)
		PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)
		TriggerServerEvent('Cyber:SetGrade','usa',1)
		medkit = Config.MedkitCount
		menu.close()
		elseif data.current.value == 'comartillery' then
		SetPedArmour(PlayerPedId(),100)
		SetEntityHealth(PlayerPedId(),200)
		PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)
		TriggerServerEvent('Cyber:SetGrade','usa',2)
		medkit = Config.MedkitCount
		menu.close()
		elseif data.current.value == 'comshotgun' then
		SetPedArmour(PlayerPedId(),100)
		SetEntityHealth(PlayerPedId(),200)
		PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)
		TriggerServerEvent('Cyber:SetGrade','usa',3)
		medkit = Config.MedkitCount
		menu.close()
		elseif data.current.value == 'comsniper' then
		SetPedArmour(PlayerPedId(),100)
		SetEntityHealth(PlayerPedId(),200)
		PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)
		TriggerServerEvent('Cyber:SetGrade','usa',4)
		medkit = Config.MedkitCount
		menu.close()
		elseif data.current.value == 'gpilot' then
		SetPedArmour(PlayerPedId(),100)
		SetEntityHealth(PlayerPedId(),200)
		PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)
		TriggerServerEvent('Cyber:SetGrade','usa',5)
		medkit = Config.MedkitCount
		menu.close()
		elseif data.current.value == 'apilot' then
		SetPedArmour(PlayerPedId(),100)
		SetEntityHealth(PlayerPedId(),200)
		PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)
		TriggerServerEvent('Cyber:SetGrade','usa',6)
		medkit = Config.MedkitCount
		menu.close() 
        elseif data.current.value == 'gcommander' then
		SetPedArmour(PlayerPedId(),100)
		SetEntityHealth(PlayerPedId(),200)
		PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)
		TriggerServerEvent('Cyber:SetGrade','usa',7)
		medkit = Config.MedkitCount + 1
		menu.close() 
		elseif data.current.value == 'acommander' then
		SetPedArmour(PlayerPedId(),100)
		SetEntityHealth(PlayerPedId(),200)
		PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)
		TriggerServerEvent('Cyber:SetGrade','usa',8)
		medkit = Config.MedkitCount + 1
		menu.close() 
		
        end
	end, function(data, menu)
		menu.close()
	end)
	
end
Citizen.CreateThread(function()


  

end)

-- USA AIRCRAFT MENU
function OpenUSAaircraftMenu()

      local elements = {
		{label = 'Besra JET (best for scouting)', value = 'besra'},
		{label = 'Hydra JET',value = 'hydra'},
		{label = 'Titan . 10 Slot', value = 'titan'}
	}
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cyber_menu_aircraft', {
		title    = 'Aircraft Carrier Spawner',
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'besra' then
		local vehicle = ESX.Game.GetClosestVehicle(Config.USABASE.avehspawn)
		 if GetDistanceBetweenCoords(GetEntityCoords(vehicle),Config.USABASE.avehspawn,true) > Config.PreventFromSpawningDouble then
        ESX.Game.SpawnVehicle('besra', {
		x = Config.USABASE.avehspawn.x,
		y = Config.USABASE.avehspawn.y,
		z = Config.USABASE.avehspawn.z
	    }, Config.USABASE.avehspawnhead, function(vehicle)
 		TaskWarpPedIntoVehicle(PlayerPedId(),  vehicle,  -1)
   	--	SetVehicleMaxMods(vehicle)
    	end)
		menu.close()		
		else
        ESX.ShowNotification('~r~ There Is A Vehicle in Spawner Point',false,true,110)
  		if GetVehicleEngineHealth(vehicle) < 0 then
		DeleteEntity(vehicle)
		ESX.ShowNotification('~g~ Deleted The Junk Vehicle . Please Try Again To Spawn',false,true,110)
		end
	    end		
		elseif data.current.value == 'hydra' then
		local vehicle = ESX.Game.GetClosestVehicle(Config.USABASE.avehspawn)
		 if GetDistanceBetweenCoords(GetEntityCoords(vehicle),Config.USABASE.avehspawn,true) > Config.PreventFromSpawningDouble then
		ESX.Game.SpawnVehicle('hydra', {
		x = Config.USABASE.avehspawn.x,
		y = Config.USABASE.avehspawn.y,
		z = Config.USABASE.avehspawn.z
	    }, Config.USABASE.avehspawnhead, function(vehicle)
 		TaskWarpPedIntoVehicle(PlayerPedId(),  vehicle,  -1)
   	--	SetVehicleMaxMods(vehicle)
    	end)
		menu.close()
		else
		ESX.ShowNotification('~r~ There Is A Vehicle in Spawner Point',false,true,110)
		if GetVehicleEngineHealth(vehicle) < 0 then
		DeleteEntity(vehicle)
		ESX.ShowNotification('~g~ Deleted The Junk Vehicle . Please Try Again To Spawn',false,true,110)
		end
        end
		elseif data.current.value == 'titan' then
		local vehicle = ESX.Game.GetClosestVehicle(Config.USABASE.avehspawn)
		 if GetDistanceBetweenCoords(GetEntityCoords(vehicle),Config.USABASE.avehspawn,true) > Config.PreventFromSpawningDouble then
		ESX.Game.SpawnVehicle('titan', {
		x = Config.USABASE.avehspawn.x,
		y = Config.USABASE.avehspawn.y,
		z = Config.USABASE.avehspawn.z
	    }, Config.USABASE.avehspawnhead, function(vehicle)
 		TaskWarpPedIntoVehicle(PlayerPedId(),  vehicle,  -1)
   	--	SetVehicleMaxMods(vehicle)
    	end)
		menu.close()
		else
		ESX.ShowNotification('~r~ There Is A Vehicle in Spawner Point',false,true,110)
		if GetVehicleEngineHealth(vehicle) < 0 then
		DeleteEntity(vehicle)
		ESX.ShowNotification('~g~ Deleted The Junk Vehicle . Please Try Again To Spawn',false,true,110)
		end
		end
		end
	end, function(data, menu)
		menu.close()
	end)
	
end
-- USA VEHICLE MENU
function OpenUSAvehicleMenu()

      local elements = {
		{label = 'Rhino | 4 Slot', value = 'rhino'},
		{label = 'Insurgent | 6 Slot',value = 'Insurgent'},
		{label = 'Brickade | Supply/Radar',value = 'Brickade'}
	}
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cyber_menu_vehicle', {
		title    = 'Vehicle Spawner Menu',
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'rhino' then
		
    --    ESX.Game.SpawnVehicle('rhino', {x = gvehspawn.x,y = gvehspawn.y,z = gvehspawn.z}, gvehspawnhead, function(vehicle)
        
	--	SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
	--	end)
	   
	   local vehicle = ESX.Game.GetClosestVehicle(Config.USABASE.gvehspawn)
		 if GetDistanceBetweenCoords(GetEntityCoords(vehicle),Config.USABASE.gvehspawn,true) > Config.PreventFromSpawningDouble then
		ESX.Game.SpawnVehicle('rhino', {
		x = Config.USABASE.gvehspawn.x,
		y = Config.USABASE.gvehspawn.y,
		z = Config.USABASE.gvehspawn.z
	    }, Config.USABASE.gvehspawnhead, function(vehicle)
 		TaskWarpPedIntoVehicle(PlayerPedId(),  vehicle,  -1)
   	--	SetVehicleMaxMods(vehicle)
    	end)
		menu.close()		
		else
		ESX.ShowNotification('~r~ There Is A Vehicle in Spawner Point',false,true,110)
		if GetVehicleEngineHealth(vehicle) < 0 then
		DeleteEntity(vehicle)
		ESX.ShowNotification('~g~ Deleted The Junk Vehicle . Please Try Again To Spawn',false,true,110)
		end
		end	
		elseif data.current.value == 'Insurgent' then
		local vehicle = ESX.Game.GetClosestVehicle(Config.USABASE.gvehspawn)
		 if GetDistanceBetweenCoords(GetEntityCoords(vehicle),Config.USABASE.gvehspawn,true) > Config.PreventFromSpawningDouble then
		ESX.Game.SpawnVehicle('insurgent3', {
		x = Config.USABASE.gvehspawn.x,
		y = Config.USABASE.gvehspawn.y,
		z = Config.USABASE.gvehspawn.z
	    }, Config.USABASE.gvehspawnhead, function(vehicle)
 		TaskWarpPedIntoVehicle(PlayerPedId(),  vehicle,  -1)
   	--	SetVehicleMaxMods(vehicle)
    	end)
		menu.close()
		else
		ESX.ShowNotification('~r~ There Is A Vehicle in Spawner Point',false,true,110)
		if GetVehicleEngineHealth(vehicle) < 0 then
		DeleteEntity(vehicle)
		ESX.ShowNotification('~g~ Deleted The Junk Vehicle . Please Try Again To Spawn',false,true,110)
		end
		end
		elseif data.current.value == 'Brickade' then
		local vehicle = ESX.Game.GetClosestVehicle(Config.USABASE.gvehspawn)
		 if GetDistanceBetweenCoords(GetEntityCoords(vehicle),Config.USABASE.gvehspawn,true) > Config.PreventFromSpawningDouble then
		ESX.Game.SpawnVehicle('brickade', {
		x = Config.USABASE.gvehspawn.x,
		y = Config.USABASE.gvehspawn.y,
		z = Config.USABASE.gvehspawn.z
	    }, Config.USABASE.gvehspawnhead, function(vehicle)
 		TaskWarpPedIntoVehicle(PlayerPedId(),  vehicle,  -1)
   	--	SetVehicleMaxMods(vehicle)
    	end)
		menu.close()
		else
        ESX.ShowNotification('~r~ There Is A Vehicle in Spawner Point',false,true,110)
		if GetVehicleEngineHealth(vehicle) < 0 then
		DeleteEntity(vehicle)
		ESX.ShowNotification('~g~ Deleted The Junk Vehicle . Please Try Again To Spawn',false,true,110)
		end
		end
		end
	end, function(data, menu)
		menu.close()
	end)
	
end


--                                                 RUSSIA PART


-- Create Main Blip

local RUSSIAboatblip = nil
local RUSSIAheliblip = nil
local RUSSIAairblip = nil
Citizen.CreateThread(function()
 while Config.USABASE == nil or Config.RUSSIABASE == nil do
   Citizen.Wait(10)
 end
-- main blip
  local main = AddBlipForCoord(Config.RUSSIABASE.divisionmark)
  SetBlipSprite(main,119)
  SetBlipDisplay(main,4)
  SetBlipScale(main,2.0)
  SetBlipColour(main,6)
  SetBlipAsShortRange(main,false)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Russian Army')
  EndTextCommandSetBlipName(main)
-- boat blip

  local bmain = AddBlipForCoord(Config.RUSSIABASE.bvehmark)
  SetBlipSprite(bmain,427)
  SetBlipDisplay(bmain,9)
  SetBlipScale(bmain,1.0)
  SetBlipColour(bmain,6)
  SetBlipAsShortRange(bmain,true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Boat')
  EndTextCommandSetBlipName(bmain)
  RUSSIAboatblip = bmain
-- HEli Blip
  
  local hmain = AddBlipForCoord(Config.RUSSIABASE.hvehmark)
  SetBlipSprite(hmain,43)
  SetBlipDisplay(hmain,9)
  SetBlipScale(hmain,1.0)
  SetBlipColour(hmain,6)
  SetBlipAsShortRange(hmain,true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Helicopter')
  EndTextCommandSetBlipName(hmain)
  RUSSIAheliblip = hmain

-- Aircraft blip
  
   local amain = AddBlipForCoord(Config.RUSSIABASE.avehmark)
  SetBlipSprite(amain,16)
  SetBlipDisplay(amain,9)
  SetBlipScale(amain,1.0)
  SetBlipColour(amain,6)
  SetBlipAsShortRange(amain,true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Aircraft')
  EndTextCommandSetBlipName(amain)
  RUSSIAairblip = amain

end)



--Draw Markers
Citizen.CreateThread(function()
    while PlayerData.job == nil do
	  Citizen.Wait(10)
	end
   while true do
     if  PlayerData.job.name == 'russia' then
	 
	 
	 
      local coords = GetEntityCoords(PlayerPedId())
	 -- Division Marker
        local dist =  GetDistanceBetweenCoords(Config.RUSSIABASE.divisionmark.x,Config.RUSSIABASE.divisionmark.y,Config.RUSSIABASE.divisionmark.z,coords.x,coords.y,coords.z,true)
	    if dist < 50 then
	    DrawMarker(Config.RUSSIABASE.divmarktype, Config.RUSSIABASE.divisionmark, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 255, 255, 255, 50, false, true, 2, nil, nil, false) 
	    if dist < 2 then
	    local dv = vector3(Config.RUSSIABASE.divisionmark.x,Config.RUSSIABASE.divisionmark.y,Config.RUSSIABASE.divisionmark.z + 1.0)
	    ESX.Game.Utils.DrawText3D(dv, 'Press [~b~E~s~] To Open Menu',1.5)
		if IsControlJustPressed(0,38) then
		   OpenRUSSIAdivisionMenu()
		end
		
		else 
		
		if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(),'cyber_menu_division_russia') then
		
		   ESX.UI.Menu.Close('default',GetCurrentResourceName(),'cyber_menu_division_russia')
		
		end
		
	    end
		end
	-- Helicopter Marker
	   if PlayerData.job.grade == 6 or PlayerData.job.grade == 8 then
		   local vdist =  GetDistanceBetweenCoords(Config.RUSSIABASE.hvehmark.x,Config.RUSSIABASE.hvehmark.y,Config.RUSSIABASE.hvehmark.z,coords.x,coords.y,coords.z,true)
	       if vdist < 50 then
		   
	        DrawMarker(Config.RUSSIABASE.hvehmarktype, Config.RUSSIABASE.hvehmark, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 255, 255, 255, 50, false, true, 2, nil, nil, false) 
	       if vdist < 2 then
	       local vdv = vector3(Config.RUSSIABASE.hvehmark.x,Config.RUSSIABASE.hvehmark.y,Config.RUSSIABASE.hvehmark.z + 1.0)
	       ESX.Game.Utils.DrawText3D(vdv, 'Press [~b~E~s~] To Open Menu',1.5)
		   if IsControlJustPressed(0,38) then
		   OpenRUSSIAheliMenu()
		   end
		   
		   else
		   if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(),'cyber_menu_helicopter_russia') then
		
		   ESX.UI.Menu.Close('default',GetCurrentResourceName(),'cyber_menu_helicopter_russia')
		
		   end
		   
	       end
		  
           end
       end
	  -- AIrcraft MARKER
	    if PlayerData.job.grade == 6 or  PlayerData.job.grade == 8 then
		   local vdist =  GetDistanceBetweenCoords(Config.RUSSIABASE.avehmark.x,Config.RUSSIABASE.avehmark.y,Config.RUSSIABASE.avehmark.z,coords.x,coords.y,coords.z,true)
	       if vdist < 50 then
	        DrawMarker(Config.RUSSIABASE.avehmarktype, Config.RUSSIABASE.avehmark, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 255, 255, 255, 50, false, true, 2, nil, nil, false) 
	       if vdist < 2 then
	       local vdv = vector3(Config.RUSSIABASE.avehmark.x,Config.RUSSIABASE.avehmark.y,Config.RUSSIABASE.avehmark.z + 1.0)
	       ESX.Game.Utils.DrawText3D(vdv, 'Press [~b~E~s~] To Open Menu',1.5)
		   if IsControlJustPressed(0,38) then
		   OpenRUSSIAaircraftMenu()
		   end
		   
		   else
		   if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(),'cyber_menu_aircraft_russia') then
		
		   ESX.UI.Menu.Close('default',GetCurrentResourceName(),'cyber_menu_aircraft_russia')
		
		 end
		   
	       end
		  
           end
       end
	  -- Boat Spawn Marker
	  if PlayerData.job.grade == 5 then
		   local vdist =  GetDistanceBetweenCoords(Config.RUSSIABASE.bvehmark.x,Config.RUSSIABASE.bvehmark.y,Config.RUSSIABASE.bvehmark.z,coords.x,coords.y,coords.z,true)
	       if vdist < 50 then
		   
	        DrawMarker(Config.RUSSIABASE.bvehmarktype, Config.RUSSIABASE.bvehmark, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 2.0, 2.0, 2.0, 255, 255, 255, 50, false, true, 2, nil, nil, false) 
	       if vdist < 2 then
	       local vdv = vector3(Config.RUSSIABASE.bvehmark.x,Config.RUSSIABASE.bvehmark.y,Config.RUSSIABASE.bvehmark.z + 1.0)
	       ESX.Game.Utils.DrawText3D(vdv, 'Press [~b~E~s~] To Open Menu',1.5)
		   if IsControlJustPressed(0,38) then
		   OpenRUSSIAboatMenu()
		   end
		   
		   else
		   if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(),'cyber_menu_boat_russia') then
		
		   ESX.UI.Menu.Close('default',GetCurrentResourceName(),'cyber_menu_boat_russia')
		
		   end
		   
	       end
		  
           end
       end
	  
	  else
	  Citizen.Wait(100)
	  end
     
     Citizen.Wait(0)
   end
end)
-- Division Menu

function OpenRUSSIAdivisionMenu()
     local labelm = nil
      local element = {
		{label = 'Commando Rifle.Main Weapon: Special Carbine', value = 'comrifle'},
		{label = 'Commando Artillery.Main Weapon : RPG',value = 'comartillery'},
		{label = 'Commando Shotgun.Main Weapon : Shotgun',value = 'comshotgun'},
		{label = 'Commando Sniper.Main Weapon : Marksman Sniper',value = 'comsniper'},
		{label = 'Boat Pilot.Can Spawn Warship Boat',value = 'gpilot'},
		{label = 'Aircraft Pilot.Can Spawn Aircraft',value = 'apilot'}
	}
	didgotcallback = false
     ESX.TriggerServerCallback('Cyber:CheckPlayerForCommanding',function(data)
	 didgotcallback = true
     if data then
	 table.insert(element,{label = 'Ground Squad Commander',value = 'gcommander'})
	 table.insert(element,{label = 'Aircraft Squad Commander',value = 'acommander'})
	 end
	 end)
   while didgotcallback == false do
   Wait(10)
   end
	if  labelm == nil then
	
	  if PlayerData.job.grade == 0 then
	  labelm = ' UNSELECTED'
	  elseif PlayerData.job.grade == 1 then
	  labelm = ' Commando Rifle'
	  elseif PlayerData.job.grade == 2 then
	  labelm = ' Commando Artillery' 
	  elseif PlayerData.job.grade == 3 then
	  labelm = ' Commando Shotgun' 
	  elseif PlayerData.job.grade == 4 then
	  labelm = ' Commando Sniper' 
	  elseif PlayerData.job.grade == 5 then
	  labelm = ' Ground Pilot' 
	  elseif PlayerData.job.grade == 6 then
	  labelm = ' AirCraft Pilot'
	  elseif PlayerData.job.grade == 7 then
	  labelm = ' Ground Squad Commander'
	  elseif PlayerData.job.grade == 8 then
	  labelm = ' Aircraft Squad Commander'
	  end
	 
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cyber_menu_division_russia', {
		title    = 'Your Current Division : ' .. labelm,
		align    = 'top-right',
		elements = element
	}, function(data, menu)
	    SetPlayerParachuteTintIndex(PlayerId(),6)
		SetPlayerParachuteSmokeTrailColor(PlayerId(),0,0,0)
		if data.current.value == 'comrifle' then
		SetPedArmour(PlayerPedId(),100)
		SetEntityHealth(PlayerPedId(),200)
		PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)
		TriggerServerEvent('Cyber:SetGrade','russia',1)
		medkit = Config.MedkitCount
		menu.close()
		elseif data.current.value == 'comartillery' then
		SetPedArmour(PlayerPedId(),100)
		SetEntityHealth(PlayerPedId(),200)
		PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)
		TriggerServerEvent('Cyber:SetGrade','russia',2)
		medkit = Config.MedkitCount
		menu.close()
		elseif data.current.value == 'comshotgun' then
		SetPedArmour(PlayerPedId(),100)
		SetEntityHealth(PlayerPedId(),200)
		PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)
		TriggerServerEvent('Cyber:SetGrade','russia',3)
		medkit = Config.MedkitCount
		menu.close()
		elseif data.current.value == 'comsniper' then
		SetPedArmour(PlayerPedId(),100)
		SetEntityHealth(PlayerPedId(),200)
		PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)
		TriggerServerEvent('Cyber:SetGrade','russia',4)
		medkit = Config.MedkitCount
		menu.close()
		elseif data.current.value == 'gpilot' then
		SetPedArmour(PlayerPedId(),100)
		SetEntityHealth(PlayerPedId(),200)
		PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)
		TriggerServerEvent('Cyber:SetGrade','russia',5)
        medkit = Config.MedkitCount		
		menu.close()
		elseif data.current.value == 'apilot' then
		SetPedArmour(PlayerPedId(),100)
		SetEntityHealth(PlayerPedId(),200)
		PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)
		TriggerServerEvent('Cyber:SetGrade','russia',6)
		medkit = Config.MedkitCount
		menu.close()

        elseif data.current.value == 'gcommander' then
		SetPedArmour(PlayerPedId(),100)
		SetEntityHealth(PlayerPedId(),200)
		PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)
		TriggerServerEvent('Cyber:SetGrade','russia',7)
		medkit = Config.MedkitCount + 1
		menu.close() 
		elseif data.current.value == 'acommander' then
		SetPedArmour(PlayerPedId(),100)
		SetEntityHealth(PlayerPedId(),200)
		PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)
		TriggerServerEvent('Cyber:SetGrade','russia',8)
		medkit = Config.MedkitCount + 1
		menu.close() 
		

        end
	end, function(data, menu)
		menu.close()
	end)
	
end

-- Helicopter Menu
function OpenRUSSIAheliMenu()

      local elements = {
		{label = 'Transport AirCraft 8 Slot', value = 'cargobob'},
		{label = 'SAVAGE . Fighter Helicopter',value = 'savage'}
	}
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cyber_menu_helicopter_russia', {
		title    = 'Helicopter Spawner',
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
	    if data.current.value == 'cargobob' then
		local vehicle = ESX.Game.GetClosestVehicle(Config.RUSSIABASE.hvehspawn)
		 if GetDistanceBetweenCoords(GetEntityCoords(vehicle),Config.RUSSIABASE.hvehspawn,true) > Config.PreventFromSpawningDouble then
        ESX.Game.SpawnVehicle('cargobob', {
		x = Config.RUSSIABASE.hvehspawn.x,
		y = Config.RUSSIABASE.hvehspawn.y,
		z = Config.RUSSIABASE.hvehspawn.z
	    }, Config.RUSSIABASE.hvehspawnhead, function(vehicle)
 		TaskWarpPedIntoVehicle(PlayerPedId(),  vehicle,  -1)
   	--	SetVehicleMaxMods(vehicle)
    	end)
		
		menu.close()
        else
		
		ESX.ShowNotification('~r~ There Is A Vehicle in Spawner Point',false,true,110)
         		if GetVehicleEngineHealth(vehicle) < 0 then
		DeleteEntity(vehicle)
		ESX.ShowNotification('~g~ Deleted The Junk Vehicle . Please Try Again To Spawn',false,true,110)
		end
		end
			
		elseif data.current.value == 'savage' then
	    local vehicle = ESX.Game.GetClosestVehicle(Config.RUSSIABASE.hvehspawn)
		 if GetDistanceBetweenCoords(GetEntityCoords(vehicle),Config.RUSSIABASE.hvehspawn,true) > Config.PreventFromSpawningDouble then
		ESX.Game.SpawnVehicle('savage', {
		x = Config.RUSSIABASE.hvehspawn.x,
		y = Config.RUSSIABASE.hvehspawn.y,
		z = Config.RUSSIABASE.hvehspawn.z
	    }, Config.RUSSIABASE.hvehspawnhead, function(vehicle)
 		TaskWarpPedIntoVehicle(PlayerPedId(),  vehicle,  -1)
   	--	SetVehicleMaxMods(vehicle)
    	end)
		menu.close()
	    else
	    
		ESX.ShowNotification('~r~ There Is A Vehicle in Spawner Point',false,true,110)
		if GetVehicleEngineHealth(vehicle) < 0 then
		DeleteEntity(vehicle)
		ESX.ShowNotification('~g~ Deleted The Junk Vehicle . Please Try Again To Spawn',false,true,110)
		end
		end
		end
	end, function(data, menu)
		menu.close()
	end)
	
end
-- AirCraft Russia

function OpenRUSSIAaircraftMenu()

      local elements = {
		{label = 'Strike Force Stealth Fighter', value = 'strikeforce'},
		{label = 'Lazer JET',value = 'lazer'}
	}
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cyber_menu_aircraft_russia', {
		title    = 'Aircraft Carrier Spawner',
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'lazer' then
		local vehicle = ESX.Game.GetClosestVehicle(Config.RUSSIABASE.avehspawn)
	    if GetDistanceBetweenCoords(GetEntityCoords(vehicle),Config.RUSSIABASE.avehspawn,true) > Config.PreventFromSpawningDouble then
        ESX.Game.SpawnVehicle('lazer', {
		x = Config.RUSSIABASE.avehspawn.x,
		y = Config.RUSSIABASE.avehspawn.y,
		z = Config.RUSSIABASE.avehspawn.z
	    }, Config.RUSSIABASE.avehspawnhead, function(vehicle)
 		TaskWarpPedIntoVehicle(PlayerPedId(),  vehicle,  -1)
   
    	end)
		menu.close()		
		else
		
        	ESX.ShowNotification('~r~ There Is A Vehicle in Spawner Point',false,true,110)
  		if GetVehicleEngineHealth(vehicle) < 0 then
		DeleteEntity(vehicle)
		ESX.ShowNotification('~g~ Deleted The Junk Vehicle . Please Try Again To Spawn',false,true,110)
		end
	    end		
		elseif data.current.value == 'strikeforce' then
		 local vehicle = ESX.Game.GetClosestVehicle(Config.RUSSIABASE.avehspawn)
		 if GetDistanceBetweenCoords(GetEntityCoords(vehicle),Config.RUSSIABASE.avehspawn,true) > Config.PreventFromSpawningDouble then
		ESX.Game.SpawnVehicle('strikeforce', {
		x = Config.RUSSIABASE.avehspawn.x,
		y = Config.RUSSIABASE.avehspawn.y,
		z = Config.RUSSIABASE.avehspawn.z
	    }, Config.RUSSIABASE.avehspawnhead, function(vehicle)
 		TaskWarpPedIntoVehicle(PlayerPedId(),  vehicle,  -1)
   	
    	end)
		menu.close()
		else
		   
			ESX.ShowNotification('~r~ There Is A Vehicle in Spawner Point',false,true,110)
		   if GetVehicleEngineHealth(vehicle) < 0 then
		DeleteEntity(vehicle)
		ESX.ShowNotification('~g~ Deleted The Junk Vehicle . Please Try Again To Spawn',false,true,110)
		end
         end
		end
	end, function(data, menu)
		menu.close()
	end)
	
end

-- Boat Spawn Menu

function OpenRUSSIAboatMenu()

      local elements = {
		{label = 'Dinghy | Warship Boat', value = 'dinghy4'}
	}
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cyber_menu_boat_russia', {
		title    = 'Aircraft Carrier Spawner',
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'dinghy4' then
	    local vehicle = ESX.Game.GetClosestVehicle(Config.RUSSIABASE.bvehspawn)
		if GetDistanceBetweenCoords(GetEntityCoords(vehicle),Config.RUSSIABASE.bvehspawn,false) > Config.PreventFromSpawningDouble then
        ESX.Game.SpawnVehicle('dinghy4', {
		x = Config.RUSSIABASE.bvehspawn.x,
		y = Config.RUSSIABASE.bvehspawn.y,
		z = Config.RUSSIABASE.bvehspawn.z
	    }, Config.RUSSIABASE.bvehspawnhead, function(vehicle)
 		TaskWarpPedIntoVehicle(PlayerPedId(),  vehicle,  -1)
       
    	end)
		menu.close()		
		else
          ESX.ShowNotification('~r~ There Is A Vehicle in Spawner Point',false,true,110)
		  if GetVehicleEngineHealth(vehicle) < 0 then
		DeleteEntity(vehicle)
		ESX.ShowNotification('~g~ Deleted The Junk Vehicle . Please Try Again To Spawn',false,true,110)
		end
		end
		end
	end, function(data, menu)
		menu.close()
	end)
	
end

--                                                 Blip System

 RegisterNetEvent('Cyber:updateBlip')
 AddEventHandler('Cyber:updateBlip', function()
	while ESX == nil do 
	Citizen.Wait(10)
	end
	  -- Refresh all blips
	  for k, existingBlip in pairs(blipRUSSIA) do
		  RemoveBlip(existingBlip)
	  end
	  for k, existingBlip in pairs(blipUSA) do
		  RemoveBlip(existingBlip)
	  end

	  -- Clean the blip table
	  blipUSA = {}
	  blipRUSSIA = {}
      idUSA = {}
	  idRUSSIA = {}
	 


		  ESX.TriggerServerCallback('Cyber:GetPlayersForBlip', function(players)
			  for i=1, #players, 1 do
			  
			  if PlayerData.job ~= nil and PlayerData.job.name == 'usa' then
			    
				  if players[i].job.name == 'usa' then
					  local id = GetPlayerFromServerId(players[i].source)
					  if NetworkIsPlayerActive(id) and id ~= PlayerId() then
					
						  createBlipUSA(id)
						  table.insert(idUSA,id)
					  end
			     elseif players[i].job.name == 'russia' then
				     local id = GetPlayerFromServerId(players[i].source)
                    table.insert(idRUSSIA,id)				     
					 
				  end
			 	  
			 elseif PlayerData.job ~= nil and PlayerData.job.name == 'russia' then
			 
			    if players[i].job.name == 'russia' then
					  local id = GetPlayerFromServerId(players[i].source)
					  if NetworkIsPlayerActive(id) and id ~= PlayerId() then
						  createBlipRUSSIA(id)
					
						  table.insert(idRUSSIA,id)
					  end
			         elseif players[i].job.name == 'usa' then
				      local id = GetPlayerFromServerId(players[i].source)
                      table.insert(idUSA,id)				     
					 
				  end
			  
			 end
			 end
			 
			 
		  end)

  
  end)

function createBlipUSA(id)
	  local ped = GetPlayerPed(id)
	  local blip = GetBlipFromEntity(ped)
  
	  if not DoesBlipExist(blip) then -- Add blip and create head display on player
		  blip = AddBlipForEntity(ped)
		  SetBlipSprite(blip, 1)
		  SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		  SetBlipNameToPlayerName(blip, id) -- update blip name
		  SetBlipScale(blip, 0.85) -- set scale
		  SetBlipAsShortRange(blip, true)
		  SetBlipColour(blip,12)
		  table.insert(blipUSA, blip) -- add blip to array so we can remove it later
	  end
end
function createBlipRUSSIA(id)
	  local ped = GetPlayerPed(id)
	  local blip = GetBlipFromEntity(ped)
  
	  if not DoesBlipExist(blip) then -- Add blip and create head display on player
		  blip = AddBlipForEntity(ped)
		  SetBlipSprite(blip, 1)
		  SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		  SetBlipNameToPlayerName(blip, id) -- update blip name
		  SetBlipScale(blip, 0.85) -- set scale
		  SetBlipAsShortRange(blip, true)
		  SetBlipColour(blip,6)
		  table.insert(blipRUSSIA, blip) -- add blip to array so we can remove it later
	  end
end
--                                                 Supply SYSTEM 


--local busy = false
--Citizen.CreateThread(function()
--whiel


--ESX.UI.HUD.RegisterElement('job', #playerData.accounts, 0, jobTpl, {
--			job_label = playerData.job.label,
--			grade_label = playerData.job.grade_label
--		})



--end)



Citizen.CreateThread(function()
while Config.EnableDelayForSupply do
  if busy then
 
  Citizen.Wait(Config.SuppplyDelay)
  busy = false
 
  end
Citizen.Wait(0)
end
end)
-- USA Brickade 

local usupplyrheld = 0
local usupplyaheld = 0
local usupplyhheld = 0
Citizen.CreateThread(function()
while Config.USABASE == nil or Config.RUSSIABASE == nil do
   Citizen.Wait(10)
end
while true do
  if Config.EnableSupply then
    while ESX == nil do 
	Citizen.Wait(10)
	end
	while PlayerData.job == nil do
	Citizen.Wait(10)
	end
 if PlayerData.job.name == 'usa' then	
   if not IsPedInAnyVehicle(PlayerPedId()) and not IsPedDeadOrDying(PlayerPedId(),1) then
   local cords = GetEntityCoords(PlayerPedId())
   
	local vehicle = ESX.Game.GetClosestVehicle()
	 if vehicle ~= nil then
	   if GetVehicleEngineHealth(vehicle) > 0 then
	   if GetEntityModel(vehicle) == GetHashKey('brickade') then
	    local posv = GetEntityCoords(vehicle)
	    local posp = GetEntityCoords(PlayerPedId())
	    local dist = GetDistanceBetweenCoords(posv,posp,true)
	   if dist < 500.0 then
		DrawMarker(27, posv.x,posv.y,posv.z - 1.35, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 6.0, 6.0, 2.0, 51, 204, 255, 100, false, true, 2, nil, nil, false) 
		  if dist < 3 then
		    DrawGenericTextThisFrame()
            SetTextEntry("STRING")
            AddTextComponentString('Hold [~b~U~s~] To Reload Your AMMO ~y~|~s~ Hold [~r~F5~s~] To ReArmor ~y~|~s~ Hold [~g~F6~s~] To ReHealth')
            DrawText(0.5, 0.9)
			-- RELOAD
		    if IsControlPressed(0,303) and usupplyrheld > 160 then
			  usupplyrheld = 0
			  local result,weapon = GetCurrentPedWeapon(PlayerPedId(),true)
			  if result then
			    busy = true
			    if weapon == GetHashKey('WEAPON_UNARMED') then
 
                ESX.ShowNotification('~r~ You Dont Have Any Weapon In your ~y~Hand',false,true,130)				
				
				elseif weapon == GetHashKey('WEAPON_COMBATPISTOL') then
				  local ammo = GetAmmoInPedWeapon(PlayerPedId(),weapon)
				  if ammo + 16 < Config.WeaponAmmo.CombatPistol then
				  
				   SetPedAmmo(PlayerPedId(),weapon, ammo + 16)
				   ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~Combat Pistol',false,true,210)
				  
				  elseif ammo == Config.WeaponAmmo.CombatPistol then
				  
				   ESX.ShowNotification('~r~ You can not Load Any More Ammo',false,true,130)
				  
			      elseif ammo + 16 > Config.WeaponAmmo.CombatPistol then
			         
					 SetPedAmmo(PlayerPedId(),weapon, Config.WeaponAmmo.CombatPistol)
				     ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~Combat Pistol',false,true,210)
				 	 
			     end
				elseif weapon == GetHashKey('WEAPON_SPECIALCARBINE') then
                  local ammo = GetAmmoInPedWeapon(PlayerPedId(),weapon)
				  if ammo + 30 < Config.WeaponAmmo.SpecialCarbine then
				  
				   SetPedAmmo(PlayerPedId(),weapon, ammo + 30)
				   ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~Special Carbine',false,true,210)
				  
				  elseif ammo == Config.WeaponAmmo.SpecialCarbine then
				  
				   ESX.ShowNotification('~r~You can not Load Any More Ammo',false,true,130)
				  
			      elseif ammo + 30 >= Config.WeaponAmmo.SpecialCarbine then
			         
					 SetPedAmmo(PlayerPedId(),weapon, Config.WeaponAmmo.SpecialCarbine)
				     ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~Special Carbine',false,true,210)
				 	 
			     end
			    elseif weapon == GetHashKey('WEAPON_RPG') then
				  local ammo = GetAmmoInPedWeapon(PlayerPedId(),weapon)
				  if ammo + 1 < Config.WeaponAmmo.RPG then
				  
				   SetPedAmmo(PlayerPedId(),weapon, ammo + 1)
				   ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~RPG',false,true,210)
				  
				  elseif ammo == Config.WeaponAmmo.RPG then
				  
				   ESX.ShowNotification('~r~You can not Load Any More Ammo',false,true,130)
				  
			      elseif ammo + 1 > Config.WeaponAmmo.RPG then
			         
					 SetPedAmmo(PlayerPedId(),weapon, Config.WeaponAmmo.RPG)
				     ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~RPG',false,true,210)
				 	 
			     end
			   elseif weapon == GetHashKey('WEAPON_SMG') then
				 local ammo = GetAmmoInPedWeapon(PlayerPedId(),weapon)
				  if ammo + 30 < Config.WeaponAmmo.SMG then
				  
				   SetPedAmmo(PlayerPedId(),weapon, ammo + 30)
				   ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~SMG',false,true,210)
				  
				  elseif ammo == Config.WeaponAmmo.SMG then
				  
				   ESX.ShowNotification('~r~You can not Load Any More Ammo',false,true,130)
				  
			      elseif ammo + 30 > Config.WeaponAmmo.SMG then
			         
					 SetPedAmmo(PlayerPedId(),weapon, Config.WeaponAmmo.SMG)
				     ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~SMG',false,true,210)
				 	 
			     end
		       elseif weapon == GetHashKey('WEAPON_ASSAULTSHOTGUN') then		 
		        
				 local ammo = GetAmmoInPedWeapon(PlayerPedId(),weapon)
				  if ammo + 32 < Config.WeaponAmmo.Shotgun then
				  
				   SetPedAmmo(PlayerPedId(),weapon, ammo + 32)
				   ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~Shotgun',false,true,210)
				  
				  elseif ammo == Config.WeaponAmmo.Shotgun then
				  
				   ESX.ShowNotification('~r~You can not Load Any More Ammo',false,true,130)
				  
			      elseif ammo + 32 > Config.WeaponAmmo.Shotgun then
			         
					 SetPedAmmo(PlayerPedId(),weapon, Config.WeaponAmmo.Shotgun)
				     ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~Shotgun',false,true,210)
				 	 
			     end
			  elseif weapon == GetHashKey('WEAPON_MARKSMANRIFLE') then
			      local ammo = GetAmmoInPedWeapon(PlayerPedId(),weapon)
				  if ammo + 16 < Config.WeaponAmmo.Sniper then
				  
				   SetPedAmmo(PlayerPedId(),weapon, ammo + 16)
				   ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~Sniper',false,true,210)
				  
				  elseif ammo == Config.WeaponAmmo.Sniper then
				  
				   ESX.ShowNotification('~r~You can not Load Any More Ammo',false,true,130)
				  
			      elseif ammo + 16 > Config.WeaponAmmo.Sniper then
			         
					 SetPedAmmo(PlayerPedId(),weapon, Config.WeaponAmmo.Sniper)
				     ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~Sniper',false,true,210)
				 	 
			     end
			  elseif weapon == GetHashKey('WEAPON_CARBINERIFLE') then
			    
				local ammo = GetAmmoInPedWeapon(PlayerPedId(),weapon)
				  if ammo + 30 < Config.WeaponAmmo.CarbineRifle then
				  
				   SetPedAmmo(PlayerPedId(),weapon, ammo + 30)
				   ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~Carbine Rifle',false,true,210)
				  
				  elseif ammo == Config.WeaponAmmo.CarbineRifle then
				  
				   ESX.ShowNotification('~r~You can not Load Any More Ammo',false,true,130)
				  
			      elseif ammo + 30 > Config.WeaponAmmo.CarbineRifle then
			         
					 SetPedAmmo(PlayerPedId(),weapon, Config.WeaponAmmo.CarbineRifle)
				     ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~Carbine Rifle',false,true,210)
				 	 
			     end
			 else  
				 
				 ESX.ShowNotification('~r~ UNKNOWN WEAPON',false,true,130)
				end
			  end
		    end
		    if IsControlPressed(0,303) then
			if not busy then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?
			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen
			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle
			DisableControlAction(2, 36, true) -- Disable going stealth
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee

	
			 local zarb = usupplyrheld * 100
			 local taghsim = zarb / 160
			 local final = math.ceil(taghsim)
			 DrawGenericTextThisFrame()
             SetTextEntry("STRING")
             AddTextComponentString('~b~ PROGRESS: ' .. final .. '%~s~')
             DrawText(0.5, 0.8)
			 DisablePlayerFiring(PlayerId(),true)
			 
			 usupplyrheld = usupplyrheld + 1
			else
			ESX.ShowNotification('~r~ You are Using The Supply Quickly. Please Wait',false,true,130)
			end
			else
			usupplyrheld = 0
			end
			-- REARMOR
			if IsControlPressed(0,166) and usupplyaheld > 220 then
			  busy = true 
			  SetPedArmour(PlayerPedId(),100)
			  ESX.ShowNotification('~b~ Armor Refilled',false,true,130)
			usupplyaheld = 0
		    end
		    if IsControlPressed(0,166) then
			if not busy then 
			 
			 DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?
			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen
			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle
			DisableControlAction(2, 36, true) -- Disable going stealth
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			 
			 FreezeEntityPosition(PlayerPedId(),true)
			 local zarb = usupplyaheld * 100
			 local taghsim = zarb / 220
			 local final = math.ceil(taghsim)
			 DrawGenericTextThisFrame()
             SetTextEntry("STRING")
             AddTextComponentString('~r~ PROGRESS: ' .. final .. '%~s~')
             DrawText(0.5, 0.8)
			 DisablePlayerFiring(PlayerId(),true)
			 usupplyaheld = usupplyaheld + 1
			else
            ESX.ShowNotification('~r~ You are Using The Supply Quickly. Please Wait',false,true,130)
            end			
			else
			FreezeEntityPosition(PlayerPedId(),false)
			usupplyaheld = 0
			end
			-- ReHealth
			if IsControlPressed(0,167) and usupplyhheld > 260 then
			  busy = true
			  SetEntityHealth(PlayerPedId(),200)
			  ESX.ShowNotification('~g~ Health Refilled',false,true,130)
			  usupplyhheld = 0
		    end
		    if IsControlPressed(0,167) then
			if not busy then
			 
			 DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?
			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen
			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle
			DisableControlAction(2, 36, true) -- Disable going stealth
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			 
			 FreezeEntityPosition(PlayerPedId(),true)
			 local zarb = usupplyhheld * 100
			 local taghsim = zarb / 260
			 local final = math.ceil(taghsim)
			 DrawGenericTextThisFrame()
             SetTextEntry("STRING")
             AddTextComponentString('~g~ PROGRESS: ' .. final .. '%~s~')
             DrawText(0.5, 0.8)
			 DisablePlayerFiring(PlayerId(),true)
			 
			 
			 usupplyhheld = usupplyhheld + 1
			else
			ESX.ShowNotification('~r~ You are Using The Supply Quickly. Please Wait',false,true,130)
			end
			else
			FreezeEntityPosition(PlayerPedId(),false)
			usupplyhheld = 0
			end
	       else
		   
		   usupplyrheld = 0
           usupplyaheld = 0
           usupplyhheld = 0
		   
		   end
		 else  
		   
		   
		   
         end
	   end
     end
    end
   end
  end
end  
  Citizen.Wait(0)
end
end)

-- RUSSIA Cargobob 

local rusupplyrheld = 0
local rusupplyaheld = 0
local rusupplyhheld = 0
Citizen.CreateThread(function()
while Config.USABASE == nil or Config.RUSSIABASE == nil do
   Citizen.Wait(10)
end
while true do
  if Config.EnableSupply then
    while ESX == nil do 
	Citizen.Wait(10)
	end
	while PlayerData.job == nil do
	Citizen.Wait(10)
	end
 if PlayerData.job.name == 'russia' then	
   if not IsPedInAnyVehicle(PlayerPedId()) and not IsPedDeadOrDying(PlayerPedId(),1) then
	local vehicle = ESX.Game.GetClosestVehicle()
	 if vehicle ~= nil then
	   if GetEntityModel(vehicle) == GetHashKey('cargobob') then
	    local posv = GetEntityCoords(vehicle)
	    local posp = GetEntityCoords(PlayerPedId())
	    local dist = GetDistanceBetweenCoords(posv,posp,true)
	   if dist < 100 then
		DrawMarker(27, posv.x,posv.y,posv.z - 1.35, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 10.0, 10.0, 2.0, 51, 204, 255, 100, false, true, 2, nil, nil, false) 
		  if dist < 5 then
		    DrawGenericTextThisFrame()
            SetTextEntry("STRING")
            AddTextComponentString('Hold [~b~U~s~] To Reload Your AMMO ~y~|~s~ Hold [~r~F5~s~] To ReArmor ~y~|~s~ Hold [~g~F6~s~] To ReHealth')
            DrawText(0.5, 0.9)
			-- RELOAD
		    if IsControlPressed(0,303) and rusupplyrheld > 160 then
			  rusupplyrheld = 0
			  local result,weapon = GetCurrentPedWeapon(PlayerPedId(),true)
			  if result then
			    busy = true
			    if weapon == GetHashKey('WEAPON_UNARMED') then
 
                ESX.ShowNotification('~r~ You Dont Have Any Weapon In your ~y~Hand',false,true,130)				
				
				elseif weapon == GetHashKey('WEAPON_COMBATPISTOL') then
				  local ammo = GetAmmoInPedWeapon(PlayerPedId(),weapon)
				  if ammo + 16 < Config.WeaponAmmo.CombatPistol then
				  
				   SetPedAmmo(PlayerPedId(),weapon, ammo + 16)
				   ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~Combat Pistol',false,true,210)
				  
				  elseif ammo == Config.WeaponAmmo.CombatPistol then
				  
				   ESX.ShowNotification('~r~ You can not Load Any More Ammo',false,true,130)
				  
			      elseif ammo + 16 > Config.WeaponAmmo.CombatPistol then
			         
					 SetPedAmmo(PlayerPedId(),weapon, Config.WeaponAmmo.CombatPistol)
				     ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~Combat Pistol',false,true,210)
				 	 
			     end
				elseif weapon == GetHashKey('WEAPON_SPECIALCARBINE') then
                  local ammo = GetAmmoInPedWeapon(PlayerPedId(),weapon)
				  if ammo + 30 < Config.WeaponAmmo.SpecialCarbine then
				  
				   SetPedAmmo(PlayerPedId(),weapon, ammo + 30)
				   ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~Special Carbine',false,true,210)
				  
				  elseif ammo == Config.WeaponAmmo.SpecialCarbine then
				  
				   ESX.ShowNotification('~r~You can not Load Any More Ammo',false,true,130)
				  
			      elseif ammo + 30 > Config.WeaponAmmo.SpecialCarbine then
			         
					 SetPedAmmo(PlayerPedId(),weapon, Config.WeaponAmmo.SpecialCarbine)
				     ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~Special Carbine',false,true,210)
				 	 
			     end
			    elseif weapon == GetHashKey('WEAPON_RPG') then
				  local ammo = GetAmmoInPedWeapon(PlayerPedId(),weapon)
				  if ammo + 1 < Config.WeaponAmmo.RPG then
				  
				   SetPedAmmo(PlayerPedId(),weapon, ammo + 1)
				   ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~RPG',false,true,210)
				  
				  elseif ammo == Config.WeaponAmmo.RPG then
				  
				   ESX.ShowNotification('~r~You can not Load Any More Ammo',false,true,130)
				  
			      elseif ammo + 1 > Config.WeaponAmmo.RPG then
			         
					 SetPedAmmo(PlayerPedId(),weapon, Config.WeaponAmmo.RPG)
				     ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~RPG',false,true,210)
				 	 
			     end
			   elseif weapon == GetHashKey('WEAPON_SMG') then
				 local ammo = GetAmmoInPedWeapon(PlayerPedId(),weapon)
				  if ammo + 30 < Config.WeaponAmmo.SMG then
				  
				   SetPedAmmo(PlayerPedId(),weapon, ammo + 30)
				   ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~SMG',false,true,210)
				  
				  elseif ammo == Config.WeaponAmmo.SMG then
				  
				   ESX.ShowNotification('~r~You can not Load Any More Ammo',false,true,130)
				  
			      elseif ammo + 30 > Config.WeaponAmmo.SMG then
			         
					 SetPedAmmo(PlayerPedId(),weapon, Config.WeaponAmmo.SMG)
				     ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~SMG',false,true,210)
				 	 
			     end
		       elseif weapon == GetHashKey('WEAPON_ASSAULTSHOTGUN') then		 
		        
				 local ammo = GetAmmoInPedWeapon(PlayerPedId(),weapon)
				  if ammo + 32 < Config.WeaponAmmo.Shotgun then
				  
				   SetPedAmmo(PlayerPedId(),weapon, ammo + 32)
				   ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~Shotgun',false,true,210)
				  
				  elseif ammo == Config.WeaponAmmo.Shotgun then
				  
				   ESX.ShowNotification('~r~You can not Load Any More Ammo',false,true,130)
				  
			      elseif ammo + 32 > Config.WeaponAmmo.Shotgun then
			         
					 SetPedAmmo(PlayerPedId(),weapon, Config.WeaponAmmo.Shotgun)
				     ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~Shotgun',false,true,210)
				 	 
			     end
			  elseif weapon == GetHashKey('WEAPON_MARKSMANRIFLE') then
			      local ammo = GetAmmoInPedWeapon(PlayerPedId(),weapon)
				  if ammo + 16 < Config.WeaponAmmo.Sniper then
				  
				   SetPedAmmo(PlayerPedId(),weapon, ammo + 16)
				   ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~Sniper',false,true,210)
				  
				  elseif ammo == Config.WeaponAmmo.Sniper then
				  
				   ESX.ShowNotification('~r~You can not Load Any More Ammo',false,true,130)
				  
			      elseif ammo + 16 > Config.WeaponAmmo.Sniper then
			         
					 SetPedAmmo(PlayerPedId(),weapon, Config.WeaponAmmo.Sniper)
				     ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~Sniper',false,true,210)
				 	 
			     end
			  elseif weapon == GetHashKey('WEAPON_CARBINERIFLE') then
			    
				local ammo = GetAmmoInPedWeapon(PlayerPedId(),weapon)
				  if ammo + 30 < Config.WeaponAmmo.CarbineRifle then
				  
				   SetPedAmmo(PlayerPedId(),weapon, ammo + 30)
				   ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~Carbine Rifle',false,true,210)
				  
				  elseif ammo == Config.WeaponAmmo.CarbineRifle then
				  
				   ESX.ShowNotification('~r~You can not Load Any More Ammo',false,true,130)
				  
			      elseif ammo + 30 > Config.WeaponAmmo.CarbineRifle then
			         
					 SetPedAmmo(PlayerPedId(),weapon, Config.WeaponAmmo.CarbineRifle)
				     ESX.ShowNotification('~g~You Succesfully Refilled a Magazine in ~y~Carbine Rifle',false,true,210)
				 	 
			     end
			 else  
				 
				 ESX.ShowNotification('~r~ UNKNOWN WEAPON',false,true,130)
				end
			  end
		    end
		    if IsControlPressed(0,303) then
			if not busy then
			 DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?
			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen
			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle
			DisableControlAction(2, 36, true) -- Disable going stealth
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			 
			 FreezeEntityPosition(PlayerPedId(),true)
			 local zarb = rusupplyrheld * 100
			 local taghsim = zarb / 160
			 local final = math.ceil(taghsim)
			 DrawGenericTextThisFrame()
             SetTextEntry("STRING")
             AddTextComponentString('~b~ PROGRESS: ' .. final .. '%~s~')
             DrawText(0.5, 0.8)
			 DisablePlayerFiring(PlayerId(),true)
			 
			 
			 rusupplyrheld = rusupplyrheld + 1
			else
			ESX.ShowNotification('~r~ You are Using The Supply Quickly. Please Wait',false,true,130)
			end
			else
			FreezeEntityPosition(PlayerPedId(),false)
			rusupplyrheld = 0
			end
			-- REARMOR
			if IsControlPressed(0,166) and rusupplyaheld > 220 then
			  busy = true
			  SetPedArmour(PlayerPedId(),100)
			  ESX.ShowNotification('~b~ Armor Refilled',false,true,130)
			rusupplyaheld = 0
		    end
		    if IsControlPressed(0,166) then
			if not busy then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?
			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen
			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle
			DisableControlAction(2, 36, true) -- Disable going stealth
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			
			 FreezeEntityPosition(PlayerPedId(),true)
			 local zarb = rusupplyrheld * 100
			 local taghsim = zarb / 220
			 local final = math.ceil(taghsim)
			 DrawGenericTextThisFrame()
             SetTextEntry("STRING")
             AddTextComponentString('~r~ PROGRESS: ' .. final .. '%~s~')
             DrawText(0.5, 0.8)
			 DisablePlayerFiring(PlayerId(),true)
			 
			 rusupplyaheld = rusupplyaheld + 1
			else
			ESX.ShowNotification('~r~ You are Using The Supply Quickly. Please Wait',false,true,130)
			end
			else
			FreezeEntityPosition(PlayerPedId(),false)
			rusupplyaheld = 0
			end
			-- ReHealth
			if IsControlPressed(0,167) and rusupplyhheld > 260 then
			  busy = true
			  SetEntityHealth(PlayerPedId(),200)
			  ESX.ShowNotification('~g~ Health Refilled',false,true,130)
			  rusupplyhheld = 0
		    end
		    if IsControlPressed(0,167) then
			if not busy then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?
			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen
			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle
			DisableControlAction(2, 36, true) -- Disable going stealth
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			
			 FreezeEntityPosition(PlayerPedId(),true)
			 local zarb = rusupplyrheld * 100
			 local taghsim = zarb / 260
			 local final = math.ceil(taghsim)
			 DrawGenericTextThisFrame()
             SetTextEntry("STRING")
             AddTextComponentString('~g~ PROGRESS: ' .. final .. '%~s~')
             DrawText(0.5, 0.8)
			 DisablePlayerFiring(PlayerId(),true)
			 
			 rusupplyhheld = rusupplyhheld + 1
			else
			ESX.ShowNotification('~r~ You are Using The Supply Quickly. Please Wait',false,true,130)
			end
			else
			FreezeEntityPosition(PlayerPedId(),false)
			rusupplyhheld = 0
			end
			
		   else
		   
		    rusupplyrheld = 0
            rusupplyaheld = 0
            rusupplyhheld = 0
			
		   end
		   
		 else
		 
		 
         end
	   end
     end
    end
  end
end  
  Citizen.Wait(0)
end
end)
--                                                 ENVIROMENT PART

-- Freeze TIme 
Citizen.CreateThread(function()
 while true do 
   if Config.FreezeTimeNight then
   NetworkOverrideClockTime(0,0,0)
   Citizen.Wait(0)
   else
   Citizen.Wait(0)
   end
 end
end)
--                                                  Hide Ai 
Citizen.CreateThread(function()
  while true do 
  if Config.HideAI then
  
  SetVehicleDensityMultiplierThisFrame(0.0)
  SetPedDensityMultiplierThisFrame(0.0);
  SetRandomVehicleDensityMultiplierThisFrame(0.0)
  SetParkedVehicleDensityMultiplierThisFrame(0.0)
  SetScenarioPedDensityMultiplierThisFrame(0.0,0.0)
  SetMaxWantedLevel(0);
  end
  Citizen.Wait(0)
  end
end)
--                                               PREVENT from Entering and riding wrong vehicle

Citizen.CreateThread(function()
if Config.RestrictVehicle then
  while ESX == nil do 
  Wait(10)
  end
  while PlayerData.job == nil do
  Wait(10)
  end
  while true do 
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local ped = GetPlayerPed(-1)
    
	if (IsVehicleModel(vehicle,GetHashKey('brickade')) or IsVehicleModel(vehicle,GetHashKey('insurgent3')) or IsVehicleModel(vehicle,GetHashKey('rhino'))) and GetPedInVehicleSeat(vehicle,-1) == PlayerPedId() then
	   if PlayerData.job.name ~= 'usa' or PlayerData.job.grade ~= 5 then
       ESX.ShowNotification('~r~ You Can not Ride This Vehicle . You Need to Be ~g~ Ground Pilot ~r~ Division',false,true,120)	     
       TaskLeaveVehicle(ped,vehicle,0)
       end
   elseif (IsVehicleModel(vehicle,GetHashKey('hydra')) or IsVehicleModel(vehicle,GetHashKey('besra')) or IsVehicleModel(vehicle,GetHashKey('titan'))) and GetPedInVehicleSeat(vehicle,-1) == PlayerPedId() then
       
	   if PlayerData.job.name ~= 'usa' or (PlayerData.job.grade ~= 6 and PlayerData.job.grade ~= 8) then
       ESX.ShowNotification('~r~ You Can not Ride This Vehicle . You Need to Be ~g~ Aircraft Pilot ~r~ Division',false,true,120)	     
       TaskLeaveVehicle(ped,vehicle,0)
       end
   elseif (IsVehicleModel(vehicle,GetHashKey('strikeforce')) or IsVehicleModel(vehicle,GetHashKey('lazer')) or IsVehicleModel(vehicle,GetHashKey('savage')) or IsVehicleModel(vehicle,GetHashKey('cargobob'))) and GetPedInVehicleSeat(vehicle,-1) == PlayerPedId() then
      
	  if PlayerData.job.name ~= 'russia' or (PlayerData.job.grade ~= 6 and PlayerData.job.grade ~= 8) then
       ESX.ShowNotification('~r~ You Can not Ride This Vehicle . You Need to Be ~g~ Aircraft Pilot ~r~ Division',false,true,120)	     
       TaskLeaveVehicle(ped,vehicle,0)
       end
   elseif IsVehicleModel(vehicle,GetHashKey('dinghy4')) and GetPedInVehicleSeat(vehicle,-1) == PlayerPedId() then
       if PlayerData.job.name ~= 'russia' or PlayerData.job.grade ~= 5 then
       ESX.ShowNotification('~r~ You Can not Ride This Vehicle . You Need to Be ~g~ Speed Boat Pilot ~r~ Division',false,true,120)	     
       TaskLeaveVehicle(ped,vehicle,0)
       end
	   
   elseif vehicle ~= 0 then
       ESX.ShowNotification('~y~ UNKNOWN VEHICLE',false,true,120)	     
       TaskLeaveVehicle(ped,vehicle,0)
	   DeleteEntity(vehicle)
   end






   Citizen.Wait(100)
 end
end
end)

--                                                  Compass

-- DrawText method wrapper, draws text to the screen.
-- @param1	string	The text to draw
-- @param2	float	Screen x-axis coordinate
-- @param3	float	Screen y-axis coordinate
-- @param4	table	Optional. Styles to apply to the text
-- @return
function drawText( str, x, y, style )
	if style == nil then
		style = {}
	end
	
	SetTextFont( (style.font ~= nil) and style.font or 0 )
	SetTextScale( 0.0, (style.size ~= nil) and style.size or 1.0 )
	SetTextProportional( 1 )
	
	if style.colour ~= nil then
		SetTextColour( style.colour.r ~= nil and style.colour.r or 255, style.colour.g ~= nil and style.colour.g or 255, style.colour.b ~= nil and style.colour.b or 255, style.colour.a ~= nil and style.colour.a or 255 )
	else
		SetTextColour( 255, 255, 255, 255 )
	end
	
	if style.shadow ~= nil then
		SetTextDropShadow( style.shadow.distance ~= nil and style.shadow.distance or 0, style.shadow.r ~= nil and style.shadow.r or 0, style.shadow.g ~= nil and style.shadow.g or 0, style.shadow.b ~= nil and style.shadow.b or 0, style.shadow.a ~= nil and style.shadow.a or 255 )
	else
		SetTextDropShadow( 0, 0, 0, 0, 255 )
	end
	
	if style.border ~= nil then
		SetTextEdge( style.border.size ~= nil and style.border.size or 1, style.border.r ~= nil and style.border.r or 0, style.border.g ~= nil and style.border.g or 0, style.border.b ~= nil and style.border.b or 0, style.border.a ~= nil and style.shadow.a or 255 )
	end
	
	if style.centered ~= nil and style.centered == true then
		SetTextCentre( true )
	end
	
	if style.outline ~= nil and style.outline == true then
		SetTextOutline()
	end
	
	SetTextEntry( "STRING" )
	AddTextComponentString( str )
	
	DrawText( x, y )
end

-- Converts degrees to (inter)cardinal directions.
-- @param1	float	Degrees. Expects EAST to be 90° and WEST to be 270°.
-- 					In GTA, WEST is usually 90°, EAST is usually 270°. To convert, subtract that value from 360.
--
-- @return			The converted (inter)cardinal direction.
function degreesToIntercardinalDirection( dgr )
	dgr = dgr % 360.0
	
	if (dgr >= 0.0 and dgr < 22.5) or dgr >= 337.5 then
		return "N "
	elseif dgr >= 22.5 and dgr < 67.5 then
		return "NE"
	elseif dgr >= 67.5 and dgr < 112.5 then
		return "E"
	elseif dgr >= 112.5 and dgr < 157.5 then
		return "SE"
	elseif dgr >= 157.5 and dgr < 202.5 then
		return "S"
	elseif dgr >= 202.5 and dgr < 247.5 then
		return "SW"
	elseif dgr >= 247.5 and dgr < 292.5 then
		return "W"
	elseif dgr >= 292.5 and dgr < 337.5 then
		return "NW"
	end
end


local streetName = {}

-- Configuration. Please be careful when editing. It does not check for errors.
streetName.show = true
streetName.position = {x = 0.5, y = 0.02, centered = true}
streetName.textSize = 0.35
streetName.textColour = {r = 128, g = 128, b = 128, a = 200}
-- End of configuration


Citizen.CreateThread( function()
  if Config.EnableCompass then
	local lastStreetA = 0
	local lastStreetB = 0
	local lastStreetName = {}
	
	while streetName.show do
		Wait( 0 )
		
		local playerPos = GetEntityCoords( GetPlayerPed( -1 ), true )
		local streetA, streetB = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, playerPos.x, playerPos.y, playerPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
		local street = {}
		
		if not ((streetA == lastStreetA or streetA == lastStreetB) and (streetB == lastStreetA or streetB == lastStreetB)) then
			-- Ignores the switcharoo while doing circles on intersections
			lastStreetA = streetA
			lastStreetB = streetB
		end
		
		if lastStreetA ~= 0 then
			table.insert( street, GetStreetNameFromHashKey( lastStreetA ) )
		end
		
		if lastStreetB ~= 0 then
			table.insert( street, GetStreetNameFromHashKey( lastStreetB ) )
		end
		
		drawText( table.concat( street, " & " ), streetName.position.x, streetName.position.y, {
			size = streetName.textSize,
			colour = streetName.textColour,
			outline = true,
			centered = streetName.position.centered
		})
	end
	end
end)

local compass = { cardinal={}, intercardinal={}}

-- Configuration. Please be careful when editing. It does not check for errors.
compass.show = true
compass.position = {x = 0.5, y = 0.07, centered = true}
compass.width = 0.25
compass.fov = 180
compass.followGameplayCam = true

compass.ticksBetweenCardinals = 9.0
compass.tickColour = {r = 255, g = 255, b = 255, a = 200}
compass.tickSize = {w = 0.001, h = 0.003}

compass.cardinal.textSize = 0.45
compass.cardinal.textOffset = 0.015
compass.cardinal.textColour = {r = 255, g = 51, b = 0, a = 200}

compass.cardinal.tickShow = true
compass.cardinal.tickSize = {w = 0.001, h = 0.012}
compass.cardinal.tickColour = {r = 255, g = 255, b = 0, a = 200}

compass.intercardinal.show = true
compass.intercardinal.textShow = true
compass.intercardinal.textSize = 0.35
compass.intercardinal.textOffset = 0.015
compass.intercardinal.textColour = {r = 51, g = 204, b = 255, a = 200}

compass.intercardinal.tickShow = true
compass.intercardinal.tickSize = {w = 0.001, h = 0.006}
compass.intercardinal.tickColour = {r = 255, g = 255, b = 0, a = 200}
-- End of configuration


Citizen.CreateThread( function()
	if compass.position.centered then
		compass.position.x = compass.position.x - compass.width / 2
	end
   if Config.EnableCompass then
	while compass.show do
		Wait( 0 )
		
		local pxDegree = compass.width / compass.fov
		local playerHeadingDegrees = 0
		
		if compass.followGameplayCam then
			-- Converts [-180, 180] to [0, 360] where E = 90 and W = 270
			local camRot = Citizen.InvokeNative( 0x837765A25378F0BB, 0, Citizen.ResultAsVector() )
			playerHeadingDegrees = 360.0 - ((camRot.z + 360.0) % 360.0)
		else
			-- Converts E = 270 to E = 90
			playerHeadingDegrees = 360.0 - GetEntityHeading( GetPlayerPed( -1 ) )
		end
		
		local tickDegree = playerHeadingDegrees - compass.fov / 2
		local tickDegreeRemainder = compass.ticksBetweenCardinals - (tickDegree % compass.ticksBetweenCardinals)
		local tickPosition = compass.position.x + tickDegreeRemainder * pxDegree
		
		tickDegree = tickDegree + tickDegreeRemainder
		
		while tickPosition < compass.position.x + compass.width do
			if (tickDegree % 90.0) == 0 then
				-- Draw cardinal
				if compass.cardinal.tickShow then
					DrawRect( tickPosition, compass.position.y, compass.cardinal.tickSize.w, compass.cardinal.tickSize.h, compass.cardinal.tickColour.r, compass.cardinal.tickColour.g, compass.cardinal.tickColour.b, compass.cardinal.tickColour.a )
				end
				
				drawText( degreesToIntercardinalDirection( tickDegree ), tickPosition, compass.position.y + compass.cardinal.textOffset, {
					size = compass.cardinal.textSize,
					colour = compass.cardinal.textColour,
					outline = true,
					centered = true
				})
			elseif (tickDegree % 45.0) == 0 and compass.intercardinal.show then
				-- Draw intercardinal
				if compass.intercardinal.tickShow then
					DrawRect( tickPosition, compass.position.y, compass.intercardinal.tickSize.w, compass.intercardinal.tickSize.h, compass.intercardinal.tickColour.r, compass.intercardinal.tickColour.g, compass.intercardinal.tickColour.b, compass.intercardinal.tickColour.a )
				end
				
				if compass.intercardinal.textShow then
					drawText( degreesToIntercardinalDirection( tickDegree ), tickPosition, compass.position.y + compass.intercardinal.textOffset, {
						size = compass.intercardinal.textSize,
						colour = compass.intercardinal.textColour,
						outline = true,
						centered = true
					})
				end
			else
				-- Draw tick
				DrawRect( tickPosition, compass.position.y, compass.tickSize.w, compass.tickSize.h, compass.tickColour.r, compass.tickColour.g, compass.tickColour.b, compass.tickColour.a )
			end
			
			-- Advance to the next tick
			tickDegree = tickDegree + compass.ticksBetweenCardinals
			tickPosition = tickPosition + pxDegree * compass.ticksBetweenCardinals
		end
	end
  end
end)
-- WEAPON DAMAGES

Citizen.CreateThread(function()
while true do
 if Config.CustomDamageMultipilier then
      N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), Config.WeaponDamage.UnArmed)
	  N_0x4757f00bc6323cfe(GetHashKey("WEAPON_COMBATPISTOL"), Config.WeaponDamage.CombatPistol)
	  N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SPECIALCARBINE"), Config.WeaponDamage.SpecialCarbine)
	  N_0x4757f00bc6323cfe(GetHashKey("WEAPON_RPG"), Config.WeaponDamage.RPG)
	  N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SMG"), Config.WeaponDamage.SMG)
	  N_0x4757f00bc6323cfe(GetHashKey("WEAPON_CARBINERIFLE"), Config.WeaponDamage.CarbineRifle)
	  N_0x4757f00bc6323cfe(GetHashKey("WEAPON_MARKSMANRIFLE"), Config.WeaponDamage.Sniper)
	  N_0x4757f00bc6323cfe(GetHashKey("WEAPON_ASSAULTSHOTGUN"), Config.WeaponDamage.Shotgun)
	  N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SMOKEGRENADE"), Config.WeaponDamage.SmokeGrenade)
 end
Citizen.Wait(0)
end
end)

Citizen.CreateThread(function()
if Config.DisableMeleeAttack then
while true do 
SetPlayerTargetingMode(1)
DisableControlAction(0,140,true)
DisableControlAction(0,141,true)




Citizen.Wait(0)
end
end
end)



-- RECOIL System

Citizen.CreateThread(function()
 if Config.EnableRecoil then
    while true do 
	if not IsPedInAnyVehicle(PlayerPedId()) then
     if IsPedShooting(PlayerPedId()) and not IsPedDoingDriveby(PlayerPedId()) then
        
        local multi = 1.0
		local cover = IsPedInCover(PlayerPedId(),false)
		local walking = IsPedRunning(PlayerPedId())
		local sprinting = IsPedSprinting(PlayerPedId())
		if walking then
        multi = Config.WalkingRecoilMultiplier
        end
        if sprinting then
        multi = Config.SprintRecoilMultiplier
        end
        if proned then
        multi = Config.ProneRecoilMultiplier
        end		
		if cover then
		multi = Config.CoverMultiplier
	--	print('set to cover')
		end
		if IsPlayerFreeAiming(PlayerId()) then
		
		if multi > multi - Config.AimingRecoilDecrease then multi = multi - Config.AimingRecoilDecrease end
		
		end
		
        local result,weapon = GetCurrentPedWeapon(PlayerPedId(),true)
		if weapon == GetHashKey('WEAPON_COMBATPISTOL') then
 
        p = GetGameplayCamRelativePitch()
		SetGameplayCamRelativePitch(p + Config.WeaponRecoil.CombatPistol * multi, 0.2)
	
        elseif weapon ==  GetHashKey('WEAPON_ASSAULTSHOTGUN') then
		
		p = GetGameplayCamRelativePitch()
        SetGameplayCamRelativePitch(p + Config.WeaponRecoil.Shotgun * multi, 0.2)
		
		elseif weapon == GetHashKey('WEAPON_CARBINERIFLE') then
		
		p = GetGameplayCamRelativePitch()
        SetGameplayCamRelativePitch(p + Config.WeaponRecoil.CarbineRifle * multi, 0.2)
		
		elseif weapon == GetHashKey('WEAPON_MARKSMANRIFLE') then
		
		p = GetGameplayCamRelativePitch()
        SetGameplayCamRelativePitch(p + Config.WeaponRecoil.Sniper * multi, 0.2)
		
		elseif weapon == GetHashKey('WEAPON_RPG') then
		
		p = GetGameplayCamRelativePitch()
        SetGameplayCamRelativePitch(p + Config.WeaponRecoil.RPG * multi, 0.2)
		
		elseif weapon == GetHashKey('WEAPON_SMG') then
		
		p = GetGameplayCamRelativePitch()
        SetGameplayCamRelativePitch(p + Config.WeaponRecoil.SMG * multi, 0.2)
		
		elseif weapon == GetHashKey('WEAPON_SPECIALCARBINE') then
		
		p = GetGameplayCamRelativePitch()
        SetGameplayCamRelativePitch(p + Config.WeaponRecoil.SpecialCarbine * multi, 0.2)
		
		elseif weapon == GetHashKey('WEAPON_GRENADE') then
		
		p = GetGameplayCamRelativePitch()
        SetGameplayCamRelativePitch(p + Config.WeaponRecoil.Grenade * multi, 0.2)
		
		
		elseif weapon == GetHashKey('WEAPON_KNIFE') then
		
		elseif weapon == GetHashKey('WEAPON_UNARMED') then
		
		elseif weapon == GetHashKey('WEAPON_FLAREGUN') then
		p = GetGameplayCamRelativePitch()
        SetGameplayCamRelativePitch(p + Config.WeaponRecoil.FlareGun * multi, 0.2)
		
		elseif weapon == GetHashKey('WEAPON_SMOKEGRENADE') then
		
		p = GetGameplayCamRelativePitch()
        SetGameplayCamRelativePitch(p + Config.WeaponRecoil.Grenade * multi, 0.2)
		
		
		elseif weapon == GetHashKey('WEAPON_PROXMINE') then
		
		p = GetGameplayCamRelativePitch()
        SetGameplayCamRelativePitch(p + Config.WeaponRecoil.Grenade * multi, 0.2)
		
		
		else
		
		p = GetGameplayCamRelativePitch()
        SetGameplayCamRelativePitch(p + Config.WeaponRecoil.OtherGuns * multi, 0.2)
		
		end
     end 
    end
	if IsPedInAnyVehicle(PlayerPedId()) then
	local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
	if GetEntityModel(vehicle) == GetHashKey('insurgent3') then
	
	if IsPedShooting(PlayerPedId()) and not IsPedDoingDriveby(PlayerPedId()) then
	
	p = GetGameplayCamRelativePitch()
    SetGameplayCamRelativePitch(p + Config.WeaponRecoil.InsurgentMinigun, 0.2)
	
	end
	end
	end
     Citizen.Wait(0)
    end
 end
end)
-- CAPTURE variablels
CurrentCapture = {}
CurrentCapture.loc = nil
CurrentCapture.WaitTimerStarted = false
CurrentCapture.FirstWaitTimer = false
CurrentCapture.WaitTimer = 0
CurrentCapture.GameStarted = false
CurrentCapture.FirstGameTimer = false
CurrentCapture.GameTimer = 0
CurrentCapture.BlipID = 0
CurrentCapture.RussiaPoint = 0
CurrentCapture.UsaPoint = 0

--
--                                                                CAPTURE PART
function CheckTheCurrentGame()
Citizen.CreateThread(function()
ESX.TriggerServerCallback('Cyber:CheckCurrentGame',function(data)

CurrentCapture.loc = data.loc
CurrentCapture.WaitTimerStarted = data.WaitTimerStarted
CurrentCapture.FirstWaitTimer = data.FirstWaitTimer
CurrentCapture.WaitTimer = data.WaitTimer
CurrentCapture.GameStarted = data.GameStarted
CurrentCapture.FirstGameTimer = data.FirstGameTimer
CurrentCapture.GameTimer = data.GameTimer
CurrentCapture.RussiaPoint = data.RussiaPoint
CurrentCapture.UsaPoint = data.UsaPoint
if CurrentCapture.loc and CurrentCapture.GameStarted then
if data.BlipStatus == nil then

UpdateCaptureBlip('none',CurrentCapture.loc)

else

UpdateCaptureBlip(data.BlipStatus,CurrentCapture.loc)

end
end

end)
end)
end
-- First Launch    WAITING PART
RegisterNetEvent('Cyber:StartWaiting')
AddEventHandler('Cyber:StartWaiting', function(timer)
if not CurrentCapture.WaitTimerStarted and not CurrentCapture.GameStarted then
Citizen.CreateThread(function()
for k,v in pairs(ESX.Game.GetVehicles()) do
DeleteEntity(v)
end
    if PlayerData.job.name == 'usa' then
    FreezeEntityPosition(PlayerPedId(),true)
    ESX.Game.Teleport(PlayerPedId(), Config.USABASE.respawn, function()
     
    end)
    while not HasCollisionLoadedAroundEntity(PlayerPedId()) do 
	Citizen.Wait(10)
	end
	Citizen.Wait(5000)
    FreezeEntityPosition(PlayerPedId(),false)
   elseif PlayerData.job.name == 'russia' then
    FreezeEntityPosition(PlayerPedId(),true)
    ESX.Game.Teleport(PlayerPedId(), Config.RUSSIABASE.respawn, function()
     
    end)
    while not HasCollisionLoadedAroundEntity(PlayerPedId()) do 
	Citizen.Wait(10)
	end
	Citizen.Wait(5000)
    FreezeEntityPosition(PlayerPedId(),false)
    end
end)
if not CurrentCapture.FirstWaitTimer then
ShowGameIsStartingNotific(timer)
CurrentCapture.FirstWaitTimer = true 
end
CurrentCapture.WaitTimer = timer
CurrentCapture.WaitTimerStarted = true

end
end)
RegisterNetEvent('Cyber:TimeWaiting')
AddEventHandler('Cyber:TimeWaiting', function(timer)
if CurrentCapture.WaitTimerStarted then
CurrentCapture.WaitTimer = timer
end
end)

Citizen.CreateThread(function()
while true do 
if CurrentCapture.WaitTimerStarted then

            SetTextFont(4)
	        SetTextScale(0.0, 0.7)
	        SetTextColour(255, 255, 255, 255)
	        SetTextDropshadow(0, 0, 0, 0, 255)
	        SetTextDropShadow()
	        SetTextOutline()
         	SetTextCentre(true)
			SetTextEntry("STRING")
			AddTextComponentString('Match ~g~Starts~s~ In :' .. '[~y~' .. CurrentCapture.WaitTimer .. '~s~]' .. ' ~h~Second')
			DrawText(0.10, 0.73)
	


end
Citizen.Wait(0)	
end
end)

function ShowGameIsStartingNotific(timer)
PlaySoundFrontend(-1, "ScreenFlash", "MissionFailedSounds", false)
Citizen.CreateThread(function()
   ESX.Scaleform.ShowFreemodeMessage('CAPTURE','Match Starts In :' .. tostring(timer) .. 's',1.0)
end)

end

RegisterNetEvent('Cyber:StartMatch')
AddEventHandler('Cyber:StartMatch', function(timer,russiapoint,usapoint)
CurrentCapture.WaitTimerStarted = false
CurrentCapture.FirstWaitTimer = false
CurrentCapture.WaitTimer = 0
if not CurrentCapture.FirstGameTimer then
ShowGameStartedNotific(timer)
CurrentCapture.FirstGameTimer = true

end
CurrentCapture.GameTimer = timer
CurrentCapture.UsaPoint = usapoint
CurrentCapture.RussiaPoint = russiapoint
CurrentCapture.GameStarted = true

end)
function ShowGameStartedNotific(timer)
PlaySoundFrontend(-1, "ScreenFlash", "MissionFailedSounds", false)
Citizen.CreateThread(function()
    ESX.Scaleform.ShowFreemodeMessage('Match Started','CYBER SYSTEM',1.0)
end)
end


RegisterNetEvent('Cyber:UpdateMarkers')
AddEventHandler('Cyber:UpdateMarkers', function(point,status)
CurrentCapture.loc = point

if status == nil then

UpdateCaptureBlip('none',point)

else

UpdateCaptureBlip(status,point)

end


end)


function UpdateCaptureBlip(stat,capturepoint)
             RemoveBlip(CurrentCapture.BlipID)
             local blip  = AddBlipForCoord(capturepoint)
			 SetBlipSprite(blip, Config.CapturePointBlipSprite)
		     SetBlipScale(blip, 1.85) -- set scale
			 if stat == 'none' then
		     SetBlipColour(blip,40)
			 elseif stat == 'russia' then
			 SetBlipColour(blip,6)
			 elseif stat == 'usa' then
			 SetBlipColour(blip,12)
			 else
			 print('UNKNOWN BLIP STAT')
			 end
			 BeginTextCommandSetBlipName('STRING')
             AddTextComponentString('Capture Point')
             EndTextCommandSetBlipName(blip)
             CurrentCapture.BlipID = blip
end

Citizen.CreateThread(function()
while true do 
if CurrentCapture.GameStarted and CurrentCapture.loc ~= nil then
DrawMarker(Config.CapturePointMarkerType, CurrentCapture.loc.x,CurrentCapture.loc.y,CurrentCapture.loc.z - 1.0, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0,10.5, 10.5, 1.0, 0, 255, 0, 150, false, true, 2, nil, nil, false)

end


Citizen.Wait(0)
end
end)
Citizen.CreateThread(function()
while true do
if CurrentCapture.GameStarted and CurrentCapture.loc ~= nil and Config.FreezeTimeNight then
local dist = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),CurrentCapture.loc)
if dist < Config.BlackOutDistance then
SetBlackout(true)
else
SetBlackout(false)
end
end
Citizen.Wait(0)
end
end)
RegisterNetEvent('GetDataFromClient')
AddEventHandler('GetDataFromClient', function(cb)
cb('hello')
end)

RegisterNetEvent('Cyber:TimeMatch')
AddEventHandler('Cyber:TimeMatch', function(timer,russiapoint,usapoint)
if CurrentCapture.GameStarted then
CurrentCapture.GameTimer = timer
CurrentCapture.UsaPoint = usapoint
CurrentCapture.RussiaPoint = russiapoint
end
end)

RegisterNetEvent('Cyber:EndMatch')
AddEventHandler('Cyber:EndMatch', function(whowon)
if CurrentCapture.GameStarted then
ShowEndScreen(whowon)
RemoveBlip(CurrentCapture.BlipID)
CurrentCapture.GameStarted = false
CurrentCapture.WaitTimerStarted = false
CurrentCapture.FirstWaitTimer = false
CurrentCapture.WaitTimer = 0
CurrentCapture.FirstGameTimer = false
CurrentCapture.GameTimer = 0
CurrentCapture.BlipID = 0
CurrentCapture.RussiaPoint = 0
CurrentCapture.UsaPoint = 0
--print('capture ended')

end
end)
function ShowEndScreen(won)
for k,v in pairs(ESX.Game.GetVehicles()) do
DeleteEntity(v)
end
PlaySoundFrontend(-1, "SHOOTING_RANGE_ROUND_OVER", "HUD_AWARDS", false)
Citizen.CreateThread(function()
CheckTheTeam()
end)

Citizen.CreateThread(function()
if won == 'russia' then
    ESX.Scaleform.ShowFreemodeMessage('Match Ended','RUSSIAN Army Won',10.0)

elseif won == 'usa' then
    ESX.Scaleform.ShowFreemodeMessage('Match Ended','USA Army Won',10.0)

elseif won == 'draw' then
    ESX.Scaleform.ShowFreemodeMessage('Match Ended','DRAW',10.0)

else
--print('unknown winner')
end

end)
end

Citizen.CreateThread(function()
while true do 
if CurrentCapture.GameStarted then
            if Config.ShowMatchTimeForPlayers then
            SetTextFont(4)
	        SetTextScale(0.0, 0.7)
	        SetTextColour(255, 255, 255, 255)
	        SetTextDropshadow(0, 0, 0, 0, 255)
	        SetTextDropShadow()
	        SetTextOutline()
         	SetTextCentre(true)
			SetTextEntry("STRING")
			AddTextComponentString('Match ~r~Ends~s~ in :' .. '[~y~' .. CurrentCapture.GameTimer .. '~s~] ' .. '~h~Second')
			DrawText(0.10, 0.73)
            end
			SetTextFont(4)
	        SetTextScale(0.0, 0.7)
	        SetTextColour(255, 255, 255, 255)
	        SetTextDropshadow(0, 0, 0, 0, 255)
	        SetTextDropShadow()
	        SetTextOutline()
         	SetTextCentre(true)
			SetTextEntry("STRING")
			AddTextComponentString('~b~USA~s~ : ' .. '[~b~' .. CurrentCapture.UsaPoint .. '~s~]')
			DrawText(0.34, 0.05)
			SetTextFont(4)
	        SetTextScale(0.0, 0.45)
	        SetTextColour(255, 255, 255, 255)
	        SetTextDropshadow(0, 0, 0, 0, 255)
	        SetTextDropShadow()
	        SetTextOutline()
         	SetTextCentre(true)
			SetTextEntry("STRING")
			AddTextComponentString('🇺🇸')
			DrawText(0.295, 0.05)
		    SetTextFont(4)
	        SetTextScale(0.0, 0.7)
	        SetTextColour(255, 255, 255, 255)
	        SetTextDropshadow(0, 0, 0, 0, 255)
	        SetTextDropShadow()
	        SetTextOutline()
         	SetTextCentre(true)
			SetTextEntry("STRING")
			AddTextComponentString('[~r~' .. CurrentCapture.RussiaPoint .. '~s~]' .. ': ~r~RUSSIA~s~')
			DrawText(0.67, 0.05)
		    SetTextFont(4)
	        SetTextScale(0.0, 0.45)
	        SetTextColour(255, 255, 255, 255)
	        SetTextDropshadow(0, 0, 0, 0, 255)
	        SetTextDropShadow()
	        SetTextOutline()
         	SetTextCentre(true)
			SetTextEntry("STRING")
			AddTextComponentString('🇷🇺')
			DrawText(0.715, 0.05)


end
Citizen.Wait(0)	
end
end)
-- Prevent People From Going out of the base if they are not supposed to
Citizen.CreateThread(function()
while PlayerData.job == nil do 
Citizen.Wait(10)
end
if Config.PreventFromGoing then
while true do 
if CurrentCapture.WaitTimerStarted then
if PlayerData.job.name == 'usa' then
local cords = GetEntityCoords(PlayerPedId())
local dist = GetDistanceBetweenCoords(cords,Config.USABASE.spawn)
if dist > Config.PreventDistance then
    local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
	if vehicle == nil then
	vehicle = 0
	end
	DeleteEntity(vehicle)
    FreezeEntityPosition(PlayerPedId(),true)
    ESX.Game.Teleport(PlayerPedId(), Config.USABASE.respawn, function()
     
    end)
    while not HasCollisionLoadedAroundEntity(PlayerPedId()) do 
	Citizen.Wait(10)
	end
	Citizen.Wait(5000)
    FreezeEntityPosition(PlayerPedId(),false)
    ESX.ShowNotification('~r~Game Is Not Started YET',false,true,120)

end

elseif PlayerData.job.name == 'russia' then
local cords = GetEntityCoords(PlayerPedId())
local dist = GetDistanceBetweenCoords(cords,Config.RUSSIABASE.spawn)
if dist > Config.PreventDistance then
    local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
	if vehicle == nil then
	vehicle = 0
	end
	DeleteEntity(vehicle)

    FreezeEntityPosition(PlayerPedId(),true)
    ESX.Game.Teleport(PlayerPedId(), Config.RUSSIABASE.respawn, function()
     
    end)
    while not HasCollisionLoadedAroundEntity(PlayerPedId()) do 
	Citizen.Wait(10)
	end
	Citizen.Wait(5000)
    FreezeEntityPosition(PlayerPedId(),false)
    ESX.ShowNotification('~r~Game Is Not Started YET',false,true,120)


end

end
end 


if CurrentCapture.GameStarted then

if PlayerData.job.name == 'usa' then

local cords = GetEntityCoords(PlayerPedId())
local dist = GetDistanceBetweenCoords(cords,Config.RUSSIABASE.spawn)
if dist < Config.PreventDistance then
   
    local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
	if vehicle == nil then
	vehicle = 0
	end
	DeleteEntity(vehicle)
    FreezeEntityPosition(PlayerPedId(),true)
    ESX.Game.Teleport(PlayerPedId(), Config.USABASE.respawn, function()
     
    end)
    while not HasCollisionLoadedAroundEntity(PlayerPedId()) do 
	Citizen.Wait(10)
	end
	Citizen.Wait(5000)
    FreezeEntityPosition(PlayerPedId(),false)
    ESX.ShowNotification('~r~You Entered Enemy Base',false,true,120)

end


elseif PlayerData.job.name == 'russia' then

local cords = GetEntityCoords(PlayerPedId())
local dist = GetDistanceBetweenCoords(cords,Config.USABASE.spawn)
if dist < Config.PreventDistance then

    local vehicle = GetVehiclePedIsIn(PlayerPedId(),false)
	if vehicle == nil then
	vehicle = 0
	end
	DeleteEntity(vehicle)
    FreezeEntityPosition(PlayerPedId(),true)
    ESX.Game.Teleport(PlayerPedId(), Config.RUSSIABASE.respawn, function()
     
    end)
    while not HasCollisionLoadedAroundEntity(PlayerPedId()) do 
	Citizen.Wait(10)
	end
	Citizen.Wait(5000)
    FreezeEntityPosition(PlayerPedId(),false)
    ESX.ShowNotification('~r~You Entered Enemy Base',false,true,120)
end


end
end
Citizen.Wait(0)
end
end
end)
-- Show Name Above Head
function DrawText3D(x,y,z, text, r,g,b) 
    local showing,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px,py,pz)-vector3(x,y,z))
 
    local andaze = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local andaze = andaze*fov
   
    if showing then
        SetTextScale(0.0*andaze,Config.NameSize *andaze)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
Tags = {}
local TeamNames = {}
Citizen.CreateThread(function()
if Config.ShowNameAboveHead then
            while PlayerData.job == nil do
            Wait(10)
            end
			
			
			
			
			
      while true do  
  
	--table.insert(TeamNames,{id = PlayerId(),team = 'russia'})  
   for i,v in pairs(idRUSSIA) do
   if not TeamNames[v] then
   table.insert(TeamNames,{id = v,team = 'russia'})
   end
   end   
   for i,v in pairs(idUSA) do
   if not TeamNames[v] then
   table.insert(TeamNames,{id = v,team = 'usa'})
   end
   end   
if PlayerData.job.name == 'russia' then

for k,v in pairs(TeamNames) do

 if v.team == 'russia' then
    if NetworkIsPlayerActive(v.id)then
	
     local ped = GetPlayerPed(v.id)
     dist = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(PlayerPedId()))
	 if dist < Config.DistanceForName then
    if not Tags[v.id] or Tags[v.id].ped ~= ped then
	
      local nameTag = ('%s [%d]'):format(GetPlayerName(v.id), GetPlayerServerId(v.id))
	  local sds = CreateFakeMpGamerTag(GetPlayerPed(v.id), nameTag, false, false, '', 255, 0, 0, 0)
      Tags[v.id] = {
       tag = sds,
        ped = ped
      }
	 SetMpGamerTagColour(Tags[v.id].tag,0,27)
	-- 27 red
	-- 26 blue 
	  SetMpGamerTagVisibility(Tags[v.id].tag, 2, true)
    end

	elseif Tags[v.id] then
	
	RemoveMpGamerTag(Tags[v.id].tag)
	Tags[v.id] = nil
	end
  elseif Tags[v.id] then
    RemoveMpGamerTag(Tags[v.id].tag)

    Tags[v.id] = nil
  end

 elseif v.team == 'usa' then
  
  
  if NetworkIsPlayerActive(v.id)then
     local ped = GetPlayerPed(v.id)
     dist = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(PlayerPedId()))
	 if dist < Config.DistanceForName and HasEntityClearLosToEntityInFront(PlayerPedId(),ped) then
    if not Tags[v.id] or Tags[v.id].ped ~= ped then
      local nameTag = ('%s [%d]'):format(GetPlayerName(v.id), GetPlayerServerId(v.id))
      Tags[v.id] = {
        tag = CreateFakeMpGamerTag(GetPlayerPed(v.id), nameTag, false, false, '', 0, 0, 255, 0),
        ped = ped
      }
	  SetMpGamerTagColour(Tags[v.id].tag,0,26)
	  SetMpGamerTagVisibility(Tags[v.id].tag, 2, true)
    end

	elseif Tags[v.id] then
	
	RemoveMpGamerTag(Tags[v.id].tag)
	Tags[v.id] = nil
	end
  elseif Tags[v.id] then
    RemoveMpGamerTag(Tags[v.id].tag)

    Tags[v.id] = nil
  end
  
	  
 end
end

elseif PlayerData.job.name == 'usa' then

for k,v in pairs(TeamNames) do

 if v.team == 'usa' then

    if NetworkIsPlayerActive(v.id)then

     local ped = GetPlayerPed(v.id)
     dist = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(PlayerPedId()))
	 if dist < Config.DistanceForName then
    if not Tags[v.id] or Tags[v.id].ped ~= ped then
      local nameTag = ('%s [%d]'):format(GetPlayerName(v.id), GetPlayerServerId(v.id))
      Tags[v.id] = {
        tag = CreateFakeMpGamerTag(GetPlayerPed(v.id), nameTag, false, false, '', 0, 0, 255, 0),
        ped = ped
      }
	  SetMpGamerTagColour(Tags[v.id].tag,0,26)
	  SetMpGamerTagVisibility(Tags[v.id].tag, 2, true)
    end

	elseif Tags[v.id] then
	
	RemoveMpGamerTag(Tags[v.id].tag)
	Tags[v.id] = nil
	end
  elseif Tags[v.id] then
    RemoveMpGamerTag(Tags[v.id].tag)

    Tags[v.id] = nil
  end

 elseif v.team == 'russia' then
  
  
  if NetworkIsPlayerActive(v.id)then
     local ped = GetPlayerPed(v.id)
     dist = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(PlayerPedId()))
	 if dist < Config.DistanceForName and HasEntityClearLosToEntityInFront(PlayerPedId(),ped) then
    if not Tags[v.id] or Tags[v.id].ped ~= ped then
      local nameTag = ('%s [%d]'):format(GetPlayerName(v.id), GetPlayerServerId(v.id))
      Tags[v.id] = {
        tag = CreateFakeMpGamerTag(GetPlayerPed(v.id), nameTag, false, false, '', 255, 0, 0, 0),
        ped = ped
      }
	  SetMpGamerTagColour(Tags[v.id].tag,0,27)
	  SetMpGamerTagVisibility(Tags[v.id].tag, 2, true)
    end

	elseif Tags[v.id] then
	
	RemoveMpGamerTag(Tags[v.id].tag)
	Tags[v.id] = nil
	end
  elseif Tags[v.id] then
    RemoveMpGamerTag(Tags[v.id].tag)

    Tags[v.id] = nil
  end
  
	  
 end
end
end




    Citizen.Wait(500)
end
end
end)
-- Request SUpport Part

Citizen.CreateThread(function()
while ESX == nil do 
Wait(10)
end
while true do
if IsControlJustPressed(0,Config.LocalSupportCallc) and not ESX.UI.Menu.IsOpen('default',GetCurrentResourceName(),'cyber_local_support') then
ESX.UI.Menu.CloseAll()
OpenLocalSupportMenu()
end
if IsControlJustPressed(0,Config.GlobalSupportRequestc) and not ESX.UI.Menu.IsOpen('default',GetCurrentResourceName(),'cyber_global_support') and not IsControlPressed(0,21) then
ESX.UI.Menu.CloseAll()
OpenGlobalSupportMenu()
end
if ESX.UI.Menu.IsOpen('default',GetCurrentResourceName(),'cyber_global_support') then
DisableControlAction(0,157,true) -- 1
DisableControlAction(0,158,true) -- 2 
DisableControlAction(0,160,true) -- 3
DisableControlAction(0,164,true) -- 4
DisableControlAction(0,165,true) -- 5
if IsDisabledControlJustPressed(0,157) then

      TriggerServerEvent('Cyber:RequestGlobalSupport','bombard')
	  ESX.ShowNotification('Request Sended')
	  ESX.UI.Menu.CloseAll()

elseif IsDisabledControlJustPressed(0,158) then

          TriggerServerEvent('Cyber:RequestGlobalSupport','supply')
	  ESX.ShowNotification('Request Sended')
	  ESX.UI.Menu.CloseAll()

elseif IsDisabledControlJustPressed(0,160) then
 
          TriggerServerEvent('Cyber:RequestGlobalSupport','ground')
	  ESX.ShowNotification('Request Sended')
	  ESX.UI.Menu.CloseAll()
   
elseif IsDisabledControlJustPressed(0,164) then

           TriggerServerEvent('Cyber:RequestGlobalSupport','transport')
	  ESX.ShowNotification('Request Sended')
	  ESX.UI.Menu.CloseAll()

elseif IsDisabledControlJustPressed(0,165) then



end


end
if ESX.UI.Menu.IsOpen('default',GetCurrentResourceName(),'cyber_local_support') then
DisableControlAction(0,157,true) -- 1
DisableControlAction(0,158,true) -- 2 
DisableControlAction(0,160,true) -- 3
DisableControlAction(0,164,true) -- 4
DisableControlAction(0,165,true) -- 5
if IsDisabledControlJustPressed(0,157) then

	local nplayers = {}
    for _,v in pairs(GetActivePlayers()) do
    
	   ped = GetPlayerPed(v)
	   local dist = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(PlayerPedId()))
	   if dist < Config.LocalSupportDistance  then
	   table.insert(nplayers,GetPlayerServerId(v))

	   end

   end

     TriggerServerEvent('Cyber:RequestLocalSupport',nplayers,'backup')
	 ESX.ShowNotification('Request Sended')
     ESX.UI.Menu.CloseAll()
elseif IsDisabledControlJustPressed(0,158) then

	local nplayers = {}
    for _,v in pairs(GetActivePlayers()) do
    
	   ped = GetPlayerPed(v)
	   local dist = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(PlayerPedId()))
	   if dist < Config.LocalSupportDistance  then
	   table.insert(nplayers,GetPlayerServerId(v))
 
	   end

   end

     TriggerServerEvent('Cyber:RequestLocalSupport',nplayers,'rushing')
	 ESX.ShowNotification('Request Sended')
	  ESX.UI.Menu.CloseAll()

elseif IsDisabledControlJustPressed(0,160) then
 
	local nplayers = {}
    for _,v in pairs(GetActivePlayers()) do
    
	   ped = GetPlayerPed(v)
	   local dist = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(PlayerPedId()))
	   if dist < Config.LocalSupportDistance  then
	   table.insert(nplayers,GetPlayerServerId(v))
	
	   end

   end

     TriggerServerEvent('Cyber:RequestLocalSupport',nplayers,'envehicle')
	 ESX.ShowNotification('Request Sended')
	  ESX.UI.Menu.CloseAll()
   
elseif IsDisabledControlJustPressed(0,164) then

	local nplayers = {}
    for _,v in pairs(GetActivePlayers()) do
    
	   ped = GetPlayerPed(v)
	   local dist = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(PlayerPedId()))
	   if dist < Config.LocalSupportDistance  then
	   table.insert(nplayers,GetPlayerServerId(v))
  
	   end

   end

     TriggerServerEvent('Cyber:RequestLocalSupport',nplayers,'capture')
	 ESX.ShowNotification('Request Sended')
	  ESX.UI.Menu.CloseAll()

elseif IsDisabledControlJustPressed(0,165) then
 
 	local nplayers = {}
    for _,v in pairs(GetActivePlayers()) do
    
	   ped = GetPlayerPed(v)
	   local dist = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(PlayerPedId()))
	   if dist < Config.LocalSupportDistance  then
	   table.insert(nplayers,GetPlayerServerId(v))
	 
	   end

   end

     TriggerServerEvent('Cyber:RequestLocalSupport',nplayers,'enemy')
	 ESX.ShowNotification('Request Sended')
	 ESX.UI.Menu.CloseAll()


end


end

Wait(0)
end
end)



function OpenGlobalSupportMenu()
   local elements = {
    {label = '1. Request Aircraft Bombard',value = 'bombard'},
	{label = '2. Request Supply Delivery',value = 'supply'},
	{label = '3. Request Ground Units Backup',value = 'ground'},
	{label = '4. Request Transport To Battle',value = 'transport'},
  }
  
  	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cyber_global_support', {
		title    = 'Request Global Support',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
      TriggerServerEvent('Cyber:RequestGlobalSupport',data.current.value)
	  ESX.ShowNotification('Request Sended')
	  menu.close()
	end, function(data, menu)
		menu.close()
	end)
end


function OpenLocalSupportMenu()
   local elements = {
    {label = '1. Request Backup',value = 'backup'},
	{label = '2. Rush To Enemy',value = 'rushing'},
	{label = '3. Destroy Enemy Vehicle',value = 'envehicle'},
	{label = '4. Going to Capture Point',value = 'capture'},
	{label = '5. Enemy Spotted',value = 'enemy'}
  }
  
  	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cyber_local_support', {
		title    = 'Request Local Support',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
    
	local nplayers = {}
    for _,v in pairs(GetActivePlayers()) do
    
	   ped = GetPlayerPed(v)
	   local dist = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(PlayerPedId()))
	   if dist < Config.LocalSupportDistance  then
	   table.insert(nplayers,GetPlayerServerId(v))
	 
	   end

   end
     TriggerServerEvent('Cyber:RequestLocalSupport',nplayers,data.current.value)
	 ESX.ShowNotification('Request Sended')
	 menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

function notification(title,subject,msg,color)
    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(PlayerPedId())
    ESX.ShowAdvancedNotification(title,subject,msg, mugshotStr, 1,true,true,color)
    UnregisterPedheadshot(mugshot)
end

RegisterNetEvent('Cyber:GetLocalSupport')
AddEventHandler('Cyber:GetLocalSupport',function(name,message)

notification(name,'Local Support',message,170)
PlaySoundFrontend(-1,"Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", false)

end)
RegisterNetEvent('Cyber:RequestGlobalSupport')
AddEventHandler('Cyber:RequestGlobalSupport',function(name,message)


notification(name,'Global Support',message,200)
PlaySoundFrontend(-1,"Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", false)


end)




-- CROUCH AND PRONE

Citizen.CreateThread(function()
while true do
  if crouched or proned then
   if GetFollowPedCamViewMode() ~= 1 then
   
     SetFollowPedCamViewMode(1)

   end
  end
Citizen.Wait(100)
end
end)
Citizen.CreateThread(function()
while true do
if proned then

  if IsControlJustPressed(0,44) then
  proned = false
  ClearPedSecondaryTask(PlayerPedId())
  
  end
 
 
  if IsPedShooting(PlayerPedId()) or IsPlayerFreeAiming(PlayerId()) then
  			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D
  end
end
Citizen.Wait(0)

end
end)


Citizen.CreateThread( function()
	while true do 
		Citizen.Wait( 1 )
		local ped = GetPlayerPed( -1 )
		if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
			ProneMovement()
			DisableControlAction( 0, Config.ProneKey, true ) 
			DisableControlAction( 0, Config.CrouchKey, true ) 
			if ( not IsPauseMenuActive() ) then 
				if ( IsDisabledControlJustPressed( 0, Config.CrouchKey ) and not proned ) then 
					RequestAnimSet( "move_ped_crouched" )
					RequestAnimSet("MOVE_M@TOUGH_GUY@")
					
					while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
						Citizen.Wait( 100 )
					end 
					while ( not HasAnimSetLoaded( "MOVE_M@TOUGH_GUY@" ) ) do 
						Citizen.Wait( 100 )
					end 		
					if ( crouched and not proned ) then 
						ResetPedMovementClipset( ped )
						ResetPedStrafeClipset(ped)
						SetPedMovementClipset( ped,"MOVE_M@TOUGH_GUY@", 0.5)
						crouched = false 
					elseif ( not crouched and not proned ) then
						SetPedMovementClipset( ped, "move_ped_crouched", 0.55 )
						SetPedStrafeClipset(ped, "move_ped_crouched_strafing")
						crouched = true 
					end 
				elseif ( IsDisabledControlJustPressed(0, Config.ProneKey) and not crouched and not IsPedInAnyVehicle(ped, true) and not IsPedFalling(ped) and not IsPedDiving(ped) and not IsPedInCover(ped, false) and not IsPedInParachuteFreeFall(ped) and (GetPedParachuteState(ped) == 0 or GetPedParachuteState(ped) == -1) ) then
					if proned then
						ClearPedTasksImmediately(ped)
						proned = false
					elseif not proned then
						RequestAnimSet( "move_crawl" )
						while ( not HasAnimSetLoaded( "move_crawl" ) ) do 
							Citizen.Wait( 100 )
						end 
						ClearPedTasksImmediately(ped)
						proned = true
						if IsPedSprinting(ped) or IsPedRunning(ped) or GetEntitySpeed(ped) > 5 then
							TaskPlayAnim(ped, "move_jump", "dive_start_run", 8.0, 1.0, -1, 0, 0.0, 0, 0, 0)
							Citizen.Wait(1000)
						end
						SetProned()
					end
				end
			end
		else
			proned = false
			crouched = false
		end
	end
end)

function SetProned()
	ped = PlayerPedId()
	ClearPedTasksImmediately(ped)
	TaskPlayAnimAdvanced(ped, "move_crawl", "onfront_fwd", GetEntityCoords(ped), 0.0, 0.0, GetEntityHeading(ped), 1.0, 1.0, 1.0, 46, 1.0, 0, 0)
end
function ProneMovement()
	if proned then
		ped = PlayerPedId()
		DisableControlAction(0, 23)
		if IsControlPressed(0, 32) or IsControlPressed(0, 33) then
			DisablePlayerFiring(ped, true)
		 elseif IsControlJustReleased(0, 32) or IsControlJustReleased(0, 33) then
		 	DisablePlayerFiring(ped, false)
		 end
		if IsControlJustPressed(0, 32) and not movefwd then
			movefwd = true
		    TaskPlayAnimAdvanced(ped, "move_crawl", "onfront_fwd", GetEntityCoords(ped), 1.0, 0.0, GetEntityHeading(ped), 1.0, 1.0, 1.0, 47, 1.0, 0, 0)
		elseif IsControlJustReleased(0, 32) and movefwd then
		    TaskPlayAnimAdvanced(ped, "move_crawl", "onfront_fwd", GetEntityCoords(ped), 1.0, 0.0, GetEntityHeading(ped), 1.0, 1.0, 1.0, 46, 1.0, 0, 0)
			movefwd = false
		end		
		if IsControlJustPressed(0, 33) and not movebwd then
			movebwd = true
		    TaskPlayAnimAdvanced(ped, "move_crawl", "onfront_bwd", GetEntityCoords(ped), 1.0, 0.0, GetEntityHeading(ped), 1.0, 1.0, 1.0, 47, 1.0, 0, 0)
		elseif IsControlJustReleased(0, 33) and movebwd then 
		    TaskPlayAnimAdvanced(ped, "move_crawl", "onfront_bwd", GetEntityCoords(ped), 1.0, 0.0, GetEntityHeading(ped), 1.0, 1.0, 1.0, 46, 1.0, 0, 0)
		    movebwd = false
		end
		if IsControlPressed(0, 34) then
			SetEntityHeading(ped, GetEntityHeading(ped)+2.0 )
		elseif IsControlPressed(0, 35) then
			SetEntityHeading(ped, GetEntityHeading(ped)-2.0 )
		end
	end
end





--                                                 RESPAWN WITH MEDKIT PART



RegisterNetEvent('Cyber:UpdateDeads')
AddEventHandler('Cyber:UpdateDeads',function(deads)

deadPlayers = deads

end)

RegisterNetEvent('Cyber:GetRevived')
AddEventHandler('Cyber:GetRevived',function()
DoScreenFadeOut(800)

while not IsScreenFadedOut() do
	Citizen.Wait(10)
end
RespawnPedInBattle()
StopScreenEffect('DeathFailOut')
DoScreenFadeIn(800)

end)

function RespawnPedInBattle()
    isDead = false
    coords = GetEntityCoords(PlayerPedId())
	heading = GetEntityHeading(PlayerPedId())
    SetEntityCoordsNoOffset(PlayerPedId(), coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	FreezeEntityPosition(PlayerPedId(),true)
	Citizen.Wait(5000)
	FreezeEntityPosition(PlayerPedId(),false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)
end


reviveHeld = 0
if Config.EnableMedKit then
Citizen.CreateThread(function()
  while true do
if not IsPedDeadOrDying(PlayerPedId(),true) then

  for _, id in pairs(GetActivePlayers()) do

    local sid = GetPlayerServerId(id)
	   if deadPlayers[sid] and id ~= PlayerId() then
	 
        local dist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(id)),GetEntityCoords(PlayerPedId()))
		if dist < Config.MedkitDistance then
		local cord = GetEntityCoords(GetPlayerPed(id))
		local finalcord = vector3(cord.x,cord.y,cord.z + 1.1)
        ESX.Game.Utils.DrawText3D(finalcord,'~y~ Hold ~s~ [~b~E~s~] ~y~ To Revive ~s~') 
        if IsControlPressed(0,38) and reviveHeld > 250 then
		print('revived')
		if medkit > 0 then
		reviveHeld = 0
		TriggerServerEvent('Cyber:RevivePlayer',sid)
		medkit = medkit - 1
		ESX.ShowNotification('~g~Shoma Ba Movafaghiyat Fard Ro Revive Kardid')
         -- revive
		else
		reviveHeld = 0
		ESX.ShowNotification('Shoma ~r~ MedKit ~s~ Nadarid')
		
        end
		end
        if IsControlPressed(0,38) then
		print('pressed')
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?
			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen
			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle
			DisableControlAction(2, 36, true) -- Disable going stealth
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee

	
			 local zarb = reviveHeld * 100
			 local taghsim = zarb / 250
			 local final = math.ceil(taghsim)
			 DrawGenericTextThisFrame()
             SetTextEntry("STRING")
             AddTextComponentString('~y~ Progress: ' .. final .. '%~s~')
             DrawText(0.5, 0.8)
			 DisablePlayerFiring(PlayerId(),true)
			 
			 reviveHeld = reviveHeld + 1
		
        else

        reviveHeld = 0
         
        end
      end
	 end
	end
  end 
Wait(0)
  end
 
end)
end




-- sounds
if Config.EnbaleCustomSound then
Citizen.CreateThread(function()
while ESX == nil do 
Wait(10)
end
while true do
 res,wep = GetCurrentPedWeapon(PlayerPedId(),true) 
  if IsPedShooting(PlayerPedId()) and wep == GetHashKey('WEAPON_FLASHBANG') then
  TriggerServerEvent('Server:SoundToClient', GetPlayerServerId(PlayerId()), 'flashbang', 0.3)
      if PlayerData.job.name == 'russia' then
  for _,id in pairs(idRUSSIA) do 
  
  dist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(id)),GetEntityCoords(PlayerPedId()))
  if dist < Config.LocalSoundRadius then
  
  TriggerServerEvent('Server:SoundToClient', GetPlayerServerId(id), 'flashbang', 0.3)
  
  end
  end
       elseif PlayerData.job.name == 'usa' then
  for _,id in pairs(idUSA) do 
  
dist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(id)),GetEntityCoords(PlayerPedId()))
  if dist < Config.LocalSoundRadius then
  
  TriggerServerEvent('Server:SoundToClient', GetPlayerServerId(id), 'flashbang', 0.3)
  
  end
  end
  end
  elseif IsPedShooting(PlayerPedId()) and wep == GetHashKey('WEAPON_GRENADE') then
  TriggerServerEvent('Server:SoundToClient', GetPlayerServerId(PlayerId()), 'grenade', 0.3)
    if PlayerData.job.name == 'russia' then
  for _,id in pairs(idRUSSIA) do 
  
  dist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(id)),GetEntityCoords(PlayerPedId()))
  if dist < Config.LocalSoundRadius then
  
  TriggerServerEvent('Server:SoundToClient', GetPlayerServerId(id), 'grenade', 0.3)
  
  end
  end
  elseif PlayerData.job.name == 'usa' then
  for _,id in pairs(idUSA) do 
  
  dist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(id)),GetEntityCoords(PlayerPedId()))
  if dist < Config.LocalSoundRadius then
  
  TriggerServerEvent('Server:SoundToClient', GetPlayerServerId(id), 'grenade', 0.3)
  
  end
  end
  end

  elseif IsPedShooting(PlayerPedId()) and wep == GetHashKey('WEAPON_SMOKEGRENADE') then
   TriggerServerEvent('Server:SoundToClient', GetPlayerServerId(PlayerId()), 'smoke', 0.3)
    if PlayerData.job.name == 'russia' then
  for _,id in pairs(idRUSSIA) do 
  
  dist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(id)),GetEntityCoords(PlayerPedId()))
  if dist < Config.LocalSoundRadius then
  
  TriggerServerEvent('Server:SoundToClient', GetPlayerServerId(id), 'smoke', 0.3)
  
  end
  end
  elseif PlayerData.job.name == 'usa' then
  for _,id in pairs(idUSA) do 
  
  dist = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(id)),GetEntityCoords(PlayerPedId()))
  if dist < Config.LocalSoundRadius then
  
  TriggerServerEvent('Server:SoundToClient', GetPlayerServerId(id), 'smoke', 0.3)
  
  end
  end
  end
  
  end


Wait(0)
end
end)
end


