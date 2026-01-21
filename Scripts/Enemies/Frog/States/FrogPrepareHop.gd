extends FrogState

func enter() -> void:
	character.sprite.play("prepare_hop")
	await character.sprite.animation_finished
	finished.emit(HOP)

func process(_delta: float) -> void:
	if character.wall_detector.is_colliding():
		character.flip_direction()
		return
	
	if character.is_on_floor() and not character.floor_detector.is_colliding():
		character.flip_direction()
