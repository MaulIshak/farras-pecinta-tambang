class_name Hitbox
extends Area2D

@export var damage: int = 10
@export var collision_shape: Shape2D
#@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
#
#func _ready() -> void:
	#collision_shape_2d.shape = collision_shape

# Optional: If you want to disable the hitbox temporarily
func set_disabled(is_disabled: bool) -> void:
	for child in get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", is_disabled)
