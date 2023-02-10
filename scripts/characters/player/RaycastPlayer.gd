extends Node2D

"""
	Aqui ajustamos la posicion del personaje el el aire si solo coliciona 
	unon de los bordes superiores de colicion. Es con el fin de evitar
	que el personaje pierde inpulso de salto solo por colicioinar un borde.
"""

func _process(delta):
	# Si solo coliciona el raycast izquierdo
	if $RayCastUpLeft.is_colliding() and !$RayCastUpRight.is_colliding():
		if $RayCastUpLeft.get_collider().is_in_group('foor'):
			get_parent().mov_position_player('move_right')
		else:
			other_object($RayCastUpLeft.get_collider())
		
	# Si solo coliciona el raycast derecho
	elif !$RayCastUpLeft.is_colliding() and $RayCastUpRight.is_colliding():
		if $RayCastUpRight.get_collider().is_in_group('foor'):
			get_parent().mov_position_player('move_left')
		else:
			other_object($RayCastUpRight.get_collider())
	
	elif $RayCastUpLeft.is_colliding() and $RayCastUpRight.is_colliding():
		if $RayCastUpRight.get_collider().is_in_group('losa_floja'):
			other_object($RayCastUpRight.get_collider())
			
func other_object(object_coll):
	if object_coll.is_in_group('losa_floja'):
		if object_coll.collision_up:
			# Falta metodo para stun del personaje, por el momento un golpesito sin daño
			get_parent().damageReceived(0, object_coll.global_position)
