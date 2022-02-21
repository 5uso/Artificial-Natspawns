forceload add 29999999 27115050

scoreboard objectives add suso.nats dummy
scoreboard players set #32 suso.nats 32
scoreboard players set #135 suso.nats 135
scoreboard players set #1000 suso.nats 1000
scoreboard players set #36000 suso.nats 36000

execute unless score $frequency suso.nats matches 1.. run scoreboard players set $frequency suso.nats 5
execute unless score $repeat suso.nats matches 1.. run scoreboard players set $repeat suso.nats 10
execute unless score $cap suso.nats matches 1.. run scoreboard players set $cap suso.nats 70

function suso.nats:rng/seed

summon marker 29999999 100 27115050 {UUID:[I;1347430161,0,262144,0]}
