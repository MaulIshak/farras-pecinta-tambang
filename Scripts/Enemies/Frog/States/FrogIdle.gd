extends FrogState

func enter() -> void:
	character.velocity = Vector2.ZERO
	character.sprite.play("idle")
	await get_tree().create_timer(randf_range(2, 3)).timeout
	finished.emit(PREPARE_HOP)
	
