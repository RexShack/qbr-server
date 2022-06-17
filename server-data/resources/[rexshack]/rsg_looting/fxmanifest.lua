fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'Rexshack Gaming : Looting'

client_script {
	'client/client.lua',
}

server_scripts {
    'server/server.lua',
}

dependency 'qbr-core' -- https://github.com/qbcore-redm-framework/qbr-core
dependency 'rsg_alerts' -- https://github.com/RexShack/rsg_alerts

lua54 'yes'