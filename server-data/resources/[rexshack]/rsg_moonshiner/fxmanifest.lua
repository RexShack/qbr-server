fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'RexshackGaming : Moonshiner'

client_script {
	'client/client.lua',
	'config.lua'
}

server_script {
	'server/server.lua'
}

dependency 'qbr-core' -- https://github.com/qbcore-redm-framework/qbr-core
dependency 'qbr-menu' -- https://github.com/qbcore-redm-framework/qbr-menu
dependency 'rsg_notify' -- https://github.com/RexShack/rsg_notify

lua54 'yes'