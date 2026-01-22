extends FrogState

func enter() -> void:
	character.sprite.play("fall")
	
func physics_process(_delta: float) -> void:
	if character.is_on_floor():
		finished.emit(IDLE)
