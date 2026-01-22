class_name PlayerJump
extends PlayerState

var jump_attempted: bool = false

func enter() -> void:
	player.velocity.y = player.JUMP_VELOCITY
	player.coyote_jump_available = false
	player.animation_player.play("jump")

func process(_delta: float) -> void:
	jump_attempted = Input.is_action_just_pressed("jump")
	player.horizontal_input = sign(Input.get_axis("move_left", "move_right"))
	# print(player.animation_player.current_animation)


func physics_process(delta: float) -> void:
	# print("In PlayerJump physics_process")
	if player.horizontal_input:
		player.velocity.x = move_toward(player.velocity.x, player.horizontal_input * player.SPEED, player.ACCELERATION * delta)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, (player.FRICTION * delta))
	
	# # Add the gravity and handle jumping
	# if jump_attempted or player.input_buffer.time_left > 0:
	# 	# if player.coyote_jump_available: # If jumping on the ground
	# 	# 	player.velocity.y = player.JUMP_VELOCITY
	# 	# 	player.coyote_jump_available = false
	# 	if jump_attempted: # Queue input buffer if jump was attempted
	# 		player.input_buffer.start()

	# Shorten jump if jump key is released
	if Input.is_action_just_released("jump") and player.velocity.y < 0:
		player.velocity.y = player.JUMP_VELOCITY / 4

	player.move_and_slide()
	
	# Apply gravity and reset coyote jump
	if player.is_on_floor():
		player.coyote_jump_available = true
		player.coyote_timer.stop()
		player.is_dash_used_in_air = false

		if player.horizontal_input != 0:
			finished.emit(RUN)
		else:
			finished.emit(IDLE)
	else:
		if Input.is_action_just_pressed("dash") and not player.is_dash_used_in_air:
			# print("DASH from JUMP")
			player.is_dash_used_in_air = true
			finished.emit(DASH)
			return

		# if player.coyote_jump_available:
		# 	if player.coyote_timer.is_stopped():
		# 		player.coyote_timer.start()

		player.velocity.y += player.calculate_gravity() * delta
		
		if Input.is_action_just_pressed("spell"):
			finished.emit(SPELL)

		if player.velocity.y > 0:
			finished.emit(FALL)
			return

func handle_input(_event: InputEvent) -> void:
	pass

func exit() -> void:
	pass
