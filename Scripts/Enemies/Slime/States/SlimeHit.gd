class_name EnemyHit
extends SlimeState

@export var recoil_strength: float = 150.0

func enter() -> void:
	character.animation_player.play("hit")
	var direction_to_last_hit = character.global_position.direction_to(character.last_hit_position)
	print(character.global_position, character.last_hit_position)
	print(direction_to_last_hit)
	var dir = -1 if direction_to_last_hit.x >= 0 else 1
	# Knockback effect
	character.velocity.x = dir * recoil_strength
	
	# Connect to animation finished signal specifically for this state
	if not character.animation_player.animation_finished.is_connected(_on_animation_finished):
		character.animation_player.animation_finished.connect(_on_animation_finished)

func physics_process(delta: float) -> void:
	character.velocity.x = move_toward(character.velocity.x, 0, delta)

func exit() -> void:
	if character.animation_player.animation_finished.is_connected(_on_animation_finished):
		character.animation_player.animation_finished.disconnect(_on_animation_finished)

func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "hit":
		finished.emit("Patrol")
