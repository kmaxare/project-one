extends Area2D

export var value = 1 # 0 = (+1 punto) / 1 = (+3 puntos)

onready var sprite = $Sprite

func _ready():
	if value == 1:
		sprite.frame = 0
	elif value == 2:
		sprite.frame = 1

func _on_point_body_entered(body):
	$AnimationPlayer.play("collected") # Para animacion (Pixel).
	if body.is_in_group("player"):
		if value == 1:
			GameHandler.puntos += 1
		elif value == 2:
			GameHandler.puntos += 3
#		queue_free() # Se pasa a animation_finished (Pixel).


# Codigo espageti de Pixel.
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "collected":
		queue_free()
