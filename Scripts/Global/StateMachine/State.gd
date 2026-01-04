# Base class for all states in the state machine
class_name State
extends Node

var machine: StateMachine

# Emitted when the state is finished and wants to change to another state
signal finished(new_state: State)

func enter() -> void:
    pass
func process(_delta: float) -> void:
    pass
func physics_process(_delta: float) -> void:
    pass
func handle_input(_event: InputEvent) -> void:
    pass
func exit() -> void:
    pass
