extends KinematicBody2D

var ataque = 2

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.damageReceived(ataque)
