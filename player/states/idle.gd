extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.x = 0.0
	player.animated_sprite.play("idle")

func physics_update(_delta: float) -> void:
	#player.velocity.y += player.gravity * _delta
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
	if Input.is_action_just_pressed('attack'):
		finished.emit(ATTACK)
	elif Input.is_action_just_pressed("roll"):
		finished.emit(ROLLING, {"inp_dir": -1 if player.animated_sprite.flip_h else 1})
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		finished.emit(RUNNING)

		
