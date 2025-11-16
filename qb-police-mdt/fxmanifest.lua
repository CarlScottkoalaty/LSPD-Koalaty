fx_version 'cerulean'
game 'gta5'

author 'Jules'
description 'Police MDT for QBCore'
version '1.0.0'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/css/*.css',
    'html/js/*.js'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}
