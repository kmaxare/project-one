extends StaticBody2D

# Asignar 1 para que se desplace a la derecha y -1 para que lo haga hacia la izquierda
export var direction = 1

# Cargar el archivo de escena del barril
var Barrel = load("res://interactive_objects/barrel.tscn")

func _on_Timer_timeout():
	# Crear una instancia del barril
	var barrel = Barrel.instance()
	# Establecer la posición del barril a la posición actual del nodo
	barrel.position = $Position2D.position
	# Establecer la dirección del movimiento del barril a la dirección especificada
	barrel.change_direction(direction)
	# Agregar el barril como hijo del nodo actual
	add_child(barrel)
