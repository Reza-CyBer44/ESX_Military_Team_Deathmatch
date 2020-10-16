
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
files {
	"flashbang/loadouts.meta",
	"flashbang/weaponarchetypes.meta",
	"flashbang/weaponanimations.meta",
	"flashbang/pedpersonality.meta",
	"flashbang/weapons.meta"
}

data_file "WEAPON_METADATA_FILE" "flashbang/weaponarchetypes.meta"
data_file "WEAPON_ANIMATIONS_FILE" "flashbang/weaponanimations.meta"
data_file "LOADOUTS_FILE" "flashbang/loadouts.meta"
data_file "WEAPONINFO_FILE" "flashbang/weapons.meta"
data_file "PED_PERSONALITY_FILE" "flashbang/pedpersonality.meta"
server_script "FlashBang_S.lua"
client_scripts {
'config.lua',
'FlashBang_C.lua',
}