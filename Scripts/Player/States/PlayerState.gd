class_name PlayerState
extends State

var player: Player

const IDLE = "Idle"
const RUN = "Run"
const JUMP = "Jump"
const DASH = "Dash"

func _ready() -> void:
    await owner.ready
    if owner is Player:
        player = owner
    else:
        push_error("PlayerState must be a child of Player node.")


# func _init(player: CharacterBody2D) -> void:
#     self.player = player
