extends KinematicBody2D


var arriba = Vector2.UP
var movi = true

var collision_up
var collision_down

func _ready():
	$AnimationPlayer.play("idle")

func _process(delta):
	collision_up = move_and_collide(arriba,true,true,movi)
	if collision_up:
		collision_up.collider.has_method("smash")
		$AnimationPlayer.play("vibracion")
		yield($AnimationPlayer, "animation_finished")
		arriba = Vector2(0,4)
		movi = false
		
# TODO: Este parte del collisionDown no esta funcionando muy bien, dar una chequeada
# Comentado por el momento, ya que la loza floja no deve poder ser destruida con un golpe inferior del jugador
	collision_down = move_and_collide(Vector2.DOWN,true,true,true)
	if collision_down and collision_up:
		collision_down.collider.has_method("smash")
		$AnimationPlayer.play("collition_player")
		yield($AnimationPlayer, "animation_finished")
		queue_free()

#se elimina cuando sale de la vista
func _on_Visibility_screen_exited():
	queue_free()
