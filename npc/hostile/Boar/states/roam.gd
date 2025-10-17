extends BoarState


var dir: int = 1:
	set(value):
		if (dir != value): # prev is not equal to new then flip the rays mf
			boar.ray_wall.target_position.x *= -1
			boar.ray_floor.position.x *= -1
		dir = value
		

func enter(previous_state_path: String, data := {}) -> void:
	boar.animated_sprite.play("walk")
	dir = [-1, 1].pick_random()
	var t = boar.roam_time
	boar.idle_roam_timer.start(t)
	await boar.idle_roam_timer.timeout
	finished.emit(IDLE)

func physics_update(delta: float) -> void:
	var wall = boar.ray_wall.is_colliding()
	var floo = boar.ray_floor.is_colliding()
	var isok = (not wall) and floo
	if not isok:
		dir = -dir
	boar.animated_sprite.flip_h = dir < 0
	boar.velocity.y += boar.gravity * delta
	boar.velocity.x = dir * boar.move_speed
	boar.move_and_slide()
