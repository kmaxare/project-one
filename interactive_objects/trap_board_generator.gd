extends Position2D

var have_table = false
var in_windows = false

export (PackedScene) var trap_board

func _ready():
	board_regenerate()


func board_regenerate():
	# Si ya existe una tabla trampa returna
	if have_table:
		return
		
	# Generar tabla trampa
	var instance_tb = trap_board.instance()
	add_child(instance_tb)
	instance_tb.global_position = global_position
	
	have_table = true


func _on_VisibilityGenerator_screen_exited():
	in_windows = false
	$SpawnTime.start()


func _on_SpawnTime_timeout():
	if !in_windows:
		board_regenerate()


func _on_VisibilityGenerator_screen_entered():
	in_windows = true
	$SpawnTime.stop()
