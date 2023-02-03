extends Area2D

func _on_well_body_entered(body):
	if body.is_in_group("player"):
		var my_destroyer = "player"
		queue_free()
	if body.is_in_group("npc"):
		var my_destroyer = "npc"
