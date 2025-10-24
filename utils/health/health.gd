class_name Health
extends Area2D

@export var max_health: int = 100
@export var value: int = 100:
	set(new):
		value = clamp(new, 0, max_health)
		if value == 0:
			death.emit()

signal death
signal damaged(amt: int, from_dir: int)

func damage(amt: int, from_dir: int = 0):
	value -= amt
	damaged.emit(amt, from_dir)
