fx_version 'cerulean'
game 'gta5'

description 'CityLife Secret Prop Stealing Script'

shared_script 'config.lua'
client_script 'client.lua'
server_script 'server.lua'

dependencies {
    'qb-core',
    'qb-target',
    'qb-inventory',
    'qb-policejob' -- Ensure this is included if using qb-policejob for alerts
}