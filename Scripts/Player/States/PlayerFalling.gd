class_name PlayerFalling
extends PlayerState

func enter() -> void:
	player.animation_player.play("fall")

func process(_delta: float) -> void:
    player.horizontal_input = sign(Input.get_axis("move_left", "move_right"))
    if player.horizontal_input > 0:
        player.sprite.scale.x = player.base_scale.x
    elif player.horizontal_input < 0:
        player.sprite.scale.x = -player.base_scale.x

func physics_process(delta: float) -> void:
	player.velocity.y += player.calculate_gravity() * delta
	var floor_damping: float = 1.0 if player.is_on_floor() else 0.2 # Set floor damping, friction is less when in air
	if player.horizontal_input:
		player.velocity.x = move_toward(player.velocity.x, player.horizontal_input * player.SPEED, player.ACCELERATION * delta)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, (player.FRICTION * delta) * floor_damping)

	player.move_and_slide()

	if player.is_on_floor():
		player.is_dash_used_in_air = false
		if player.horizontal_input != 0:
			finished.emit(RUN)
		else:
			finished.emit(IDLE)
	else:
		if Input.is_action_just_pressed("dash") and not player.is_dash_used_in_air:
			# print("DASH from FALL")
			player.is_dash_used_in_air = true
			finished.emit(DASH)
		if Input.is_action_just_pressed("spell"):
			finished.emit(SPELL)

func handle_input(_event: InputEvent) -> void:
	pass

func exit() -> void:
	pass
