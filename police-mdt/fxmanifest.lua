fx_version 'cerulean'
game 'gta5'

author 'Jules'
description 'Police MDT for QBCore'
version '1.0.0'

ui_page 'html/dist/index.html'

files {
    'html/dist/index.html',
    'html/dist/assets/*'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua'
}
