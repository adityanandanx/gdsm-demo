extends HostileGroundT1State

var dir = 1:
	set(value):
		dir = value
		actor.flippables.scale.x = dir

func enter(previous_state_path: String, data := {}) -> void:
	actor.animated_sprite.play("run")
	var _dir = data.get('dir', null)
	assert(_dir, "Direction of attack not provided from state: " + previous_state_path)
	dir = _dir
	
	await get_tree().create_timer(actor.attack_duration).timeout
	finished.emit(IDLE)
	#actor.view_zone.body_exited.connect(_on_view_zone_body_exited)

func physics_update(delta: float) -> void:
	actor.velocity.y += actor.gravity * delta
	actor.velocity.x += dir * actor.move_speed * 2 * delta
	actor.velocity.x = lerp(actor.velocity.x, 0.0, 0.2)
	actor.move_and_slide()

#func exit() -> void:
	#actor.view_zone.body_exited.disconnect(_on_view_zone_body_exited)

func _on_view_zone_body_exited(body: Node2D) -> void:
	if body is Player:
		finished.emit(IDLE)
