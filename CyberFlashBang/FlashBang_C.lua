--[[


Add Following Lines to ESX Config Weapons
	{name = 'WEAPON_FLASHBANG', label = 'FLASHBANG', components = {}}
Add xPlayer.addWeapon('WEAPON_FLASHBANG',5) to Server.lua For Each Division That you want to have Flashbang
]]--
-- Main Loop
local ESX = nil
Citizen.CreateThread(function()
while ESX == nil do
		  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		  Citizen.Wait(0)
end
end)
Citizen.CreateThread(function()
if Config.FlashBangEnabled then
while true do
  res,wep = GetCurrentPedWeapon(PlayerPedId(),true) 
  if wep == GetHashKey('WEAPON_FLASHBANG') and IsPedShooting(PlayerPedId()) then
 Citizen.CreateThread(function()
	Wait(70)
	local cords = GetEntityCoords(PlayerPedId())
	local obj = GetClosestObjectOfType(cords.x,cords.y,cords.z,50.0,GetHashKey('w_ex_flashbang'),false,false,false)
    if obj ~= 0 and obj then
	Wait(2500)
	local fcord = GetEntityCoords(obj)
	AddExplosion(fcord.x,fcord.y,fcord.z,'EXPLOSION_PROGRAMMABLEAR',0.0,true,true,1.0)
	TriggerServerEvent('Cyber:FlashBangExplodeServer',fcord.x,fcord.y,fcord.z)
	ESX.Game.DeleteObject(obj)
  end
 end)
end
Wait(0)
end
end
end)


-- Load Addon FlashBang
Citizen.CreateThread(function()

AddTextEntry('WT_GNADE_FLSH',"CYBER-FlashBang")

end)



--Main Explode Handler

RegisterNetEvent('Cyber:FlashBangExplodeClient')
AddEventHandler('Cyber:FlashBangExplodeClient',function(x,y,z)
if Config.FlashBangEnabled then
local plyrpos = GetEntityCoords(PlayerPedId())

 RequestNamedPtfxAsset("core")
 while not HasNamedPtfxAssetLoaded("core") do
 Wait(0)
 end
 UseParticleFxAssetNextCall("core")
 StartParticleFxLoopedAtCoord("ent_anim_paparazzi_flash",x,y,z,0.0,0.0,0.0,25.0,false,false,false,false)
local OnScreen, ScreenX, ScreenY = World3dToScreen2d(x,y,z, 0)
local dist = GetDistanceBetweenCoords(x,y,z,plyrpos.x,plyrpos.y,plyrpos.z,true)

--print(dist)
if dist < Config.FlashBangRange and OnScreen then

RequestModel(GetHashKey('a_c_rat'))

while not HasModelLoaded(GetHashKey('a_c_rat')) do
Wait(0)
end

local prob = CreatePed(0,GetHashKey('a_c_rat'),x,y,z,0,false)
SetEntityAlpha(prob,0,false)
 if IsEntityVisible(prob) then
    if HasEntityClearLosToEntityInFront(PlayerPedId(),prob) then

DeletePed(prob)
DeleteEntity(prob)

if not IsPedInAnyVehicle(PlayerPedId(),false) then
StartScreenEffect('Dont_tazeme_bro',0,true)
ShakeGameplayCam('HAND_SHAKE',25.0)
ftime = GetGameTimer() + Config.StunTime * 1000
  while GetGameTimer() < ftime do
  Wait(1)
  end
StopGameplayCamShaking(true)
ShakeGameplayCam('HAND_SHAKE',7.0)
ftime = GetGameTimer() + Config.AfterStunTime * 1000
  while GetGameTimer() < ftime do
  Wait(1)
  end
StopGameplayCamShaking(true)
StopScreenEffect('Dont_tazeme_bro')

end
else
DeletePed(prob)
DeleteEntity(prob)
end
else
DeletePed(prob)
DeleteEntity(prob)
end
end
end
end)
