extends Area2D

export var extra_time = 10

func _on_powerup_body_entered(body):
	if body.is_in_group("player"):
		Gamehundler.tiempo += extra_time
		queue_free()
