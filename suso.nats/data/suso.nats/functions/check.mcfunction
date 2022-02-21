execute store result score $count suso.nats if entity @e[tag=suso.nats.count,distance=..128]

scoreboard players operation $k suso.nats = $repeat suso.nats
execute if score $count suso.nats < $cap suso.nats run function suso.nats:repeat