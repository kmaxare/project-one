extends KinematicBody2D

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		if Gamehundler.puntos >= 2:
			Gamehundler.puntos -= 2
	else:
		Gamehundler.gameOver()
