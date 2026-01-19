class_name EnemyPatrol
extends SlimeState

func enter() -> void:
	character.animation_player.play("idle")

func physics_process(_delta: float) -> void:
	# 1. Apply Velocity
	character.velocity.x = character.speed * character.facing_direction
	
	# 2. Check for Turnaround Conditions
	# A. Hit a wall?
	if character.wall_detector.is_colliding():
		character.flip_direction()
		
	# B. About to fall off a ledge?
	# (Only check if we are actually on the floor, so we don't flip mid-air)
	if character.is_on_floor() and not character.floor_detector.is_colliding():
		character.flip_direction()
