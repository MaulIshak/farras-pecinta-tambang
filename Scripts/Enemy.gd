extends CharacterBody2D

@export var base_health: int = 100
@onready var animation_player: AnimationPlayer = $AnimationPlayer



func take_damage(damage_amount: int) -> void:
	animation_player.play("hit")
	base_health -= damage_amount
	if base_health <= 0:
		die()
	

func die() -> void:
	queue_free()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hit":
		animation_player.play("idle")
