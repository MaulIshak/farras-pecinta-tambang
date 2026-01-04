class_name StateMachine
extends Node

@export var initial_state: State = null

@onready var current_state: State = (func get_initial_state() -> State:
    return initial_state if initial_state != null else get_child(0)
).call()

var player: CharacterBody2D

func _ready() -> void:
    for child in get_children():
        if child is State:
            child.machine = self
            child.finished.connect(change_state)
        
    if current_state:
        current_state.enter()

func _process(delta: float):
    if current_state:
        current_state.process(delta)
    
func _physics_process(delta: float):
    if current_state:
        current_state.physics_process(delta)

func _unhandled_input(event: InputEvent) -> void:
    if current_state:
        current_state.handle_input(event)

func change_state(new_state_path: String) -> void:
    if current_state:
        current_state.exit()

    var new_state: State = get_node(new_state_path)

    if new_state and new_state is State:
        current_state = new_state
        add_child(current_state)
        current_state.enter()
    else:
        push_error("StateMachine: State '%s' not found or is not a State." % new_state_path)