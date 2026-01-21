extends FrogState

func enter() -> void:
	character.sprite.play("air")
	character.velocity.x = 100 * character.facing_direction
	character.velocity.y = -200
	

func physics_process(_delta: float) -> void:
	if character.is_on_wall():
		character.velocity.x = 0
		
	if character.velocity.y >= 0:
		finished.emit(FALL)
