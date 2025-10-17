class_name Boar
extends Hostile

@export var animated_sprite: AnimatedSprite2D
@export var roam_time: float = 4.0
@export var idle_time: float = 1.0
@export var move_speed: float = 100.0

@export var idle_roam_timer: Timer

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


@export var ray_wall: RayCast2D
@export var ray_floor: RayCast2D
@export var wall_check_distance: float = 35.0
@export var floor_check_distance: float = 35.0
@export var floor_check_depth: float = 22.0

func _ready() -> void:
	assert(ray_wall && ray_floor, "Rays not set")
	ray_floor.position.x = floor_check_distance
	ray_floor.target_position.y = floor_check_depth
	ray_wall.target_position.x = wall_check_distance
