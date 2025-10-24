extends HostileGroundT1State

func enter(previous_state_path: String, data := {}) -> void:
	actor.animated_sprite.play('attack_anticipate')
	actor.velocity.x = 0
	await get_tree().create_timer(actor.attack_anticipation_duration).timeout
	finished.emit(ATTACK, data)
	
func physics_update(delta: float) -> void:
	actor.velocity.y += actor.gravity * delta
	if actor.is_on_floor():
		actor.velocity.x = lerp(actor.velocity.x, 0.0, 0.2)
	actor.move_and_slide()
