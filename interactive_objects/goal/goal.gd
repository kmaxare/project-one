extends Area2D

onready var audio = $audio
onready var animation = $AnimationPlayer
# indicador de que si ya se ha activado la secuenia de termino de nivel.
var activated : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#se activa solamente al entrar un cuerpo al Area2D
func _on_goal_body_entered(body):
	# se busca que el código se ejecute solamente si no se está ha activo ya la 
	#animación de la meta
	if !activated:
		activated = true
		#con este if se asegura que el cuerpo sea el del player
		if (body.is_in_group('player')):
			animation.play("active")
			audio.playing = true
			yield(animation, "animation_finished")
			if get_tree().change_scene("res://GUI/you_win.tscn") != OK:
				print("Error")
