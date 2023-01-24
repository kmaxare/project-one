extends Camera2D

onready var player = get_tree().get_nodes_in_group("player")[0]

func _physics_process(delta):
	position.y = player.position.y - 36
	position.x = player.position.x
	
#	if player.position.x + 80 > position.x:
#		position.x = player.position.x + 80
