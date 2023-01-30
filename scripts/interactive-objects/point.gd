extends Area2D

export var value = 1 # 0 = (+1 punto) / 1 = (+3 puntos)
export (Texture) var semillaOne
export (Texture) var semillaTwo

onready var sprite = $Sprite

func _ready():
	if value == 1:
		$Sprite.texture = semillaOne
	elif value == 2:
		$Sprite.texture = semillaTwo
		
	$AnimationPlayer.play("anim_idle")

func _on_point_body_entered(body):
	if body.is_in_group("player"):
		if value == 1:
			Gamehundler.puntos += 1
		elif value == 2:
			Gamehundler.puntos += 3
		$AnimationPlayer.play("anim_action")
		yield($AnimationPlayer, "animation_finished")
		queue_free()
