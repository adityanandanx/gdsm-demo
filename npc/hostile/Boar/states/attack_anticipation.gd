extends BoarState

func enter(previous_state_path: String, data := {}) -> void:
	boar.animated_sprite.play('hit')
	print("ANTICIPATE")
	boar.attack_anticipation_timer.start(boar.attack_anticipation_duration)
	await boar.attack_anticipation_timer.timeout
	finished.emit(ATTACK, data)
	
func physics_update(delta: float) -> void:
	boar.velocity.y += boar.gravity * delta
	boar.velocity.x = 0
	boar.move_and_slide()
	
func exit() -> void:
	boar.attack_anticipation_timer.stop()
