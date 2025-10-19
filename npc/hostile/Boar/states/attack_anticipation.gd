extends BoarState

func enter(previous_state_path: String, data := {}) -> void:
	boar.animated_sprite.play('attack_anticipate')
	print("ANTICIPATE")
	await get_tree().create_timer(boar.attack_anticipation_duration).timeout
	finished.emit(ATTACK, data)
	
func physics_update(delta: float) -> void:
	boar.velocity.y += boar.gravity * delta
	boar.velocity.x = 0
	boar.move_and_slide()
