class_name DamageZone
extends Area2D

@export var damage_amt: float = 20.0


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.damage(damage_amt)
