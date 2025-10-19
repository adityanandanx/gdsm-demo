extends HostileGroundT1State

func enter(previous_state_path: String, data := {}) -> void:
	actor.view_zone.body_entered.connect(_on_view_zone_body_entered)
	actor.animated_sprite.play("idle")
	actor.velocity.x = 0
	var t = actor.idle_time
	actor.idle_roam_timer.start(t)
	await actor.idle_roam_timer.timeout
	finished.emit(ROAM)
	
func physics_update(delta: float) -> void:
	actor.velocity.y += actor.gravity * delta
	actor.move_and_slide()

func exit() -> void:
	actor.idle_roam_timer.stop()
	actor.view_zone.body_entered.disconnect(_on_view_zone_body_entered)

func _on_view_zone_body_entered(body: Node2D) -> void:
	print("LKJSLDFKJ")
	if body is Player:
		finished.emit(ATTACK_ANTICIPATION, {"dir": 1 if actor.global_position.x < body.global_position.x else -1 })
	pass
