class_name PlayerDash
extends PlayerState


var direction: float = 0.0
var current_dash_duration: float

func enter() -> void:
    print(player.is_dash_used_in_air)
    player.velocity.y = 0
    current_dash_duration = player.DASH_DURATION
    direction = sign(Input.get_axis("move_left", "move_right"))
    player.animation_player.play("dash")
    player.ghost_timer.start()

func process(_delta: float) -> void:
    current_dash_duration -= _delta
    if player.horizontal_input != 0:
        player.sprite.flip_h = player.horizontal_input < 0

    if current_dash_duration <= 0:
        if player.is_on_floor():
            if player.horizontal_input != 0:
                finished.emit(RUN)
            else:
                finished.emit(IDLE)
        else:
            finished.emit(FALL)
        

func physics_process(_delta: float) -> void:
    if direction != 0:
        player.velocity.x = direction * player.SPEED * player.DASH_SPEED_MULTIPLIER
    else:
        if player.sprite.flip_h:
            player.velocity.x = - player.SPEED * player.DASH_SPEED_MULTIPLIER
        else:
            player.velocity.x = player.SPEED * player.DASH_SPEED_MULTIPLIER

    player.move_and_slide()

    if player.is_on_wall():
        player.velocity.x = 0
        if player.is_on_floor():
            if player.horizontal_input != 0:
                finished.emit(RUN)
            else:
                finished.emit(IDLE)
        else:
            finished.emit(FALL)


func handle_input(_event: InputEvent) -> void:
    pass

func exit() -> void:
    player.ghost_timer.stop()
    player.velocity.x = 0
