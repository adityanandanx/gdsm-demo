extends BTAction

@export var target_pos_var: StringName = &'target_pos'
@export var tolerance: float = 10.0
@export var speed: float = 100.0

func _tick(delta: float) -> Status:
	#agent = agent as Node2D
	var target_pos: Vector2 = blackboard.get_var(target_pos_var)
	if agent.global_position.distance_to(target_pos) <= tolerance:
		return SUCCESS
	var dir = agent.global_position.direction_to(target_pos)
	var velocity = dir * speed
	agent.global_position += velocity * delta
	if agent.has_method(&'flip'):
		agent.flip(dir.x)
	return RUNNING
