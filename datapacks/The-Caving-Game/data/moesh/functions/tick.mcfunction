#---------------------------------------------------------------------------------------------------
# Purpose: Always tick these functions
#---------------------------------------------------------------------------------------------------
# Any function here usually has it's own handling for lobby time and match time.
execute as @a[tag=!Registered] run function moesh:player/reset
execute as @a[tag=!Registered] run tellraw @s {"text":"Welcome to The Caving Game!"}
execute as @a[tag=!Registered] run tag @s add Registered
execute as @a[scores={leaveGame=1..}] at @s run function moesh:player/left_game

#---------------------------------------------------------------------------------------------------
# Purpose: Tick these functions during the lobby stage
#---------------------------------------------------------------------------------------------------


#---------------------------------------------------------------------------------------------------
# Purpose: Tick these functions during the match
#---------------------------------------------------------------------------------------------------
# Let players run a GG command to end a game early
# This next line is essentially protection of players against themselves. They can use
# /trigger set gg 0, therefore disabling the gg trigger for themselves. 
execute if score GameState gameVariable matches 1 run scoreboard players enable @a[scores={gg=..0}] gg
execute if score GameState gameVariable matches 1 run scoreboard players set @a[scores={gg=..0}] gg 0
execute if entity @a[scores={gg=1..}] if score GameState gameVariable matches 1 run function moesh:game/gg

# Prevent players from leaving the play area
execute as @a at @s unless entity @s[gamemode=spectator] if score GameState gameVariable matches 1 run function moesh:game/out_of_bounds

#---------------------------------------------------------------------------------------------------
# Purpose: Tick these functions after the match
#---------------------------------------------------------------------------------------------------
# Let players look at the map before resetting it. It must be done manually.
scoreboard players set @a[scores={reset=..-1}] reset 0
scoreboard players enable @a[scores={reset=0}] reset
execute if score GameState gameVariable matches 2 if entity @a[scores={reset=1..}] run function moesh:reset