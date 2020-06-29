# Minecraft Server BOSH Release

This will deploy Minecraft into a BOSH server.

# Configuration

```
$ bosh -n -d minecraft deploy manifest.yml \
     -o operations/use-latest-dev.yml \
	 -o operations/set-custom-ops-json.yml \
	 -o operations/set-custom-server-properties.yml \
   -o operations/use-custom-init-commands.yml \
	 -l vars.yml
```

```
$ cat vars.yml
ops-json: |
  [
    {
      "name": "MyNameHere",
      "uuid": "0b9e6b95-b305-45d5-b6e7-fc5c5721056e (you'll need to look this up somehow)",
      "level": 4
    }
  ]
server-properties: |
  online-mode=true
  server-port=25565
init-commands: |
  op MyNameHere
  gamerule keepInventory true
```

# TODO

* Allow other types of Minecraft servers

# Resources

* https://minecraft.gamepedia.com/Tutorials/Setting_up_a_server#Configuring_the_Minecraft_server
* https://minecraft.gamepedia.com/Server.properties
* https://www.minecraft.net/en-us/download/server
* Other BOSH releases of Minecraft:
  * https://github.com/martyca/minecraft-boshrelease
  * https://github.com/JCubedS/minecraft-release
  * https://github.com/scottbri/minecraft-boshrelease
  * https://github.com/frodenas/minecraft-boshrelease
