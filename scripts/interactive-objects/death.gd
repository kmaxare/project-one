extends Area2D

func _on_player_death_body_entered(body):
	if body.is_in_group("player"):
		Gamehundler.gameOver()
	elif body.is_in_group("barrel") or body.is_in_group("enemy"):
		body.queue_free()
