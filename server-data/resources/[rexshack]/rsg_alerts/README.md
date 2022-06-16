# RexshackGaming
- discord : https://discord.gg/s5uSk56B65
- youtube : https://www.youtube.com/channel/UCikEgGfXO-HCPxV5rYHEVbA
- github : https://github.com/RexShack
- support-me : https://rexshackgaming.tebex.io/package/5114907

# Framework QBCore RedM Edition
- https://github.com/qbcore-redm-framework

# Dependancies
- qbr-core : https://github.com/qbcore-redm-framework

# Installation
- ensure that the dependancies are added and started
- add rsg_alerts to your resources folder

# Starting the resource
- add the following to your server.cfg file : ensure rsg_alerts

# Support
- discord : https://discord.gg/s5uSk56B65
- email : rexshackuk@gmail.com

# Client Use:
----------------------------------------------------
local alertcoords = GetEntityCoords(PlayerPedId())
local blipname = 'contraband'
local alertmsg = 'contraband sale in progress'
TriggerEvent('rsg_alerts:client:lawmanalert', alertcoords, blipname, alertmsg)
----------------------------------------------------
local alertcoords = GetEntityCoords(PlayerPedId())
local blipname = 'Help!'
local alertmsg = 'need help!'
TriggerEvent('rsg_alerts:client:medicalert', alertcoords, blipname, alertmsg)
----------------------------------------------------

# Server Use:
----------------------------------------------------
local alertcoords = GetEntityCoords(PlayerPedId())
local blipname = 'contraband'
local alertmsg = 'contraband sale in progress'
TriggerClientEvent('rsg_alerts:client:lawmanalert', alertcoords, blipname, alertmsg)
----------------------------------------------------
local alertcoords = GetEntityCoords(PlayerPedId())
local blipname = 'Help!'
local alertmsg = 'need help'
TriggerClientEvent('rsg_alerts:client:medicalert', alertcoords, blipname, alertmsg)
----------------------------------------------------