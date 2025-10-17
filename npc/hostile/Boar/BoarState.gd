class_name BoarState
extends State

const IDLE = "Idle"
const ROAM = "Roam"
const ATTACK = "Attack"
const ATTACK_ANTICIPATION = "AttackAnticipation"
const HIT = "Hit"

var boar: Boar

func _ready() -> void:
	await owner.ready
	boar = owner as Boar
	assert(boar != null, "The BoarState state type must be used only in the boar scene. It needs the owner to be a Boar node.")
