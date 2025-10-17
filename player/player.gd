class_name Player
extends CharacterBody2D

@export var speed := 100.0
@export var max_health: int = 100
@export var jump_impulse := 300.0
@export var jump_cut_multiplier := 0.5
@export var max_rolls := 3
@export var roll_speed := 150.0
@export var roll_gravity_factor := 2.0
@export var wall_grab_strength := 10.0
@export var wall_jump_impulse := 500.0
@export var wall_jump_speed := 100.0
@export var animated_sprite: AnimatedSprite2D
@export var state_machine: StateMachine

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


var health: int = max_health:
	set(new):
		health = clamp(new, 0, max_health)

#func _ready() -> void:
	#pass

func _process(_delta: float) -> void:
	if velocity.x < 0:
		animated_sprite.flip_h = true
	elif velocity.x > 0:
		animated_sprite.flip_h = false

func damage(delta: int) -> void:
	health -= delta
	state_machine._transition_to_next_state(PlayerState.HIT)
	await state_machine.state.finished
	if health <= 0:
		die()
		
	
func die() -> void:
	print("DEAD")
	state_machine._transition_to_next_state(PlayerState.DEAD)
