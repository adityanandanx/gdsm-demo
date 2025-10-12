extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.y = -player.wall_jump_impulse
	player.velocity.x = sign(player.get_wall_normal().x) * player.wall_jump_speed
	player.animated_sprite.play("jump")

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta * 0.5
	if Input.is_action_just_released("jump"):
		player.velocity.y *= player.jump_cut_multiplier
	player.move_and_slide()

	if Input.is_action_just_pressed("roll"):
		finished.emit(ROLLING, {"inp_dir": player.get_last_motion().x})
	if player.velocity.y >= 0:
		finished.emit(FALLING)
