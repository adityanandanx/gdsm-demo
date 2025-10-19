extends BoarState


var dir: int = 1:
	set(value):
		dir = value
		boar.flippables.scale.x = dir
		

func enter(previous_state_path: String, data := {}) -> void:
	boar.view_zone.body_entered.connect(_on_view_zone_body_entered)
	boar.animated_sprite.play("walk")
	dir = [-1, 1].pick_random()
	var t = boar.roam_time
	boar.idle_roam_timer.start(t)
	await boar.idle_roam_timer.timeout
	finished.emit(IDLE)

func physics_update(delta: float) -> void:
	var wall = boar.ray_wall.is_colliding()
	var floo = boar.ray_floor.is_colliding()
	var isok = (not wall) and floo
	if not isok:
		dir = -dir
	#boar.animated_sprite.flip_h = dir < 0
	boar.velocity.y += boar.gravity * delta
	boar.velocity.x = dir * boar.move_speed
	boar.move_and_slide()

func exit() -> void:
	boar.idle_roam_timer.stop()
	boar.view_zone.body_entered.disconnect(_on_view_zone_body_entered)

func _on_view_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		finished.emit(ATTACK_ANTICIPATION, {"dir": 1 if boar.global_position.x < body.global_position.x else -1})
	pass
