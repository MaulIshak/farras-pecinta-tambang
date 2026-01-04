class_name PlayerIdle
extends PlayerState

func enter() -> void:
    player.velocity.x = 0
    player.animation_player.play("idle")
        
func process(_delta: float) -> void:
    player.horizontal_input = sign(Input.get_axis("move_left", "move_right"))
    if player.horizontal_input != 0:
        finished.emit(RUN)
    elif Input.is_action_just_pressed("jump"):
        finished.emit(JUMP)
    elif Input.is_action_just_pressed("dash"):
        finished.emit(DASH)

func physics_process(_delta: float) -> void:
    player.velocity.y += player.calculate_gravity() * _delta
    player.move_and_slide()

func handle_input(_event: InputEvent) -> void:
    pass

func exit() -> void:
    player.animation_player.stop()
