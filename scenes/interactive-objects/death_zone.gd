# Extiende la clase Area2D
extends Area2D

# Función llamada cuando un cuerpo que pertenece al grupo "player" entra en el área
func _on_player_death_body_entered(body):
	# Verifica si el cuerpo es parte del grupo "player"
	if body.is_in_group("player"):
		# Llama a la función gameOver en el controlador del juego
		game_handler.game_over()
	# Verifica si el cuerpo pertenece a los grupos "barrel" o "enemy"
	elif body.is_in_group("barrel") or body.is_in_group("enemy"):
		# Elimina el cuerpo de la escena
		body.queue_free()
