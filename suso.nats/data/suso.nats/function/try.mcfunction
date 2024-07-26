function suso.nats:rng/lcg
scoreboard players operation $rng suso.nats %= #1000 suso.nats

#Probability of a floating spawn: 5% (Floating spawns are way more likely to succeed than ground spawns, so keep the probability low)
execute if score $rng suso.nats matches ..49 run function suso.nats:spawn/float/check

#Probability of a ground spawn: 95%
scoreboard players set $i suso.nats 10
execute if score $rng suso.nats matches 50.. positioned ~ ~5 ~ run function suso.nats:fall