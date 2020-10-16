local Commanders = {
'0000116a7e7ca',

}
local gamestartedrecently = false
local deadPlayers = {}
local ingtimer = Config.MatchTime
local inwtimer = Config.WaitTimeBeforeMatch
local incapture = false
local incapturewait = false
local ingame = false
local currentcapture = nil
local russiapointc = 0 
local usapointc = 0
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


Citizen.CreateThread(function()
   while true do 
   Citizen.Wait(Config.UpdateBlipInterval)
   TriggerClientEvent('Cyber:updateBlip',-1)
   end


end)
Citizen.CreateThread(function()
while ESX == nil do 
  Citizen.Wait(10)
end
ESX.RegisterServerCallback('Cyber:GetPlayersForBlip', function(_source, cb)
	local xPlayers = ESX.GetPlayers()
	local players = {}

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		table.insert(players, {
			source = xPlayer.source,
			identifier = xPlayer.identifier,
			name = xPlayer.name,
			job = xPlayer.job
		})
	end

	cb(players)
end)
end)

Citizen.CreateThread(function()
 while ESX == nil do
 Citizen.Wait(10)
 end
while true do
    local xPlayers = ESX.GetPlayers()
	local players = {}

	for i=1, #xPlayers, 1 do
	
	xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	local cords = xPlayer.getCoords(true)
	local dist = #(Config.RUSSIABASE.divisionmark - cords)
	--print(dist)
	
	end

Citizen.Wait(1000)
end
end)
RegisterNetEvent('Cyber:RevivePlayer')
AddEventHandler('Cyber:RevivePlayer',function(target)
if deadPlayers[target] then
deadPlayers[target] = nil
TriggerClientEvent('Cyber:GetRevived',target)
TriggerClientEvent('Cyber:UpdateDeads',-1,deadPlayers)
end
end)

RegisterNetEvent('Cyber:DIED')
AddEventHandler('Cyber:DIED', function()
   
   deadPlayers[source] = 'dead'
   TriggerClientEvent('Cyber:UpdateDeads',-1,deadPlayers)
end)
RegisterNetEvent('Cyber:REVIVED')
AddEventHandler('Cyber:REVIVED', function()
    
    deadPlayers[source] = nil
    TriggerClientEvent('Cyber:UpdateDeads',-1,deadPlayers)
end)

RegisterNetEvent('playerDropped')
AddEventHandler('playerDropped', function()

     TriggerClientEvent('Cyber:updateBlip',-1)

end)

RegisterNetEvent('Cyber:SetJob')
AddEventHandler('Cyber:SetJob', function(team)
	xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.setJob(team,0)
	for k,v in ipairs(xPlayer.getLoadout()) do
    xPlayer.removeWeapon(v.name)
   end
	TriggerClientEvent('Cyber:updateBlip',-1)
end)

RegisterNetEvent('Cyber:SetGrade')
AddEventHandler('Cyber:SetGrade', function(team,grade)
   xPlayer = ESX.GetPlayerFromId(source)
   xPlayer.setJob(team,grade)
   for k,v in ipairs(xPlayer.getLoadout()) do
    xPlayer.removeWeapon(v.name)
   end
   
   if grade == 1 then
   xPlayer.addWeapon('WEAPON_FLASHBANG',4)
   xPlayer.addWeapon('WEAPON_SMOKEGRENADE',10)
   xPlayer.addWeapon('WEAPON_FLAREGUN',30)
   xPlayer.addWeapon('WEAPON_KNIFE',1)
   xPlayer.addWeapon('GADGET_PARACHUTE',1)
   xPlayer.addWeapon('WEAPON_GRENADE',10)
   xPlayer.addWeapon('WEAPON_COMBATPISTOL',Config.WeaponAmmo.CombatPistol)
   xPlayer.setWeaponTint('WEAPON_COMBATPISTOL',Config.WeaponsTintIndex)
   xPlayer.addWeaponComponent('WEAPON_COMBATPISTOL','flashlight')
   xPlayer.addWeapon('WEAPON_SPECIALCARBINE',Config.WeaponAmmo.SpecialCarbine)
   xPlayer.setWeaponTint('WEAPON_SPECIALCARBINE',Config.WeaponsTintIndex)
  -- xPlayer.addWeapon('WEAPON_SPECIALCARBINE','clip_extended')
   xPlayer.addWeaponComponent('WEAPON_SPECIALCARBINE','scope')
   xPlayer.addWeaponComponent('WEAPON_SPECIALCARBINE','flashlight')
   xPlayer.addWeaponComponent('WEAPON_SPECIALCARBINE','grip')
   xPlayer.showNotification('~b~ You Are Now ~g~ Rifle ~r~ Commando',false,true,210)
   
   elseif grade == 2 then
   xPlayer.addWeapon('WEAPON_FLASHBANG',4)
   xPlayer.addWeapon('WEAPON_SMOKEGRENADE',10)
   xPlayer.addWeapon('WEAPON_FLAREGUN',30)
   xPlayer.addWeapon('WEAPON_KNIFE',1)
   xPlayer.addWeapon('GADGET_PARACHUTE',1)
   xPlayer.addWeapon('WEAPON_GRENADE',10)
   xPlayer.addWeapon('WEAPON_COMBATPISTOL',Config.WeaponAmmo.CombatPistol)
   xPlayer.setWeaponTint('WEAPON_COMBATPISTOL',Config.WeaponsTintIndex)
   xPlayer.addWeaponComponent('WEAPON_COMBATPISTOL','flashlight')
   xPlayer.addWeapon('WEAPON_RPG',Config.WeaponAmmo.RPG)
   xPlayer.setWeaponTint('WEAPON_RPG',Config.WeaponsTintIndex)
   xPlayer.addWeapon('WEAPON_SMG',Config.WeaponAmmo.SMG)
   xPlayer.setWeaponTint('WEAPON_SMG',Config.WeaponsTintIndex)
   xPlayer.addWeaponComponent('WEAPON_SMG','flashlight')
   xPlayer.addWeaponComponent('WEAPON_SMG','grip')
   xPlayer.addWeaponComponent('WEAPON_SMG','scope')
   xPlayer.addWeapon('WEAPON_PROXMINE',25)
   xPlayer.showNotification('~b~ You Are Now ~g~ Artillery ~r~ Commando',false,true,210)
   
   
   
   elseif grade == 3 then
   xPlayer.addWeapon('WEAPON_FLASHBANG',4)
   xPlayer.addWeapon('WEAPON_SMOKEGRENADE',10)
   xPlayer.addWeapon('WEAPON_FLAREGUN',30)
   xPlayer.addWeapon('WEAPON_KNIFE',1)
   xPlayer.addWeapon('GADGET_PARACHUTE',1)
   xPlayer.addWeapon('WEAPON_GRENADE',10)
   xPlayer.addWeapon('WEAPON_COMBATPISTOL',Config.WeaponAmmo.CombatPistol)
   xPlayer.setWeaponTint('WEAPON_COMBATPISTOL',Config.WeaponsTintIndex)
   xPlayer.addWeaponComponent('WEAPON_COMBATPISTOL','flashlight')
   xPlayer.addWeapon('WEAPON_ASSAULTSHOTGUN',Config.WeaponAmmo.Shotgun)
   xPlayer.setWeaponTint('WEAPON_ASSAULTSHOTGUN',Config.WeaponsTintIndex)
   xPlayer.addWeaponComponent('WEAPON_ASSAULTSHOTGUN','flashlight')
   xPlayer.addWeaponComponent('WEAPON_ASSAULTSHOTGUN','clip_extended')
   xPlayer.showNotification('~b~ You Are Now ~g~ Shotgun ~r~ Commando',false,true,210)
   
   elseif grade == 4 then
   xPlayer.addWeapon('WEAPON_FLASHBANG',4)
   xPlayer.addWeapon('WEAPON_SMOKEGRENADE',10)
   xPlayer.addWeapon('WEAPON_FLAREGUN',30)
   xPlayer.addWeapon('WEAPON_KNIFE',1)
   xPlayer.addWeapon('GADGET_PARACHUTE',1)
   xPlayer.addWeapon('WEAPON_GRENADE',10)
   xPlayer.addWeapon('WEAPON_COMBATPISTOL',Config.WeaponAmmo.CombatPistol)
   xPlayer.setWeaponTint('WEAPON_COMBATPISTOL',Config.WeaponsTintIndex)
   xPlayer.addWeaponComponent('WEAPON_COMBATPISTOL','flashlight')
   xPlayer.addWeapon('WEAPON_MARKSMANRIFLE',Config.WeaponAmmo.Sniper)
   xPlayer.setWeaponTint('WEAPON_MARKSMANRIFLE',Config.WeaponsTintIndex)
   xPlayer.addWeaponComponent('WEAPON_MARKSMANRIFLE','flashlight')
   xPlayer.addWeaponComponent('WEAPON_MARKSMANRIFLE','clip_extended')
   xPlayer.addWeaponComponent('WEAPON_MARKSMANRIFLE','grip')
   xPlayer.addWeaponComponent('WEAPON_MARKSMANRIFLE','scope')
   xPlayer.addWeaponComponent('WEAPON_MARKSMANRIFLE','luxary_finish')
   xPlayer.showNotification('~b~ You Are Now ~g~ Sniper ~b~ Commando',false,true,210)
   
   elseif grade == 5 then
   xPlayer.addWeapon('WEAPON_FLASHBANG',4)
   xPlayer.addWeapon('WEAPON_SMOKEGRENADE',10)
   xPlayer.addWeapon('WEAPON_FLAREGUN',30)
   xPlayer.addWeapon('WEAPON_KNIFE',1)
   xPlayer.addWeapon('WEAPON_GRENADE',10)
   xPlayer.addWeapon('WEAPON_COMBATPISTOL',Config.WeaponAmmo.CombatPistol)
   xPlayer.setWeaponTint('WEAPON_COMBATPISTOL',Config.WeaponsTintIndex)
   xPlayer.addWeaponComponent('WEAPON_COMBATPISTOL','flashlight')
   xPlayer.addWeapon('WEAPON_CARBINERIFLE',Config.WeaponAmmo.CarbineRifle)
   xPlayer.setWeaponTint('WEAPON_CARBINERIFLE',Config.WeaponsTintIndex)
   xPlayer.addWeaponComponent('WEAPON_CARBINERIFLE','scope')
   xPlayer.addWeaponComponent('WEAPON_CARBINERIFLE','grip')
   xPlayer.addWeaponComponent('WEAPON_CARBINERIFLE','flashlight')
   xPlayer.showNotification('~b~ You Are Now ~g~ Ground ~y~ Pilot',false,true,210)
   elseif grade == 6 then
   xPlayer.addWeapon('WEAPON_SMOKEGRENADE',10)
   xPlayer.addWeapon('WEAPON_FLAREGUN',30)
   xPlayer.addWeapon('WEAPON_KNIFE',1)
   xPlayer.addWeapon('GADGET_PARACHUTE',1)
   xPlayer.addWeapon('WEAPON_GRENADE',10)
   xPlayer.addWeapon('WEAPON_COMBATPISTOL',Config.WeaponAmmo.CombatPistol)
   xPlayer.setWeaponTint('WEAPON_COMBATPISTOL',Config.WeaponsTintIndex)
   xPlayer.addWeaponComponent('WEAPON_COMBATPISTOL','flashlight')
   xPlayer.showNotification('~b~ You Are Now ~g~ Aircraft ~y~ Pilot',false,true,210)
   elseif grade == 7 then
   
   xPlayer.addWeapon('WEAPON_FLASHBANG',4)
   xPlayer.addWeapon('WEAPON_SMOKEGRENADE',10)
   xPlayer.addWeapon('WEAPON_FLAREGUN',30)
   xPlayer.addWeapon('WEAPON_KNIFE',1)
   xPlayer.addWeapon('GADGET_PARACHUTE',1)
   xPlayer.addWeapon('WEAPON_GRENADE',10)
   xPlayer.addWeapon('WEAPON_COMBATPISTOL',Config.WeaponAmmo.CombatPistol)
   xPlayer.setWeaponTint('WEAPON_COMBATPISTOL',Config.WeaponsTintIndex)
   xPlayer.addWeaponComponent('WEAPON_COMBATPISTOL','flashlight')
   xPlayer.addWeapon('WEAPON_SPECIALCARBINE',Config.WeaponAmmo.SpecialCarbine)
   xPlayer.setWeaponTint('WEAPON_SPECIALCARBINE',Config.WeaponsTintIndex)
  -- xPlayer.addWeapon('WEAPON_SPECIALCARBINE','clip_extended')
   xPlayer.addWeaponComponent('WEAPON_SPECIALCARBINE','scope')
   xPlayer.addWeaponComponent('WEAPON_SPECIALCARBINE','flashlight')
   xPlayer.addWeaponComponent('WEAPON_SPECIALCARBINE','grip')
   xPlayer.showNotification('~b~ You Are Now ~g~ Ground ~r~ ~y~ Commander',false,true,210)
   
   elseif grade == 8 then
   
   xPlayer.addWeapon('WEAPON_SMOKEGRENADE',10)
   xPlayer.addWeapon('WEAPON_FLAREGUN',30)
   xPlayer.addWeapon('WEAPON_KNIFE',1)
   xPlayer.addWeapon('GADGET_PARACHUTE',1)
   xPlayer.addWeapon('WEAPON_GRENADE',10)
   xPlayer.addWeapon('WEAPON_COMBATPISTOL',Config.WeaponAmmo.CombatPistol)
   xPlayer.setWeaponTint('WEAPON_COMBATPISTOL',Config.WeaponsTintIndex)
   xPlayer.addWeaponComponent('WEAPON_COMBATPISTOL','flashlight')
 xPlayer.showNotification('~b~ You Are Now ~g~ Aircraft ~r~ ~y~ Commander',false,true,210)
   
   
   end
   TriggerClientEvent('Cyber:updateBlip',-1)
   
end)

-- Capture Part


-- Loop For Capture start stop
Citizen.CreateThread(function()
while true do
if incapturewait then
TriggerClientEvent('Cyber:StartWaiting',-1,inwtimer)
while inwtimer >= 0 do
inwtimer = inwtimer - 1
Citizen.Wait(1000)
TriggerClientEvent('Cyber:TimeWaiting',-1,inwtimer)
end
incapture = true
incapturewait = false
end
if incapture then
TriggerClientEvent('Cyber:StartMatch',-1,ingtimer,russiapointc,usapointc)
Wait(100)
TriggerClientEvent('Cyber:UpdateMarkers',-1,currentcapture,'none')
while ingtimer >= 0 do
ingtimer = ingtimer - 1
Citizen.Wait(1000)
TriggerClientEvent('Cyber:TimeMatch',-1,ingtimer,russiapointc,usapointc)
end
incapture = false
ingame = false
whowon = nil
if russiapointc > usapointc then
whowon = 'russia'
elseif usapointc > russiapointc then
whowon = 'usa'
else
whowon = 'draw'
end
TriggerClientEvent('Cyber:EndMatch',-1,whowon)
FinishTheMatch(whowon)
end
Citizen.Wait(10)
end
end)

-- If in game Start Increasing The Points
local laststatus = nil
Citizen.CreateThread(function()
while true do 
if incapture then
local usa = 0
local russia = 0
local status = nil
local xPlayers = ESX.GetPlayers()

for i=1, #xPlayers, 1 do
    local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
	local coords = xPlayer.getCoords(true)
    local distance = #(coords - currentcapture)
    if distance < Config.CaptureDistance then
	
	if xPlayer.getJob().name  == 'usa' then
    if not deadPlayers[xPlayers[i]] then
	usapointc = usapointc + Config.PointPlusForEachSec
    usa = usa + 1	
    end
	elseif xPlayer.getJob().name == 'russia' then
    if not deadPlayers[xPlayers[i]] then
	russiapointc = russiapointc + Config.PointPlusForEachSec
    russia = russia + 1	
    end
	else 
	xPlayer.kick('UNKNOWN TEAM')
	end
end
if usa > 0 and russia > 0 then
status = 'both'
elseif usa > 0 and russia == 0 then
status = 'usa'
elseif usa == 0 and russia > 0 then
status = 'russia'
else 
status = 'none'
end
if laststatus ~= status then
TriggerClientEvent('Cyber:UpdateMarkers',-1,currentcapture,status)
laststatus = status 
end



Citizen.Wait(1000)
end
end
Citizen.Wait(0)
end
end)
-- GetRewards
function FinishTheMatch(winner)

local xPlayers = ESX.GetPlayers()

for i=1, #xPlayers, 1 do

local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

--xPlayer.kick('Game Has Ended. Please Rejoin For Another Match')
--print(xPlayer.getName())
end

--print('the team that won ' .. winner)

end
-- Game PART
if Config.CaptureMANUAL then
ESX.RegisterCommand('startcapture', 'user', function(xPlayer, args, showError)

  
	if not incapture and not incapturewait and not ingame then
    usacount = 0
	russiacount = 0
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
    local xxPlayer = ESX.GetPlayerFromId(xPlayers[i])
    if xxPlayer.getJob().name == 'russia' then

    russiacount = russiacount + 1	

	elseif xxPlayer.getJob().name == 'usa' then

	usacount = usacount + 1

    end
    end
    if usacount >= Config.MinimumPlayer.usa  and russiacount >= Config.MinimumPlayer.russia then
	ingtimer = Config.MatchTime
    inwtimer = Config.WaitTimeBeforeMatch
	usapointc = 0
	russiapointc = 0
    incapturewait = true
	ingame = true
	currentcapture = Config.CapturePoint[ math.random( #Config.CapturePoint ) ]
 
    else

    xPlayer.showNotification('~y~ Not Enough Player',false,true,210)

    end
	else
	
	xPlayer.showNotification('~y~ A Game Is In progress',false,true,210)
	
	end 


  	
end, false, {help = 'Start Free Capture For Both Team'})
end

Citizen.CreateThread(function()
if Config.CaptureAUTOMAT then
Citizen.Wait(Config.FirstGameWaiting*1000)
while true do 
if gamestartedrecently then
Citizen.Wait(Config.DelayBetweenGames * 1000)
end
	if not incapture and not incapturewait and not ingame then
    usacount = 0
	russiacount = 0
	local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
    local xxPlayer = ESX.GetPlayerFromId(xPlayers[i])
    if xxPlayer.getJob().name == 'russia' then

    russiacount = russiacount + 1	

	elseif xxPlayer.getJob().name == 'usa' then

	usacount = usacount + 1

    end
    end
    if usacount >= Config.MinimumPlayer.usa  and russiacount >= Config.MinimumPlayer.russia then
	ingtimer = Config.MatchTime
    inwtimer = Config.WaitTimeBeforeMatch
	usapointc = 0
	russiapointc = 0
    incapturewait = true
	ingame = true
	gamestartedrecently = true
	currentcapture = Config.CapturePoint[ math.random( #Config.CapturePoint ) ]
 
    else


    end
	else
	
	
	end 




Citizen.Wait(1000)



end
end
end)

ESX.RegisterServerCallback('Cyber:CheckCurrentGame',function(source,cb)
local data = {}
data.loc = currentcapture
data.WaitTimerStarted = incapturewait
data.FirstWaitTimer = false
data.WaitTimer = inwtimer
data.GameStarted = ingame
data.FirstGameTimer = false
data.GameTimer = ingtimer
data.BlipStatus = laststatus
data.RussiaPoint = russiapointc
data.UsaPoint = usapointc
cb(data)

end)
ESX.RegisterServerCallback('Cyber:CheckBalance',function(team,cb)
usacount = 0
russiacount = 0
response = true
local xPlayers = ESX.GetPlayers()
for i=1, #xPlayers, 1 do
    local xxPlayer = ESX.GetPlayerFromId(xPlayers[i])
    if xxPlayer.getJob().name == 'russia' then

    russiacount = russiacount + 1	

	elseif xxPlayer.getJob().name == 'usa' then

	usacount = usacount + 1
    
	end
end
if team == 'russia' then
if russiacount > usacount then
response = false
elseif russiacount == usacount then
response = true
elseif usacount > russiacount then
response = true
end

elseif team == 'usa' then

if russiacount < usacount then
response = false
elseif russiacount == usacount then
response = true
elseif usacount < russiacount then
response = true
end
end
if Config.AutoBalancer then
if response then
cb(true)
else
cb(false)
end
else
cb(true)
end
end)

-- REQUEST PART
RegisterNetEvent('Cyber:RequestGlobalSupport')
AddEventHandler('Cyber:RequestGlobalSupport',function(action)
local xPlayer = ESX.GetPlayerFromId(source)
local job = xPlayer.getJob()
 local xPlayers = ESX.GetPlayers()
if action == 'bombard' then
        if    job.name == 'russia' then
       for i=1, #xPlayers, 1 do
       local TxPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if TxPlayer.getJob().name == 'russia' then
		
		if TxPlayer.getJob().grade == 6 then
		TriggerClientEvent('Cyber:RequestGlobalSupport',xPlayers[i],xPlayer.getName(),'Has Requested Bombard')
		end
		
		end  
      end

        elseif job.name == 'usa' then
 
        for i=1, #xPlayers, 1 do
       local TxPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if TxPlayer.getJob().name == 'usa' then
		
		if TxPlayer.getJob().grade == 6 then
		TriggerClientEvent('Cyber:RequestGlobalSupport',xPlayers[i],xPlayer.getName(),'Has Requested Bombard')
		end
		
		end  
 
        end
		end
elseif action == 'supply' then
        if    job.name == 'russia' then

                for i=1, #xPlayers, 1 do
       local TxPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if TxPlayer.getJob().name == 'russia' then
		
		if TxPlayer.getJob().grade == 6 then
		TriggerClientEvent('Cyber:RequestGlobalSupport',xPlayers[i],xPlayer.getName(),'Has Requested Supply Delivery')
		end
		
		end  
        end
        elseif job.name == 'usa' then

                for i=1, #xPlayers, 1 do
       local TxPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if TxPlayer.getJob().name == 'usa' then
		
		if TxPlayer.getJob().grade == 5 then
		TriggerClientEvent('Cyber:RequestGlobalSupport',xPlayers[i],xPlayer.getName(),'Has Requested Supply Delivery')
		end
		
		end  

        end
		end
elseif action == 'ground' then
        if    job.name == 'russia' then

                for i=1, #xPlayers, 1 do
       local TxPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if TxPlayer.getJob().name == 'russia' then
		
		if TxPlayer.getJob().grade ~= 6 then
		TriggerClientEvent('Cyber:RequestGlobalSupport',xPlayers[i],xPlayer.getName(),'Has Requested All Ground Units Support')
		end
		
		end   
         
        end
        elseif job.name == 'usa' then

               for i=1, #xPlayers, 1 do
       local TxPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if TxPlayer.getJob().name == 'usa' then
		
		if TxPlayer.getJob().grade ~= 6 then
		TriggerClientEvent('Cyber:RequestGlobalSupport',xPlayers[i],xPlayer.getName(),'Has Requested All Ground Units Support')
		end
		
		end  



        end
		end
elseif action == 'transport' then
        if    job.name == 'russia' then

        for i=1, #xPlayers, 1 do
       local TxPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if TxPlayer.getJob().name == 'russia' then
		
		if TxPlayer.getJob().grade == 6 or TxPlayer.getJob().grade == 5  then
		TriggerClientEvent('Cyber:RequestGlobalSupport',xPlayers[i],xPlayer.getName(),'Has Requested Transport')
		end       
       
	   end
	   end

        elseif job.name == 'usa' then

        for i=1, #xPlayers, 1 do
       local TxPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if TxPlayer.getJob().name == 'usa' then
		
		if TxPlayer.getJob().grade == 6 or TxPlayer.getJob().grade == 5  then
		TriggerClientEvent('Cyber:RequestGlobalSupport',xPlayers[i],xPlayer.getName(),'Has Requested Transport')
		end 

        end
		end
		end
end      

end)

RegisterNetEvent('Cyber:RequestLocalSupport')
AddEventHandler('Cyber:RequestLocalSupport',function(nears,action)
message = nil
if action == 'backup' then
message = 'Requested Backup'
elseif action == 'rushing' then
message = 'Is Rushing To The Enemy'
elseif action == 'envehicle' then
message = 'Destroy Enemy Vehicle Immediately'
elseif action == 'capture' then
message = 'Is Going to Capture Point'
elseif action == 'enemy' then
message = 'Spotted The Enemy' 
else
message = 'UNKNOWN'
end
 name = GetPlayerName(source)
 
 local xPlayer = ESX.GetPlayerFromId(source)
 local job = xPlayer.getJob()

for _,v in pairs(nears) do
 local zPlayer = ESX.GetPlayerFromId(v)
 if zPlayer then
  zjob = zPlayer.getJob()
  if zjob.name == job.name then
   TriggerClientEvent('Cyber:GetLocalSupport',v,name,message)
  end
 end
end


end)


ESX.RegisterServerCallback('Cyber:CheckPlayerForCommanding',function(source,cb)
       _source = source
       xPlayer = ESX.GetPlayerFromId(_source)
	  if xPlayer then
      
	  if CanPlayerBeCommander(xPlayer.getIdentifier()) then 
	  cb(true)
	  else
      cb(false)
      end
      else
	  cb(false)
	  end
end)

function CanPlayerBeCommander(identifier) 
response = false
    for _,v in pairs(Commanders) do 
     
    if v == identifier then
	response = true
	break
    end
	
    end
return response
end