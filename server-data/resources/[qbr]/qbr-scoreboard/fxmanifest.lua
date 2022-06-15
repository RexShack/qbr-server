fx_version "adamant"
game "rdr3"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

description 'QBR-Scoreboard'
version '1.0.0'

ui_page 'html/ui.html'

shared_scripts {
	'config.lua'
}

client_script 'client.lua'
server_script 'server.lua'

files {
    'html/*'
}
