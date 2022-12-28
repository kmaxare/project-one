extends KinematicBody2D

var run = 100
var jum = -150
var gravity = 300
var velocity = Vector2()

func _input_button():
	velocity.x = 0
	
	if (Input.is_action_pressed("ui_right")):
		velocity.x += run
	if (Input.is_action_pressed("ui_left")):
		velocity.x -= run
	if (Input.is_action_just_pressed("ui_up")):
		velocity.y = jum	

func _physics_process(delta):
	velocity.y += gravity * delta
	_input_button()
	velocity = move_and_slide(velocity, Vector2(0, -1))


func _on_area_body_entered(body):
	if body.is_in_group("foor"):
		var posi: Vector2 = $area/position.global_position
		get_tree().call_group("well", "remove_tile", posi)
