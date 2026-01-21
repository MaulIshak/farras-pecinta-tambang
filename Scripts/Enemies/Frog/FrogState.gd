class_name FrogState
extends State

var character: Frog

const HOP = "Hop"
const FALL = "Fall"
const IDLE = "Idle"
const PREPARE_HOP = "PrepareHop"

func _ready() -> void:
	await owner.ready
	var my = owner
	character = my as Frog
	assert(character != null, "Frog state is not a frog")
