extends BoarState

func enter(previous_state_path: String, data := {}) -> void:
	boar.animated_sprite.play("idle")
	boar.velocity.x = 0
	var t = boar.idle_time
	boar.idle_roam_timer.start(t)
	await boar.idle_roam_timer.timeout
	finished.emit(ROAM)
	
func physics_update(delta: float) -> void:
	boar.velocity.y += boar.gravity * delta
	boar.move_and_slide()
