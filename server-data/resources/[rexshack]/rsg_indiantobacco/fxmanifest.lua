fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'RexshackGaming : Indian Plants'

client_scripts {
    'client/client.lua',
}

server_scripts {
    'server/server.lua',
	'@oxmysql/lib/MySQL.lua',
}

shared_scripts { 
	'config.lua',
}
