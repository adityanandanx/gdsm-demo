extends HostileGroundT1State

func enter(previous_state_path: String, data := {}) -> void:
	actor.animated_sprite.play('attack_anticipate')
	print("ANTICIPATE")
	await get_tree().create_timer(actor.attack_anticipation_duration).timeout
	finished.emit(ATTACK, data)
	
func physics_update(delta: float) -> void:
	actor.velocity.y += actor.gravity * delta
	actor.velocity.x = 0
	actor.move_and_slide()
