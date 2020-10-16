Config = {}
-- Global Config 
Config.AntiOtherPedTimer = 1000
Config.UpdateBlipInterval = 30000
Config.FreezeTimeNight = true
Config.BlackOutDistance = 1000.0
Config.HideAI = true
Config.EnableSupply = true
Config.EnableCompass = true


-- Voice

Config.MumbleVoice = true

--

Config.EnbaleCustomSound = false

-- 

Config.PreventFromSpawningDouble = 7.0

-- Restrict Vehicles to Divisions

Config.RestrictVehicle = true

-- Show Names Above Head Using MpGamertag
Config.ShowNameAboveHead = true
Config.DistanceForName = 20.0

-- Supply Config
Config.EnableDelayForSupply = true
Config.SuppplyDelay = 5000

-- Balancer
Config.AutoBalancer = true
--
--Medkit
Config.EnableMedKit = true
Config.MedkitCount = 1
Config.MedkitDistance = 3.0

--
--Request Support Part

Config.LocalSupportCallc = 288
Config.GlobalSupportRequestc = 289
Config.LocalSupportDistance = 50.0


-- Sound Config
Config.LocalSoundRadius = 50.0



-- Capture
Config.FirstGameWaiting = 100000 -- Wait time Before checking for players when server starts SECOND
Config.CaptureMANUAL = false
Config.CaptureAUTOMAT = true
Config.OnlyAdminStart = true
Config.MinimumPlayer = {
  usa = 0,
  russia = 0
}
Config.DelayBetweenGames = 600  -- SECOND
Config.WaitTimeBeforeMatch = 10 -- SECOND
Config.ShowMatchTimeForPlayers = true 
Config.MatchTime = 600 -- SECOND
Config.MatchReward = 50
Config.CaptureDistance = 5.0
Config.PointPlusForEachSec = 1
Config.CapturePoint = { vector3(2753.31,1515.72,24.5),vector3(58.47,7206.58,3.69),vector3(-960.35,-3006.44,13.95),vector3(-1838.55,1222.21,13.02),vector3(-1326.22,59.83,53.54),vector3(686.36,578.09,130.96)}
--Config.CapturePoint = {
-- factory = vector3(2753.31,1515.72,24.5),
-- island = vector3(62.0,7181.44,2.69)
--}
Config.CapturePointMarkerType = 25
Config.CapturePointBlipSprite = 398
-- RESTRICT PLAYER
Config.PreventFromGoing = true -- When match is about to start prevent teams from going out of theyr base and prevent them to go to enemy base when match started
Config.PreventDistance = 1000.0

-- CROUCH N PRONE

Config.CrouchKey = 36
Config.ProneKey = 20
--                                       WEAPON PART



Config.WeaponsTintIndex = 4
Config.DisableMeleeAttack = true
--                                             RECOIL

-- Recoil Config In Default
Config.EnableRecoil = true
Config.WeaponRecoil = {
  HalfRecoilWhenProned = true,
  ThirdRecoilWehnCrouched = true,
  CombatPistol = 2.5,
  SpecialCarbine = 2.0,
  RPG = 5.0,
  SMG = 2.5,
  Shotgun = 2.0,
  Sniper = 5.0,
  CarbineRifle = 2.0,
  OtherGuns = 1.0,
  FlareGun = 1.0,
  Grenade = 0.1,
  InsurgentMinigun = 3.5
}
Config.AimingRecoilDecrease = 0.30
Config.CoverMultiplier = 0.75
Config.ProneRecoilMultiplier = 0.5
Config.WalkingRecoilMultiplier = 1.5
Config.SprintRecoilMultiplier = 2.0


--                              DAMAGE
-- Damage Config
Config.CustomDamageMultipilier = true
Config.WeaponDamage = {
 UnArmed = 0.5,
 CombatPistol = 0.75,
 SpecialCarbine = 0.75,
 RPG =0.75,
 SMG = 0.75,
 Shotgun = 0.75,
 Sniper = 0.75,
 CarbineRifle = 0.75,
 SmokeGrenade = 0.5

}
-- Ammo Config
Config.WeaponAmmo = {
 CombatPistol = 120,
 SpecialCarbine = 300,
 RPG = 7,
 SMG = 150,
 Shotgun = 120,
 Sniper = 120,
 CarbineRifle = 300
}




-- USA
Config.USABASE = {
  respawn = {x = -2341.1,y = 3260.0,z = 32.86, heading = 100.0},
  spawn = vector3(-2341.1,3260.0,32.86),
  PED = 's_m_y_marine_01',
  PEDCommander = 's_m_y_marine_03',
  divisionmark = vector3(-2352.58, 3258.01, 32.825),
  divmarktype = 2,
  gvehmark = vector3(-2426.82, 3300.48, 32.98),
  gvehmarktype = 2,
  gvehspawn = vector3(-2408.41,3298.37,33.23),
  gvehspawnhead = 330.0,
  avehmark = vector3(-2171.89,3255.2,32.81),
  avehmarktype = 2,
  avehspawn = vector3(-1835.87,2979.6,33.21),
  avehspawnhead = 56.0

}

-- Russia
Config.RUSSIABASE = {
  respawn = {x = 5195.82,y = 5660.46,z = 6.0, heading = 100.0},
  spawn = vector3(5195.82,5660.46,6.0),
  PED = 's_m_y_blackops_02',
  PEDCommander = 's_m_y_blackops_01',
  divisionmark = vector3(5194.57,5672.03,6.0),
  divmarktype = 2,
  hvehmark = vector3(5251.23,5622.93,6),
  hvehmarktype = 2,
  hvehspawn = vector3(5289.44,5619.73,6.0),
  hvehspawnhead = 178.0,
  avehmark = vector3(5227.31,5701.7,5.96),
  avehmarktype = 2,
  avehspawn = vector3(5232.28,5720.96,5.98),
  avehspawnhead = 317.33,
  bvehmark = vector3(5160.08,5725.83,5.98),
  bvehmarktype = 2,
  bvehspawn = vector3(5119.5,5728.16,2.0),
  bvehspawnhead = 1.0,

}


