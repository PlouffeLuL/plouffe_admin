fx_version "cerulean"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

games {'rdr3', "gta5"}
lua54 'yes'
use_experimental_fxv2_oal 'yes'

author 'PlouffeLuL'
description ''
version '1.0.0'

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/index.js',
    'html/jquery.js'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@ox_core/imports/server.lua',
    'server/main.lua',
    'server/commands.lua'
}

dependencies {
    '/onesync',
    'plouffe_lib'
}