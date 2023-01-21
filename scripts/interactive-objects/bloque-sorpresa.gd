extends KinematicBody2D
onready var animacion = $animation

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	animacion.play("idle")
	var collision = move_and_collide(Vector2.DOWN, true, true, true )
	if collision:
		destuirBloque()

func destuirBloque():
	Gamehundler.puntos += 3
	queue_free()
