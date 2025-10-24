extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.animated_sprite.play("hit")
	player.velocity.y = -player.jump_impulse
	var dir = -sign(player.velocity.x)
	if dir == 0:
		dir = [-1, 1].pick_random()
	player.velocity.x = dir * player.speed
	var count = 0
	while count < 3:
		await player.animated_sprite.animation_looped
		count += 1
	finished.emit(IDLE)
	
func physics_update(_delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.y += player.gravity * _delta
	player.velocity.x = player.speed * input_direction_x
	player.move_and_slide()
