fx_version 'cerulean'
game 'gta5'

author 'xen'
description 'ID Card System with GUI and Nationality'
version '1.0.0'

shared_script 'config.lua'

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/main.lua',
    'utils/functions.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

ui_page 'html/index.html'