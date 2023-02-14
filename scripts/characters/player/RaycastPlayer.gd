extends Node2D

"""
	Aqui ajustamos la posicion del personaje el el aire si solo coliciona 
	unon de los bordes superiores de colicion. Es con el fin de evitar
	que el personaje pierde inpulso de salto solo por colicioinar un borde.
"""

func _process(delta):
	collition_up()
#	collition_down()
			

func collition_up():
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
			
#func collition_down():
#	if ($RaycastBott.is_colliding()):
#		if ($RaycastBott.get_collider().is_in_group('rotating_wheel')):
#			print('Pataclaun')
	
func collition_down(JUMPFORCE: int) -> void:
	# Si este nodo no tiene padre que retorne y no haga nada
	if (!get_parent()):
		return
		
	if($RaycastBott.is_colliding()):
		var object_coll = $RaycastBott.get_collider()
		
		if (object_coll.is_in_group("enemy")):
			object_coll.death('crushed')
			get_parent().velocity.y = JUMPFORCE / 2 # Pequeño salto
		
		elif (object_coll.is_in_group('rotating_wheel')):
			get_parent().velocity_platform = object_coll.constant_linear_velocity
				
func on_platform():
	var v_plataform: int = 0
#	var collider_node = get_slide_collision(get_slide_count()-1)

#	if collider_node.is_in_group('rotatwing_wheel'):
#		print("Entro")
#		v_plataform = int(collider_node.linear_velocity)

	return v_plataform
			
func other_object(object_coll):
	if object_coll.is_in_group('losa_floja'):
		if object_coll.collision_up:
			# Falta metodo para stun del personaje, por el momento un golpesito sin daño
			get_parent().damageReceived(0, object_coll.global_position)
