extends Node2D

#radio de la circunferencia en la que se moverán los slabs
export var radius = 100.0
#arreglo que contiene los ángulos iniciales de cada slab en radianes
var angles = [0.0, 1.5708, 3.14159, 4.71239]

#asignar los objetos de los slabs al script
onready var slabs = [$slab1, $slab2, $slab3, $slab4]

func _physics_process(delta):
	# En este bucle se recorre cada ángulo en el arreglo "angles"
	for i in range(angles.size()):
		angles[i] += 0.01 # incrementar el ángulo en cada frame
		move_slab(angles[i], slabs[i])

func move_slab(angle, slab):
	# calcular posición x e y utilizando fórmulas de circunferencia
	var x = radius * cos(angle)
	var y = radius * sin(angle)
	# asignar posición al cuerpo estático
	slab.position = Vector2(x, y)
