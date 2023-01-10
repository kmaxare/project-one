extends KinematicBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var collision = move_and_collide(Vector2.DOWN, true, true, true )
	if collision:
		destuirBloque()

func destuirBloque():
	queue_free()
