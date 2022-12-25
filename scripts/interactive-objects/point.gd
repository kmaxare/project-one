extends Area2D

export var value = 1

onready var sprite = $Sprite

func _physics_process(delta):
	if value == 1:
		sprite.frame = 0
	elif value == 2:
		sprite.frame = 1

func _on_point_body_entered(body):
	if body.is_in_group("player"):
		if value == 1:
			Gamehundler.puntos += 1
		elif value == 2:
			Gamehundler.puntos += 3
		queue_free()
