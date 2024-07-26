execute store result score $temp suso.nats if block ~ ~ ~ #suso.nats:free
execute if score $temp suso.nats matches 1 run function suso.nats:spawn/float/do
execute if score $temp suso.nats matches 0 if block ~ ~ ~ minecraft:water run function suso.nats:spawn/float/water/do