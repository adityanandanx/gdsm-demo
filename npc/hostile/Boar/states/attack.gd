extends BoarState

func enter(previous_state_path: String, data := {}) -> void:
	boar.animated_sprite.play("run")
