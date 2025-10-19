extends HostileGroundT1State


var dir: int = 1:
	set(value):
		dir = value
		actor.flippables.scale.x = dir
		

func enter(previous_state_path: String, data := {}) -> void:
	actor.view_zone.body_entered.connect(_on_view_zone_body_entered)
	actor.animated_sprite.play("walk")
	dir = [-1, 1].pick_random()
	var t = actor.roam_time
	actor.idle_roam_timer.start(t)
	await actor.idle_roam_timer.timeout
	finished.emit(IDLE)

func physics_update(delta: float) -> void:
	var wall = actor.ray_wall.is_colliding()
	var floo = actor.ray_floor.is_colliding()
	var isok = (not wall) and floo
	if not isok:
		dir = -dir
	#actor.animated_sprite.flip_h = dir < 0
	actor.velocity.y += actor.gravity * delta
	actor.velocity.x = dir * actor.move_speed
	actor.move_and_slide()

func exit() -> void:
	actor.idle_roam_timer.stop()
	actor.view_zone.body_entered.disconnect(_on_view_zone_body_entered)

func _on_view_zone_body_entered(body: Node2D) -> void:
	if body is Player:
		finished.emit(ATTACK_ANTICIPATION, {"dir": 1 if actor.global_position.x < body.global_position.x else -1})
	pass
