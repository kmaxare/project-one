extends Node2D

# Radio del movimiento circular
export var radius = 100.0

# Lista de tableros que se moverán en un círculo
onready var slabs = [$Slab1, $Slab2, $Slab3, $Slab4]

# Ángulos para cada tablero
var angles = [0.0, 1.5708, 3.14159, 4.71239]

# Función que se ejecuta en cada ciclo de física
func _physics_process(delta):
	# Iterar a través de cada ángulo y tablero
	for i in range(angles.size()):
		# Aumentar el ángulo en un valor pequeño
		angles[i] += 0.01
		# Llamar a la función para mover el tablero
		move_slab(angles[i], slabs[i])

# Función para mover el tablero en un círculo
func move_slab(angle, slab):
	# Calcular la posición x utilizando coseno
	var x = radius * cos(angle)
	# Calcular la posición y utilizando seno
	var y = radius * sin(angle)
	# Establecer la posición del tablero
	slab.position = Vector2(x, y)
