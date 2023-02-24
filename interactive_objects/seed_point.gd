extends Area2D

export var type_seed = 1 # 0 = (+1 punto) / 1 = (+3 puntos)

onready var sprite = $Sprite

export (Texture) var seed_clear
export (Texture) var seed_dark

func _ready():

	if type_seed == 1:
		$Sprite.texture = seed_clear
	elif type_seed == 2: 
		$Sprite.texture = seed_dark
	pass

func _on_point_body_entered(body):
	$AnimationPlayer.play("collected") # Para animacion (Pixel).
	if body.is_in_group("player"):
		if type_seed == 1:
			game_handler.points += 1
		elif type_seed == 2:
			game_handler.points += 3
#		queue_free() # Se pasa a animation_finished (Pixel).


# Codigo espageti de Pixel.
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "collected":
		queue_free()
