class_name HostileGroundT1State
extends State

const IDLE = "Idle"
const ROAM = "Roam"
const ATTACK = "Attack"
const ATTACK_ANTICIPATION = "AttackAnticipation"
const HIT = "Hit"

var actor: HostileGroundT1

func _ready() -> void:
	await owner.ready
	actor = owner as HostileGroundT1
	assert(actor != null, "The BoarState state type must be used only in the boar scene. It needs the owner to be a Boar node.")
