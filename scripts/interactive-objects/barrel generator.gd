extends StaticBody2D

var Barrel = load("res://scenes/interactive-objects/barrel.tscn")

func _on_Timer_timeout():
	var barrel = Barrel.instance()
	barrel.position = $Position2D.position
	barrel.add_collision_exception_with(self)
	add_child(barrel)
