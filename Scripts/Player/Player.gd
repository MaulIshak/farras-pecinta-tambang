class_name Player
extends CharacterBody2D

# ------------ CONSTANTS ------------
const SPEED = 300.0 # Base horizontal movement speed
const ACCELERATION = 1500.0 # Base acceleration
const FRICTION = 1400.0 # Base friction
const GRAVITY = 2000.0 # Gravity when moving upwards
const FALL_GRAVITY = 2000.0 # Gravity when falling downwards
const JUMP_VELOCITY = -600.0 # Maximum jump strength
const DASH_SPEED_MULTIPLIER = 2.5
const DASH_DURATION: float = 0.2
const INPUT_BUFFER_PATIENCE = 0.1 # Input queue patience time
const COYOTE_TIME = 0.08 # Coyote patience time
const GHOST_SPAWN_INTERVAL = 0.035 # Interval between ghost spawns during dash

# ------------ VARIABLES ------------
var horizontal_input: float = 0.0
var input_buffer: Timer # Reference to the input queue timer
var coyote_timer: Timer # Reference to the coyote timer
var coyote_jump_available := true
var ghost_timer: Timer
var is_dash_used_in_air: bool = false

var dash_ghost_sprite: PackedScene

var currentAttackCombo: int = 0
var attack_buffered: bool = false
# var attack_held: bool = false
var base_scale: Vector2 = Vector2(1.5, 1.5)

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var basicAttackRateTimer: Timer = $BasicAttackRateTimer
@onready var basicAttackComboTimer: Timer = $BasicAttackComboTimer


@export var base_damage: int = 10


func _ready() -> void:
	dash_ghost_sprite = preload("res://Scenes/dash_ghost.tscn")
	# Set up input buffer timer
	input_buffer = Timer.new()
	input_buffer.wait_time = INPUT_BUFFER_PATIENCE
	input_buffer.one_shot = true
	add_child(input_buffer)
	dash_ghost_sprite = preload("res://Scenes/dash_ghost.tscn")
	# Set up input buffer timer
	input_buffer = Timer.new()
	input_buffer.wait_time = INPUT_BUFFER_PATIENCE
	input_buffer.one_shot = true
	add_child(input_buffer)
	# Set up ghost timer
	ghost_timer = Timer.new()
	ghost_timer.wait_time = GHOST_SPAWN_INTERVAL
	add_child(ghost_timer)
	ghost_timer.timeout.connect(_add_ghost_on_timeout)
	
	# Set up coyote timer
	coyote_timer = Timer.new()
	coyote_timer.wait_time = COYOTE_TIME
	coyote_timer.one_shot = true
	add_child(coyote_timer)
	coyote_timer.timeout.connect(coyote_timeout)
	# Set up ghost timer
	ghost_timer = Timer.new()
	ghost_timer.wait_time = GHOST_SPAWN_INTERVAL
	add_child(ghost_timer)
	ghost_timer.timeout.connect(_add_ghost_on_timeout)
	
	# Set up coyote timer
	coyote_timer = Timer.new()
	coyote_timer.wait_time = COYOTE_TIME
	coyote_timer.one_shot = true
	add_child(coyote_timer)
	coyote_timer.timeout.connect(coyote_timeout)

func _process(_delta: float) -> void:
	pass
	# attack_held = Input.is_action_pressed("attack")

	# if attack_held:
	# 	attack_buffered = true

	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		attack_buffered = true


## Returns the gravity based on the state of the player
func calculate_gravity() -> float:
	return GRAVITY if velocity.y < 0 else FALL_GRAVITY

## Reset coyote jump
func coyote_timeout() -> void:
	coyote_jump_available = false

func _add_ghost_on_timeout() -> void:
	# print("Adding dash ghost")
	var ghost: Sprite2D = dash_ghost_sprite.instantiate()
	ghost.position = position
	ghost.flip_h = sprite.scale.x < 0
	ghost.texture = sprite.texture
	ghost.modulate = sprite.modulate
	get_parent().add_child(ghost)


func _on_basic_attack_combo_timer_timeout() -> void:
	currentAttackCombo = 0


func _on_hitbox_area_entered(area: Area2D) -> void:
	area.take_damage(base_damage)
