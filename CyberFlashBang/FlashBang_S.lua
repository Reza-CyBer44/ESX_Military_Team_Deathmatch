RegisterNetEvent('Cyber:FlashBangExplodeServer')
AddEventHandler('Cyber:FlashBangExplodeServer', function(x,y,z)


TriggerClientEvent('Cyber:FlashBangExplodeClient',-1,x,y,z)

end)
