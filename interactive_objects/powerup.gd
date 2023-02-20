extends Area2D

export var extra_time = 10

func _on_powerup_body_entered(body):
	$AnimationPlayer.play("collected") # Para animacion (Pixel).
	if body.is_in_group("player"):
		game_handler.time += extra_time
#		queue_free() # Se pasa a animation_finished (Pixel).

# Codigo espageti de Pixel.
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "collected":
		queue_free()
