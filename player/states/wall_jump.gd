extends PlayerState

@export var thrust: Vector2 = Vector2(400, -500)

func enter (previous_state_path: String, data: Dictionary = {}) -> void:
	var direction = -1 if player.animated_sprite.flip_h else 1
	player.velocity.x = thrust.x * -direction
	player.velocity.y = thrust.y
	
	await get_tree().create_timer(0.1).timeout
	finished.emit(FALLING)

func physics_update(_delta: float) -> void:
	player.velocity.y += player.gravity * _delta / 2
	player.move_and_slide()
