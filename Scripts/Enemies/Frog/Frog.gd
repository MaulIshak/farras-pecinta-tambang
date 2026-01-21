class_name Frog
extends Enemy

@onready var floor_detector: RayCast2D = $FloorDetector
@onready var wall_detector: RayCast2D = $WallDetector


func take_damage(amount: int, _hit_position: Vector2 = Vector2.ZERO) -> void:
	base_health -= amount
	pass

func flip_direction() -> void:
	super.flip_direction()
	
	floor_detector.position.x *= -1
	wall_detector.target_position.x *= -1
