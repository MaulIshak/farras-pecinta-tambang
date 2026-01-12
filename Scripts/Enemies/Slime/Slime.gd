class_name Slime
extends CharacterBody2D

@export var speed: float = 60.0
@export var gravity: float = 980.0
@export var base_health: int = 30

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: StateMachine = $StateMachine
@onready var sprite: Sprite2D = $Sprite2D
@onready var wall_detector: RayCast2D = $WallDetector
@onready var floor_detector: RayCast2D = $FloorDetector

# 1 is Right, -1 is Left
var facing_direction: int = -1

func _ready() -> void:
	pass
	# Initialize the State Machine

func _physics_process(delta: float) -> void:
	# Apply Gravity globally
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()

func take_damage(amount: int) -> void:
	base_health -= amount
	if base_health <= 0:
		die()
	else:
		print("Slime is taking damage :<")
		state_machine.change_state(SlimeState.HIT)

func die() -> void:
	queue_free()

func flip_direction() -> void:
	facing_direction *= -1
	sprite.flip_h = (facing_direction == -1)
	
	# FLIP THE RAYCASTS so they point the new way
	wall_detector.target_position.x *= -1
	floor_detector.position.x *= -1
