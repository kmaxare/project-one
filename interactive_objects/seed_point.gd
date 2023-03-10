extends Area2D

var type_seed = 0 # 0 = (+1 punto) / 1 = (+3 puntos)
var points_seed = 0

export (Texture) var seed_clear
export (Texture) var seed_dark

func _ready():
	random_point_type()
	set_seed_value()


func random_point_type():
	randomize()
	var rand_point_type = int(rand_range(1, 5))
	if rand_point_type < 2.5:
		type_seed = 1
	else:
		type_seed = 2


func set_seed_value():
	if type_seed == 1:
		$Sprite.texture = seed_clear
		points_seed = 1
	elif type_seed == 2: 
		$Sprite.texture = seed_dark
		points_seed = 3


func _on_point_body_entered(body):
	$AnimationPlayer.play("collected") # Para animacion (Pixel).
	if body.is_in_group("player"):
		game_handler.points += points_seed
#		$Sfx.playing_sfx('')
#		queue_free() # Se pasa a animation_finished (Pixel).


# Codigo espageti de Pixel.
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "collected":
		queue_free()
