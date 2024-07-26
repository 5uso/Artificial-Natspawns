execute store result score $temp suso.nats if block ~ ~-1 ~ #suso.nats:solid
execute if score $temp suso.nats matches 1 run function suso.nats:spawn/ground/check

scoreboard players remove $i suso.nats 1
execute if score $temp suso.nats matches 0 if score $i suso.nats matches 1.. positioned ~ ~-1 ~ run function suso.nats:fall