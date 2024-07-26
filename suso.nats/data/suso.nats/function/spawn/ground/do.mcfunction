#particle minecraft:block_marker diamond_block ~ ~ ~ 0 0 0 0 1 force
#say SPAWN GROUND

execute store result score $temp suso.nats if predicate suso.nats:dark
execute if score $temp suso.nats matches 1 run function suso.nats:spawn/ground/dark
execute if score $temp suso.nats matches 0 run function suso.nats:spawn/ground/light