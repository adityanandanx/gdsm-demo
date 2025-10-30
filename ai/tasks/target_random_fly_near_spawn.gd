extends BTAction

@export var target_pos_var: StringName = &'target_pos'
@export var max_distance: float = 200.0
@export var min_distance: float = 100.0

var spawn_pos: Vector2

func _setup() -> void:
	spawn_pos = agent.global_position

func _enter() -> void:
	var angle = randf() * TAU
	var mag = randf_range(min_distance, max_distance)
	var t = Vector2(mag * cos(angle), mag * sin(angle))
	blackboard.set_var(target_pos_var, t + spawn_pos)
	print(spawn_pos + t)
	
func _tick(_delta: float) -> Status:
	return SUCCESS
