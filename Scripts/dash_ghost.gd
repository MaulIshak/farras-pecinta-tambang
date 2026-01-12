extends Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ghosting()


func ghosting() -> void:
	var tween_fade: Tween = get_tree().create_tween()
	tween_fade.tween_property(self, "modulate:a", 0.0, 0.3)
	await tween_fade.finished
	queue_free()
