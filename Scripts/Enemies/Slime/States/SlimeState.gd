class_name SlimeState
extends State

var character: Slime

const PATROL = "Patrol"
const HIT = "Hit"
const DIE = "Die"

func _ready() -> void:
	await owner.ready
	character = owner as Slime
	assert(character != null, "SlimeState does not assigned to Slime")
