extends BoarState

var dir = 1:
	set(value):
		dir = value
		boar.flippables.scale.x = dir

func enter(previous_state_path: String, data := {}) -> void:
	boar.animated_sprite.play("run")
	print("ATTACK")
	var _dir = data.get('dir', null)
	assert(_dir, "Direction of attack not provided from state: " + previous_state_path)
	dir = _dir
	
	await get_tree().create_timer(boar.attack_duration).timeout
	finished.emit(IDLE)
	#boar.view_zone.body_exited.connect(_on_view_zone_body_exited)

func physics_update(delta: float) -> void:
	boar.velocity.y += boar.gravity * delta
	boar.velocity.x = boar.attack_speed * dir
	boar.move_and_slide()

#func exit() -> void:
	#boar.view_zone.body_exited.disconnect(_on_view_zone_body_exited)

func _on_view_zone_body_exited(body: Node2D) -> void:
	if body is Player:
		print("EXITED")
		finished.emit(IDLE)
