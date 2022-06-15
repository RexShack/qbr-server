fx_version 'cerulean'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'QBR-HUD'
version '2.0.0'

shared_scripts {
	'@qbr-core/shared/locale.lua',
	'locales/en.lua',
    	'config.lua'
}

client_script 'client/main.lua'
server_script 'server/main.lua'

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/styles.css',
	'html/app.js'
}
