# Artificial-Natspawns
A Minecraft datapack that recreates natural mob spawning to be used in custom maps.

Optimized to run fast on situations with heavy server side load.

Fully customizable, but requires some work to set up. Acts as a scaffold for whatever it is you're building.

It's recommended to use this datapack with `gamerule doMobSpawning false`, as to have as much control over spawning as possible.

## How to use
### Score configuration
To enable custom spawning, set score `$enable suso.nats` to 1.

- Score `$period suso.nats` determines how many ticks to wait for the system to run. Setting this score to 1 causes it to fire every tick. By default it's set to 5.
- Score `$repeat suso.nats` determines how many spawn attempts will be performed per run. By default it's set to 10.
- Score `$cap suso.nats` determines how many mobs the system will spawn around players. If a player has this amount or higher of mobs tagged `suso.nats.count` within 128 blocks, no attempt to spawn any more will be centered on that player. By default it's set to 70.

*Note: Each run of the system is centered on a player chosen at random and uses a single @e to check for the mob cap. This is why it may be convenient to group attempts into less frequent runs.*

### Entity tags
- Tag `suso.nats.count` will make this entity count towards the mob cap. You most likely want to add this tag to every mob that spawns from the system.
- Tag `suso.nats.no` is used on players and will cause the system to ignore them. The system also ignores any players in spectator mode, regardless of tags.

### Block tags
- Tag `suso.nats:solid` determines which blocks are considered ground. Mobs may spawn on these.
- Tag `suso.nats:free` determines which blocks are "air". Mobs may spawn within these.

### Adding custom spawns
And now, for the fun part. Adding custom spawns isn't very difficult, but it requires some thought (especially to keep the amount of checks and rng calls low).

Function `suso.nats:try` runs at the position the pack attempts a spawn. From here, you can run whatever you want. In the pack, I've included some examples of how you could set everything up. Currently, the pack will spawn:

```
Some floating bats in the air.
Some blue axolotls in water.
Jellie cats on lit ground.
Wither skeletons and zombie piglins on dark ground.
```

Here's the list of functions that run when the pack tries spawns in...
- The air: `suso.nats:spawn/float/do`
- Underwater: `suso.nats:spawn/float/water/do`
- The ground: `suso.nats:spawn/ground/do`
  - Light 7 or less: `suso.nats:spawn/ground/dark`
  - Light 8 or more: `suso.nats:spawn/ground/light`

Play around with these and you should get a good idea on what you need for your specific use case.

Also, since these are functions that run wherewher your mob spawns... why not add a little bit of flair to it? Maybe some particles, maybe a playsound... the possibilities are endless! [* ](#disclaimer-there-is-most-likely-an-end-to-the-possibilities-crowdford-is-not-responsible-for-any-damages-caused-by-actions-or-inactions-resulting-from-any-misinterpretations-of-the-statements-contained-in-this-file)

Finally, some things to keep in mind:

#### The rng function
`function suso.nats:rng/lcg` gets you a random number in score `$rng suso.nats`. In order to limit the range, you'd want to modulo it using `scoreboard players operation $rng suso.nats %= [some score]`. You probably want to call this function to decide what to spawn. If you're smart about it and divide the range into different subsets you should be good with a single rng call per spawn, although they are not very expensive.

#### Branching
Whenever you need to check for a condition multiple times it's best to just create a new function that runs when that condition is met instead of doing multiple executed with the same condition. This is especially important for this system, as it runs very frequently and you may have hundreds of conditions if your use case is complex.

Don't:

`ground.mcfunction`
```mcfunction
execute if predicate suso.nats:dark if score $rng suso.nats matches ..524 run summon wither_skeleton ~ ~ ~ {Tags:["suso.nats.count"]}
execute if predicate suso.nats:dark if score $rng suso.nats matches 525.. run summon zombified_piglin ~ ~ ~ {Tags:["suso.nats.count"]}
execute unless predicate suso.nats:dark run summon cat ~ ~ ~ {CatType:9,Tags:["suso.nats.count"]}
```

Instead do:

`ground.mcfunction`
```mcfunction
execute store result score $temp suso.nats if predicate suso.nats:dark
execute if score $temp suso.nats matches 1 run function suso.nats:spawn/ground/dark
execute if score $temp suso.nats matches 0 run function suso.nats:spawn/ground/light
```
`dark.mcfunction`
```mcfunction
execute if score $rng suso.nats matches ..524 run summon wither_skeleton ~ ~ ~ {Tags:["suso.nats.count"]}
execute if score $rng suso.nats matches 525.. run summon zombified_piglin ~ ~ ~ {Tags:["suso.nats.count"]}
```
`light.mcfunction`
```mcfunction
summon cat ~ ~ ~ {CatType:9,Tags:["suso.nats.count"]}
```

### Changing default distances
The system comes configured to spawn mobs in a sphere around players, from 27 to 120 blocks of distance. Ground mobs don't spawn on the exact location the system initially chooses in this range, since we iterate vertically to find the ground (Y±5).

In order to make distance selection as fast as possible, it's implemented with a hardcoded binary search whose functions are generated with a python script included in this repo `suso.nats/data/suso.nats/functions/pos_search/generate.py`. To change the spawn distances, you will need to edit three values at the top of this file and run it to regenerate the functions:
- `BITS` determines the resolution/precision of the search. The distance range will be divided in 2^BITS steps. Increasing this value will increase the number of functions generated and the amount of score checks at runtime. By default it's set to 5 (32 steps).
- `MIN_DIST` is the minimum distance spawn attempts will happen at. By default it's set to 27.
- `MAX_DIST` is the maximum distance spawn attempts will happen at. By default it's set to 120.

###### Disclaimer: There is, most likely, an end to the possibilities. Crowdford is not responsible for any damages caused by actions or inactions resulting from any misinterpretations of the statements contained in this file.

## Crediting
This library is licensed under the [Apache License 2.0](https://github.com/5uso/Artificial-Natspawns/blob/main/LICENSE). When using it as part of  your own projects, you must:

- Include [crediting for the library](https://github.com/5uso/Artificial-Natspawns/blob/main/NOTICE) in a way visible to players. This probably fits best into the credits section of your map/datapack in-game, but in case that's impossible it may be done within a text file or documentation distributed with the project.
- Include a copy of the [license](https://github.com/5uso/Artificial-Natspawns/blob/main/LICENSE).

