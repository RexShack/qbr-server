fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'Rexshack Gaming : Fishing'

client_scripts {
	'client/client.lua'
}

server_scripts {
	'server/server.lua'
}

exports {
	'IsFish',
}

lua54 'yes'