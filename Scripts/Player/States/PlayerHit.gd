class_name  PlayerHit
extends PlayerState

@export var stun_duration: float = 0.4
@export var knockback_power: Vector2 = Vector2(400, 300) # X is horizontal push, Y is upward pop
@export var friction_air: float = 800.0 # How fast horizontal momentum decays

var stun_timer: float = 0.0

func enter() -> void:
	print("Entered Hit State")
	stun_timer = stun_duration
	
	# 1. Calculate Direction
	# If the hit came from the RIGHT, we fly LEFT (-1)
	# If the hit came from the LEFT, we fly RIGHT (1)
	var dir_to_enemy = player.global_position.direction_to(player.last_hit_source_position).x
	var knockback_dir = -1 if dir_to_enemy > 0 else 1
	
	# 2. Apply The Arc Physics
	player.velocity.x = knockback_dir * knockback_power.x
	player.velocity.y = -knockback_power.y # Negative Y is UP in Godot
	

func physics_process(delta: float) -> void:
	# 1. Apply Gravity (So we arc downwards)
	player.velocity.y += player.FALL_GRAVITY * delta
	
	# 2. Apply Air Friction (So we don't fly across the whole map)
	player.velocity.x = move_toward(player.velocity.x, 0, friction_air * delta)
	
	player.move_and_slide()
	
	# 3. Timer Logic
	stun_timer -= delta
	if stun_timer <= 0:
		if player.is_on_floor():
			finished.emit("Idle")
		else:
			finished.emit("Fall")

func exit() -> void:
	pass
