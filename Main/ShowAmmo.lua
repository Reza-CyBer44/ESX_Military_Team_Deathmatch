--[[

Add This Line to Config.lua

Config.ShowAmmo = true


--]]
Citizen.CreateThread(function()
if Config == nil then
Config = {}
Config.ShowAmmo = true
end
if Config.ShowAmmo then
     
        while true do 
		if not IsPedInAnyVehicle(PlayerPedId()) and not IsPedDeadOrDying(PlayerPedId(),1) then  
        local result,weapon = GetCurrentPedWeapon(PlayerPedId(),true)
		
		 if weapon == GetHashKey('WEAPON_SPECIALCARBINE') or weapon == GetHashKey('WEAPON_COMBATPISTOL') or weapon == GetHashKey('WEAPON_RPG') or weapon == GetHashKey('WEAPON_SMG') or weapon == GetHashKey('WEAPON_FLAREGUN') or weapon == GetHashKey('WEAPON_ASSAULTSHOTGUN') or weapon == GetHashKey('WEAPON_MARKSMANRIFLE') or weapon == GetHashKey('WEAPON_CARBINERIFLE') then
         maxammo = GetMaxAmmoInClip(PlayerPedId(),weapon,true)
		 result,ammo = GetAmmoInClip(PlayerPedId(),weapon)

         if maxammo > 0 then
		    SetTextFont(4)
	        SetTextScale(0.90, 1.50)
	        SetTextColour(255, 255, 255, 255)
	        SetTextDropshadow(0, 0, 0, 0, 255)
	        SetTextDropShadow()
	        SetTextOutline()
         	SetTextCentre(true)
			SetTextEntry("STRING")
			if ammo < maxammo * 0.33 then
			AddTextComponentString('~r~' .. ammo .. '~s~/~y~' .. maxammo)
			else
			AddTextComponentString('~y~' .. ammo .. '/' .. maxammo)
			end
			DrawText(0.90, 0.85)
		 else
            SetTextFont(4)
	        SetTextScale(1.0, 1.50)
	        SetTextColour(255, 255, 255, 255)
	        SetTextDropshadow(0, 0, 0, 0, 255)
	        SetTextDropShadow()
	        SetTextOutline()
         	SetTextCentre(true)
			SetTextEntry("STRING")
			AddTextComponentString(ammo)
			DrawText(0.5, 0.5)
		
		



         end		 
		 end
		 
		 
		 
           






        end
        Citizen.Wait(0)
        end
end
end)
