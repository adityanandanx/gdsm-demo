extends PlayerState

var direction:= Vector2.ZERO

func enter (previous_state_path: String, data: Dictionary = {}) -> void:
	player.animated_sprite.play("wall_grab")
	if player.velocity.y < 0: player.velocity.y = 0


func physics_update(_delta: float) -> void:
	player.velocity.y += player.gravity * _delta * 0.5
	
	var direction = Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * direction

	player.move_and_slide()
	
	if player.is_on_floor():
		finished.emit(IDLE)
	if not player.is_on_wall():
		finished.emit(FALLING)
	if Input.is_action_just_pressed("jump"):
		finished.emit(WALLJUMP)
		
