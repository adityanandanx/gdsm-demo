extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.y = 0
	player.velocity.x = 0
	pass
	
func physics_update(delta: float) -> void:
	player.velocity.y += player.gravity * delta * (1/player.wall_grab_strength)
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * input_direction_x
	player.move_and_slide()
	
	if not player.is_on_wall():
		finished.emit(FALLING)
	if Input.is_action_just_pressed("jump"):
		player.velocity.x = player.get_wall_normal().x * player.wall_jump_speed
		player.velocity.y = -player.wall_jump_impulse
		finished.emit(WALLJUMP)
