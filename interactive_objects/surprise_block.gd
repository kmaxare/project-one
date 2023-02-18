extends KinematicBody2D
onready var animacion = $Animation

export var box = 1 # Para animacion de destruccion (Pixel).
var div_x = 2 # Para animacion de destruccion (Pixel).
var div_y = 2 # Para animacion de destruccion (Pixel).
 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	#animacion.play("idle")
	var collision = move_and_collide(Vector2.DOWN, true, true, true )
	if collision:
		destuirBloque()



func destuirBloque():
	GameHandler.puntos += 3
#	queue_free()
	# <<<Codigo Espageti para animacion de destruccion (Pixel)>>>
	box -= 1
	if box < 0:
		var region = $Sprite.region_rect
		var texture = $Sprite.texture
		var size_x = region.size.x / div_x
		var size_y = region.size.y / div_y
		
		for h in range(div_y):
			for w in range(div_x):
				var rect = Rect2(region.position.x + (size_x * w), region.position.y + (size_y * h), size_x, size_y)
				var sprite = Sprite.new()
				sprite.texture = texture
				sprite.region_enabled = true
				sprite.region_rect = rect
				sprite.centered = false
				sprite.global_position = $Sprite.global_position
				var rigid = RigidBody2D.new()
				rigid.add_child(sprite)
				get_parent().add_child(rigid)
				rigid.apply_impulse(Vector2.ZERO, Vector2(rand_range(-50, 50), rand_range(-100, -150)))
		queue_free()
	else:
		$Animation.play("hit")



















