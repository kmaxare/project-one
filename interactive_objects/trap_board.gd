extends KinematicBody2D


var arriba = Vector2.UP
var movi = true
var is_active = false # La loza esta activada?

var collision_up
var collision_down

func _ready():
	$AnimationPlayer.play("idle")

func _process(delta):
	collision_up = move_and_collide(arriba,true,true,movi)
	
#	if collision_up:
#		collision_up.collider.has_method("smash")
#		$AnimationPlayer.play("vibracion")
#		yield($AnimationPlayer, "animation_finished")
#		arriba = Vector2(0,4)

	collision_down = move_and_collide(Vector2.DOWN,true,true,true)
	if collision_down and collision_up:
		collision_down.collider.has_method("smash")
		$AnimationPlayer.play("collition_player")
		yield($AnimationPlayer, "animation_finished")
		queue_free()


#se elimina cuando sale de la vista
func _on_Visibility_screen_exited():
	# Cuando la trampa fue activada y sale de la camara de vision del jugador esta desaparece
	if is_active:
		if !get_parent().is_in_group('trap_board_generator'):
			print('ERROR la tabla trampa no tiene padre')
			return
		
		# Indicamos al padre que no tenemos tabla trampa
		get_parent().have_table = false
		queue_free()


func _on_TrapArea_body_entered(body):
	if body.is_in_group('player'):
		$AnimationPlayer.play("vibracion")
		yield($AnimationPlayer, "animation_finished")
		arriba = Vector2(0,4)
		movi = false
		is_active = true
