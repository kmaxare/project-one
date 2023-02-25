extends Node2D

"""
	Aqui ajustamos la posicion del personaje el el aire si solo coliciona 
	unon de los bordes superiores de colicion. Es con el fin de evitar
	que el personaje pierde impulso de salto solo por colicioinar un borde.
"""

func _process(delta):
	collition_up()
#	collition_down()
			

func collition_up():
	var raycast_up_active
	# Si solo coliciona el raycast izquierdo
	if $RayCastUpLeft.is_colliding() and !$RayCastUpRight.is_colliding():
		raycast_up_active = $RayCastUpLeft.get_collider()
		
		if (raycast_up_active == null):
			return
			
		if raycast_up_active.is_in_group('foor'):
			get_parent().mov_position_player('move_right')
		else:
			other_object(raycast_up_active)
		
	# Si solo coliciona el raycast derecho
	elif !$RayCastUpLeft.is_colliding() and $RayCastUpRight.is_colliding():
		raycast_up_active = $RayCastUpRight.get_collider()
		
		if (raycast_up_active == null):
			return
			
		if raycast_up_active.is_in_group('foor'):
			get_parent().mov_position_player('move_left')
		else:
			other_object(raycast_up_active)
	
	elif $RayCastUpLeft.is_colliding() and $RayCastUpRight.is_colliding():
		raycast_up_active = $RayCastUpRight.get_collider()
		
		if (raycast_up_active == null):
			return
			
		if raycast_up_active.is_in_group('losa_floja'):
			other_object(raycast_up_active)
			
#func collition_down():
#	if ($RaycastBott.is_colliding()):
#		if ($RaycastBott.get_collider().is_in_group('rotating_wheel')):
#			print('Pataclaun')
	
func collition_fall(JUMPFORCE: int) -> void:
	# Si este nodo no tiene padre que retorne y no haga nada
	if (!get_parent()):
		return
	# variable que contienen lo que obtiene el get_collider
	var object_coll : CollisionObject2D = null
	#DETECCION DEL LADO IZQUIERDO
	if ($raycast_down_left.is_colliding()):
		object_coll = $raycast_down_left.get_collider()
		# si es un enemigo aplica la función death
		if (object_coll.is_in_group("enemy")):
			object_coll.death('crushed')
			get_parent().velocity.y = JUMPFORCE / 2 
		elif (object_coll.is_in_group('rotating_wheel')):
			get_parent().velocity_platform = object_coll.constant_linear_velocity
	#DETECCIÓN DEL LADO DERECHO
	if ($raycast_down_right.is_colliding()):
		var object_coll2 : CollisionObject2D = $raycast_down_right.get_collider()
		# aplica las acciones del raycast siempre que no se detecte 
		# al mismo collider del raycast down left
		if object_coll2.is_in_group("enemy") and (object_coll != object_coll2):
			object_coll2.death('crushed')
			get_parent().velocity.y = JUMPFORCE / 2 # Pequeño salto
		elif (object_coll2.is_in_group('rotating_wheel')):
			get_parent().velocity_platform = object_coll2.constant_linear_velocity

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
			get_parent().damage_received(0, object_coll.global_position)
