extends Node2D

"""
	Aqui ajustamos la posicion del personaje el el aire si solo coliciona 
	unon de los bordes superiores de colicion. Es con el fin de evitar
	que el personaje pierde inpulso de salto solo por colicioinar un borde.
"""

func _process(delta):
	# Si solo coliciona el raycast izquierdo
	if $RayCastUpLeft.is_colliding() and !$RayCastUpRight.is_colliding():
		get_parent().movPosition('move_right')
		print('Coll izquierda')
	# Si solo coliciona el raycast derecho
	elif !$RayCastUpLeft.is_colliding() and $RayCastUpRight.is_colliding():
		get_parent().movPosition('move_left')
		print('Coll derecha')
