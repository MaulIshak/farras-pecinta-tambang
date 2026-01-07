class_name PlayerRun
extends PlayerState


func enter() -> void:
	player.animation_player.play("run")
	pass
	

func process(_delta: float) -> void:
	player.horizontal_input = sign(Input.get_axis("move_left", "move_right"))
	if player.horizontal_input == 0:
		finished.emit(IDLE)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMP)
	elif Input.is_action_just_pressed("dash"):
		finished.emit(DASH)
	elif Input.is_action_just_pressed("spell"):
		finished.emit(SPELL)
	elif not player.is_on_floor():
		finished.emit(FALL)

	if player.horizontal_input > 0:
		player.sprite.flip_h = false
	elif player.horizontal_input < 0:
		player.sprite.flip_h = true

func physics_process(delta: float) -> void:
	player.velocity.y += player.calculate_gravity() * delta

	var floor_damping: float = 1.0 if player.is_on_floor() else 0.2 # Set floor damping, friction is less when in air

	if player.horizontal_input:
		player.velocity.x = move_toward(player.velocity.x, player.horizontal_input * player.SPEED, player.ACCELERATION * delta)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, (player.FRICTION * delta) * floor_damping)

	player.move_and_slide()

func handle_input(_event: InputEvent) -> void:
	pass

func exit() -> void:
	player.animation_player.stop()
