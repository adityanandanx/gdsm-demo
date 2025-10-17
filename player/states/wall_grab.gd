extends PlayerState

var grabbed: bool = true
var grab_off_delay: float = 2.0

var grab_off_time: float = 0.0

func enter(previous_state_path: String, data := {}) -> void:
	pass
	
func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	var wall_normal = player.get_wall_normal()
	
	player.move_and_slide()
	
	if player.is_on_wall_only():
		player.velocity.y += player.gravity * delta * (1/player.wall_grab_strength)
		if Input.is_action_just_pressed("jump"):
			finished.emit(WALLJUMP)
	else:
		finished.emit(FALLING)
	
	if player.is_on_floor():
		finished.emit(IDLE)
			
