class_name Hitbox
extends Area2D

@export var damage: int = 10
@export var collision_shape: Shape2D
var enemies_got_hit = []

# Optional: If you want to disable the hitbox temporarily
func set_disabled(is_disabled: bool) -> void:
	for child in get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", is_disabled)

func _on_area_entered(area: Area2D) -> void:
	var enemy = area.get_parent()
	var myParent = self.get_parent()

	
	if enemy.has_method("take_damage") and !enemies_got_hit.has(enemy) and enemy is not Player:
		enemies_got_hit.push_back(area)
		enemy.take_damage(damage, myParent.global_position)
