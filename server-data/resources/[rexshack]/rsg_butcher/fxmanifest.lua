fx_version "adamant"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game "rdr3"

description 'Rexshack Gaming : Butcher'

client_scripts {
	'config.lua',
	'client/client.lua',
	'client/npc.lua'
}

server_scripts {
	'server/server.lua',
	'config.lua'
}

dependency 'qbr-core' -- https://github.com/qbcore-redm-framework/qbr-core

lua54 'yes'