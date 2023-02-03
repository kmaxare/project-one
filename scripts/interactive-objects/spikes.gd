extends Area2D


func _on_spikes_body_entered(body):
	if body.is_in_group("player"):
		Gamehundler.puntos =- 1
