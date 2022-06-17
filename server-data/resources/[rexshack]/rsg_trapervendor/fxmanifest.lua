fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
games {"rdr3"}

description 'Rexshack Gaming : Traper Vendor'

client_scripts {
    'client/client.lua',
	'client/blips.lua',
	'client/npc.lua',
	'config.lua'
}

server_scripts {
    'server/server.lua',
}

lua54 'yes'