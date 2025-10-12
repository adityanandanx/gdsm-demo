extends PlayerState

var dir: int = 0

func enter(previous_state_path: String, data := {}) -> void:
	assert(data.has("inp_dir"), "No inp_dir for roll provided, Prev State: " + previous_state_path)
	player.animated_sprite.play("roll")
	var inp_dir = data.get('inp_dir')
	if inp_dir > 0:
		dir = 1
	elif inp_dir < 0:
		dir = -1
	else:
		finished.emit(IDLE)
		return
	var roll_count := 0
	while roll_count < player.max_rolls:
		await player.animated_sprite.animation_looped
		print("ROLL ", roll_count)
		roll_count += 1
	finished.emit(RUNNING)

func physics_update(delta: float) -> void:
	var input_dir_x = Input.get_axis("move_left", "move_right")
	if input_dir_x > 0: dir = 1
	elif input_dir_x < 0: dir = -1
	player.velocity.x = player.roll_speed * dir
	player.velocity.y += player.gravity * delta * player.roll_gravity_factor
	player.move_and_slide()
	
	if player.is_on_wall():
		finished.emit(IDLE)
