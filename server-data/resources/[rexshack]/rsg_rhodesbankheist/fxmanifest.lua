game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'RexshackGaming : Rhodes Bank Heist'

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}

shared_scripts {
    'config.lua'
}

dependency 'qbr-core' -- https://github.com/qbcore-redm-framework/qbr-core
dependency 'rsg_alerts' -- https://github.com/RexShack/rsg_alerts

lua54 'yes'