class_name Enemy
extends CharacterBody2D

@export var speed: float = 60.0
@export var gravity: float = 980.0
@export var base_health: int = 30

@onready var state_machine: StateMachine = $StateMachine
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var facing_direction: int = -1

func take_damage(amount: int, _hit_position: Vector2 = Vector2.ZERO) -> void:
	print("This ", self, " Should taken ", amount, " damage")

func _physics_process(delta: float) -> void:
	# Apply Gravity globally
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()

func flip_direction() -> void:
	facing_direction *= -1
	sprite.flip_h = (facing_direction == -1)
