extends Camera2D

onready var mario = get_tree().get_nodes_in_group("player")[0]

func _physics_process(delta):
	position.y = mario.position.y
	
	if position.x < mario.position.x:
		position.x = mario.position.x
