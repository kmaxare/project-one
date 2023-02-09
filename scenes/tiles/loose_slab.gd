extends KinematicBody2D

var up = Vector2.UP
var can_move = true

onready var animation = $animation

func _ready():
	animation.play("idle")

func _physics_process(delta):
	collision_check()

func collision_check():
	var collision_down = move_and_collide(Vector2.DOWN, true, true, true)
	if collision_down:
		var collider = collision_down.collider
		if collider.has_method("smash"):
			animation.play("collition_player")
			yield(animation, "animation_finished")
			queue_free()
			
	var collision_up = move_and_collide(Vector2.UP, true, true, true)
	if collision_up:
		var collider = collision_up.collider
		if collider.has_method("smash"):
			animation.play("vibracion")
			yield(get_tree().create_timer(2),"timeout")
			up = Vector2(0, 4)
			can_move = false
		
#se elimina cuando sale de la vista
func _on_Visibility_screen_exited():
	queue_free()
