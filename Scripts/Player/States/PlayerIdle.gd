class_name PlayerIdle
extends PlayerState

func enter() -> void:
    print("Entering Idle State")

func process(_delta: float) -> void:
    print("Processing Idle State")
    pass
func physics_process(_delta: float) -> void:
    pass
func handle_input(_event: InputEvent) -> void:
    pass
func exit() -> void:
    pass
