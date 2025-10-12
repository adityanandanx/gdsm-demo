extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	player.animated_sprite.play("dead")

func physics_update(delta: float) -> void:
	player.velocity.y += player.gravity * delta
	player.move_and_slide()
