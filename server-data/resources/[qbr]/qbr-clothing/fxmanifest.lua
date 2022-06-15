fx_version "adamant"

games { 'rdr3', 'gta5' }

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'QBR-Clothing'
version '1.0.0'

ui_page 'html/dist/index.html'

shared_scripts {
	'shared/config.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua'
}

client_scripts {
	'client/*.lua',
}

files {
	'html/dist/index.html',
	'html/dist/*.png',
	'html/dist/app.js',
	'html/dist/*.eot',
	'html/dist/*.woff2',
	'html/dist/*.woff',
	'html/dist/*.ttf',
}

dependencies {
	'qbr-core'
}
