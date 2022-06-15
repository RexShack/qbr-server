fx_version 'cerulean'
game "rdr3"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

description 'QBR-Shops'
version '1.0.0'

server_script 'server/*.lua'
client_script 'client/*.lua'
shared_scripts {
	'config.lua'
}

dependencies {
	'qbr-inventory'
}