scoreboard players add $t suso.nats 1
scoreboard players operation $t suso.nats %= $frequency suso.nats

execute if score $t suso.nats matches 0 if score $enable suso.nats matches 1 at @r[gamemode=!spectator,tag=!suso.nats.no] run function suso.nats:check