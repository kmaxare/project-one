extends KinematicBody2D
onready var animacion = $animation

export var box = 1 # Para animacion de destruccion (Pixel).
var divX = 2 # Para animacion de destruccion (Pixel).
var divY = 2 # Para animacion de destruccion (Pixel).
 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	#animacion.play("idle")
	var collision = move_and_collide(Vector2.DOWN, true, true, true )
	if collision:
		destuirBloque()

func destuirBloque():
	game_handler.points += 3
#	queue_free()
	# <<<Codigo Espageti para animacion de destruccion (Pixel)>>>
	box -= 1
	if box < 0:
		var region = $spr.region_rect
		var texture = $spr.texture
		var sizeX = region.size.x / divX
		var sizeY = region.size.y / divY
		
		for h in range(divY):
			for w in range(divX):
				var rect = Rect2(region.position.x + (sizeX * w), region.position.y + (sizeY * h), sizeX, sizeY)
				var sprite = Sprite.new()
				sprite.texture = texture
				sprite.region_enabled = true
				sprite.region_rect = rect
				sprite.centered = false
				sprite.global_position = $spr.global_position
				var rigid = RigidBody2D.new()
				rigid.add_child(sprite)
				get_parent().add_child(rigid)
				rigid.apply_impulse(Vector2.ZERO, Vector2(rand_range(-50, 50), rand_range(-100, -150)))
		queue_free()
	else:
		$animation.play("hit")
