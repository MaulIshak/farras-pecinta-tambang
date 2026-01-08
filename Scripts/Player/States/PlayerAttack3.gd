class_name PlayerAttack3
extends PlayerState

func enter() -> void:
	player.animation_player.play("attack3")
	player.basicAttackRateTimer.start()
	player.basicAttackComboTimer.stop()
	player.currentAttackCombo = 0
	player.attack_buffered = false

func process(_delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		player.attack_buffered = true

	if player.basicAttackComboTimer.time_left > 0 and player.basicAttackRateTimer.time_left <= 0.001:
		if player.attack_buffered or Input.is_action_pressed("attack"):
			player.attack_buffered = false
			finished.emit(ATTACK1)
			return


	if not player.animation_player.is_playing():
		player.basicAttackRateTimer.stop()
		if player.horizontal_input != 0:
				finished.emit(RUN)
		else:
				finished.emit(IDLE)
				
func physics_process(delta: float) -> void:
	var floor_damping: float = 1.0 if player.is_on_floor() else 0.2
	if player.horizontal_input != 0:
		player.velocity.x = move_toward(player.velocity.x, player.horizontal_input * player.SPEED * 0.25, player.ACCELERATION*5* delta)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, (player.FRICTION * delta) * floor_damping)
	player.velocity.y += player.calculate_gravity() * delta
	player.move_and_slide()


func handle_input(_event: InputEvent) -> void:
	pass

func exit() -> void:
	pass
