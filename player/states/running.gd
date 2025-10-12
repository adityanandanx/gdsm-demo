extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.animated_sprite.play("run")

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	elif Input.is_action_just_pressed("roll"):
		finished.emit(ROLLING, {"inp_dir": input_direction_x})
	elif is_equal_approx(input_direction_x, 0.0):
		finished.emit(IDLE)
		
	if Input.is_action_just_pressed("ui_accept"):
		finished.emit(HIT)
