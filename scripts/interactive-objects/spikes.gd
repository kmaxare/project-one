extends Area2D

export var damage_spikes = 1


func _on_spikes_body_entered(body):
	if body.is_in_group("player"):
		body.damageReceived(damage_spikes, global_position)
