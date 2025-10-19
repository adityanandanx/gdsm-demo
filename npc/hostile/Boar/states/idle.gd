extends BoarState

func enter(previous_state_path: String, data := {}) -> void:
	boar.view_zone.body_entered.connect(_on_view_zone_body_entered)
	boar.animated_sprite.play("idle")
	boar.velocity.x = 0
	var t = boar.idle_time
	boar.idle_roam_timer.start(t)
	await boar.idle_roam_timer.timeout
	finished.emit(ROAM)
	
func physics_update(delta: float) -> void:
	boar.velocity.y += boar.gravity * delta
	boar.move_and_slide()

func exit() -> void:
	boar.idle_roam_timer.stop()
	boar.view_zone.body_entered.disconnect(_on_view_zone_body_entered)

func _on_view_zone_body_entered(body: Node2D) -> void:
	print("LKJSLDFKJ")
	if body is Player:
		finished.emit(ATTACK_ANTICIPATION, {"dir": 1 if boar.global_position.x < body.global_position.x else -1 })
	pass
