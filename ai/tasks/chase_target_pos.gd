extends BTAction

@export var speed: float = 100.0
@export var target_pos_key: StringName = &"target_pos"
@export var target_node_key: StringName = &"target_node"
@export var stop_distance := 50.0

var target_pos: Vector2
var target_node: Node2D

func _enter():
	target_pos = blackboard.get_var(target_pos_key)
	target_node = blackboard.get_var(target_node_key)

func _tick(delta: float) -> int:
	# Refresh target node each frame (optional)
	#if target_node and is_instance_valid(target_node):
		#target_pos = target_node.global_position
		#blackboard.set_var(target_pos_key, target_pos)

	if target_pos == null:
		return FAILURE

	var dir = (target_pos - agent.global_position)
	var dist = dir.length()

	if dist <= stop_distance:
		return SUCCESS

	agent.global_position += dir.normalized() * speed * delta
	if agent.has_method(&'flip'):
		agent.flip(dir.x)
	return RUNNING
