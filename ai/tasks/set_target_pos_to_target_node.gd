extends BTAction

@export var target_node_var: StringName = &'target_node'
@export var target_pos_var: StringName = &'target_pos'
@export var tolerance: float = 10.0

var target_node: Node2D

func _setup() -> void:
	tolerance = tolerance * tolerance

func _enter() -> void:
	target_node = blackboard.get_var(target_node_var)

func _tick(_delta: float) -> Status:
	print(target_node)
	if not is_instance_valid(target_node):
		return FAILURE
	blackboard.set_var(target_pos_var, target_node.global_position)
	return SUCCESS
