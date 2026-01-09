class_name SpellProjectile
extends Node2D

var speed: float = 800.0
var direction: float = 1.0 # 1 for right, -1 for left
var lifetime: float = 1.0

func _ready() -> void:
	# Delete bullet after lifetime ends
	get_tree().create_timer(lifetime).timeout.connect(queue_free)


func _physics_process(delta: float) -> void:
	position.x += speed * direction * delta
