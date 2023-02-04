extends Node2D

<<<<<<< Updated upstream
#radio de la circunferencia en la que se moverán los slabs
export var radius = 100.0
#arreglo que contiene los ángulos iniciales de cada slab en radianes
var angles = [0.0, 1.5708, 3.14159, 4.71239]
=======
# Radio del movimiento circular
export var radius = 100.0
>>>>>>> Stashed changes

# Lista de tableros que se moverán en un círculo
onready var slabs = [$slab1, $slab2, $slab3, $slab4]

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
