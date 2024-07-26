#Rotation
data modify storage suso.nats:main rot set value [0.0f, 0.0f]

function suso.nats:rng/lcg
scoreboard players operation $rng suso.nats %= #36000 suso.nats
execute store result storage suso.nats:main rot[0] float 0.01 run scoreboard players get $rng suso.nats

#Pitch distribution makes values closest to 0 more likely
function suso.nats:rng/lcg
scoreboard players operation $rng suso.nats %= #135 suso.nats
scoreboard players remove $rng suso.nats 67
scoreboard players operation $temp suso.nats = $rng suso.nats
function suso.nats:rng/lcg
scoreboard players operation $rng suso.nats %= #135 suso.nats
scoreboard players operation $temp suso.nats *= $rng suso.nats
execute store result storage suso.nats:main rot[1] float 0.01 run scoreboard players get $temp suso.nats

data modify entity 50502711-0-0-4-0 Rotation set from storage suso.nats:main rot

#Distance
function suso.nats:rng/lcg
scoreboard players operation $rng suso.nats %= #32 suso.nats
scoreboard players operation $s suso.nats = $rng suso.nats
execute rotated as 50502711-0-0-4-0 run function suso.nats:pos_search/s