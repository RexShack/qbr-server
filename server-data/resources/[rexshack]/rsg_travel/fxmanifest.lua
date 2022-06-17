fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'Rexshack Gaming : Guarma'

client_scripts {
    'client/client.lua',
	'client/npc.lua',
	'config.lua',
}

server_scripts {
    'server/server.lua'
}

lua54 'yes'