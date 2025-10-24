extends PlayerState

@onready var attack_hitbox: Area2D = %AttackHitbox

var og_color: Color

func enter(previous_state_path: String, data := {}) -> void:
	og_color = attack_hitbox.get_child(0).debug_color
	attack_hitbox.monitoring = true
	attack_hitbox.get_child(0).debug_color = Color(0.865, 0.0, 0.275, 1.0)
	player.animated_sprite.play('roll')
	%AnimationPlayer.play('attack')
	await %AnimationPlayer.animation_finished
	finished.emit(IDLE)


func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.move_and_slide()

	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(JUMPING)
		
	if Input.is_action_just_pressed("ui_accept"):
		finished.emit(HIT)


func exit() -> void:
	attack_hitbox.monitoring = false
	attack_hitbox.get_child(0).debug_color = og_color
#
#func _on_body_entered(body: Node2D):
	#var health_component = body.get_node_or_null('Health') as Health
	#if health_component and not body.is_in_group('player'):
		#var from_dir = 1 if body.global_position.x < player.global_position.x else -1
		#health_component.damage(10, from_dir)


func _on_attack_hitbox_area_entered(area: Area2D) -> void:
	if area is Health:
		var from_dir = 1 if area.owner.global_position.x < player.global_position.x else -1
		area.damage(10, from_dir)
