extends KinematicBody2D


var arriba = Vector2.UP
var movi = true

func _process(delta):
	var collision_down = move_and_collide(Vector2.DOWN,true,true,true)
	if collision_down:
		collision_down.collider.has_method("smash")
		queue_free()
		
	var collision_up = move_and_collide(arriba,true,true,movi)
	if collision_up:
		collision_up.collider.has_method("smash")
		yield(get_tree().create_timer(2),"timeout")
		arriba = Vector2(0,50)
		movi = false

