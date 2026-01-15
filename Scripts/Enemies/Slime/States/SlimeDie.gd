class_name EnemyDie
extends SlimeState

func enter() -> void:
	character.velocity.x = 0
	character.animation_player.play("die")
	await character.animation_player.animation_finished
	character.queue_free()

func physics_process(_delta: float) -> void:
	pass