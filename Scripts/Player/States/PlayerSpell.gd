class_name PlayerSpell
extends PlayerState

@export var projectile_scene: PackedScene
@export var cast_duration: float = 0.3 # How long the player freezes
@export var recoil_strength: float = 300.0 # Pushback force

var cast_timer: Timer

func enter() -> void:
	# 1. SETUP TIMER
	cast_timer = Timer.new()
	cast_timer.wait_time = cast_duration
	cast_timer.one_shot = true
	add_child(cast_timer)
	cast_timer.start()
	cast_timer.timeout.connect(_on_cast_finished)
	
	# 2. STALL: Kill all vertical momentum immediately (Gravity Freeze)
	player.velocity.y = 0
	player.velocity.x = 0
	
	# 3. FIRE & RECOIL
	fire_spell()

func process(_delta: float) -> void:
	pass
	
func physics_process(delta: float) -> void:
	# 4. SLIDE TO STOP
	# We use the FRICTION constant from your Player script
	player.velocity.x = move_toward(player.velocity.x, 0, player.FRICTION * delta)
	
	# 5. GRAVITY SUSPENSION
	# We specifically DO NOT call player.calculate_gravity() here.
	# We keep Y velocity at 0 to create the "float" effect.
	player.velocity.y = 0
	
	player.move_and_slide()

func handle_input(_event: InputEvent) -> void:
	pass

func exit() -> void:
	# Cleanup timer to prevent memory leaks if we exit early
	if cast_timer:
		cast_timer.queue_free()

func fire_spell() -> void:
	# Determine facing direction (Assumes sprite.flip_h = true is LEFT)
	var facing_dir = -1.0 if player.sprite.scale.x < 0 else 1.0
	
	# A. Spawn Projectile
	if projectile_scene:
		var projectile = projectile_scene.instantiate()
		projectile.position = player.position
		projectile.direction = facing_dir # Pass direction to bullet

		var projectileSprite: Sprite2D = projectile.get_node("Sprite2D")
		projectileSprite.scale.x *= facing_dir

		get_tree().current_scene.add_child(projectile)
	else:
		print("No Projectile Scene assigned in Inspector!")

	# B. Apply Recoil (Push opposite to facing direction)
	player.velocity.x = - facing_dir * recoil_strength
	
func _on_cast_finished() -> void:
	# Return to Fall if in air, Idle if on ground
	# (Adjust state names string/enum based on your State Machine setup)
	if player.is_on_floor():
		finished.emit("Idle")
	else:
		finished.emit("Fall")
