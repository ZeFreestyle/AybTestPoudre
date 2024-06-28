fx_version 'cerulean'
game 'gta5'

description 'Script pour effectuer des test de poudre'

author 'VotreNom'
version '1.0'

server_scripts {
    '@mysql-async/lib/MySQL.lua', 
    'server.lua'
}

client_scripts {
    'client.lua'
}

dependencies {
    'es_extended', 
    'oxmysql' 
}
