extends Node2D

func flip(dir: int):
	if (dir):
		$Directed.scale.x = sign(dir)
