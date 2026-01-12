class_name EnemyHit
extends SlimeState

@export var recoil_strength: float = 150.0

func enter() -> void:
	character.animation_player.play("hit")
	# Knockback effect
	character.velocity.x = - character.facing_direction * recoil_strength
	
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
