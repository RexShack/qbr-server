# RexshackGaming
- discord : https://discord.gg/s5uSk56B65
- youtube : https://www.youtube.com/channel/UCikEgGfXO-HCPxV5rYHEVbA
- github : https://github.com/RexShack
- support-me : https://rexshackgaming.tebex.io/package/5114907

# Framework QBCore RedM Edition
- https://github.com/qbcore-redm-framework

# Description
- own your own home in redm

# Dependencies
- qbr-core -- https://github.com/qbcore-redm-framework/qbr-core

# Installation
- ensure the above dependancies are installed and started
- extract the contents of the rsg_properties.zip
- add rsg_properties to your resources folder
- import the "houses.sql" to your database
- add the following to qbr-core\server\player.lua around line 473 (metadata)

```lua
PlayerData.metadata['house'] = PlayerData.metadata['house'] or 'none'
```

- add the following to your "server.cfg" : ensure rsg_properties
- restart your server!