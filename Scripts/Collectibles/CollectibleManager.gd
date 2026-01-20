# @tool
class_name CollectibleManager
extends Area2D

@onready var sprite_display: Sprite2D = $Sprite2D

@export var data: CollectibleData

func _ready() -> void:
    # if not Engine.is_editor_hint():
    #     body_entered.connect(_on_body_entered)
    _update_texture()

func _update_texture() -> void:
    if data and sprite_display and data.texture:
        sprite_display.texture = data.texture
    elif sprite_display:
        sprite_display.texture = null

func _on_body_entered(body: Node) -> void:
    if not body.is_in_group("Player"):
        return
    if data == null:
        return

    var success = data.apply_effect(body)
    if success:
        if body is Player:
            print("health: " + str(body.health))
            print("damage: " + str(body.base_damage))
        queue_free()
