SWEP.Base						= "weapon_octo_base_pistol"
SWEP.Category					= L.dobrograd
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false
SWEP.PrintName						= "Bereta"

if SERVER then

	AddCSLuaFile()

end

SWEP.Primary.Sound 				= Sound( "elite.fire" )
SWEP.Primary.DistantSound 		= Sound( "elite.fire-distant" )
SWEP.Primary.Damage				= 25
SWEP.Primary.RPM				= 600
SWEP.Primary.ClipSize			= 15
SWEP.Primary.DefaultClip = 0
SWEP.Primary.KickUp				= 0.9
SWEP.Primary.KickDown			= 0.3
SWEP.Primary.KickHorizontal		= 1
SWEP.Primary.Spread 			= 0.01

SWEP.WorldModel					= "models/weapons/w_pist_elite_single.mdl"

--SWEP.ActiveHoldType			 = "duel"
SWEP.ReloadTime 				= 2.5

SWEP.AimPos = Vector(-10.5, -1.25, 4.55)
SWEP.AimAng = Angle(-2, 5, 0)
