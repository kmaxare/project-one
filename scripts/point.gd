extends Area2D

func _on_point_body_entered(body):
	if body.is_in_group("player"):
		Gamehundler.puntos = Gamehundler.puntos + 1
		queue_free()
