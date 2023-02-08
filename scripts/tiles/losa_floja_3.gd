extends KinematicBody2D


var arriba = Vector2.UP
var movi = true

func _ready():
	$AnimationPlayer.play("idle")

func _process(delta):
# Comentado por el momento, ya que la loza floja no deve poder ser destruida con un golpe inferior del jugador
#	var collision_down = move_and_collide(Vector2.DOWN,true,true,true)
#	if collision_down:
#		collision_down.collider.has_method("smash")
#		$AnimationPlayer.play("collition_player")
#		yield($AnimationPlayer, "animation_finished")
#		queue_free()
		
	var collision_up = move_and_collide(arriba,true,true,movi)
	if collision_up:
		collision_up.collider.has_method("smash")
		$AnimationPlayer.play("vibracion")
		yield(get_tree().create_timer(2),"timeout")
		arriba = Vector2(0,4)
		movi = false



#se elimina cuando sale de la vista
func _on_Visibility_screen_exited():
	queue_free()
