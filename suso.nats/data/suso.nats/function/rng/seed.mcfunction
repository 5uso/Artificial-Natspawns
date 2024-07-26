scoreboard players set #rng.mult suso.nats 1103515245

summon area_effect_cloud 29999999 100 27115050 {Tags:["suso.nats_rng"]}
execute as @e[type=area_effect_cloud,tag=suso.nats_rng,x=0,y=0,z=0,dx=0,dy=0,dz=0] run function suso.nats:rng/seed_pt2

scoreboard players operation $rng suso.nats = #rng suso.nats