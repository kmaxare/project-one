extends TileMap

func _ready():
	#remove_tile()
	pass
# warning-ignore:unused_argument
func remove_tile(pos):

	var tilemap = preload("res://scenes/tiles/design.tres")	
	#print(tileset.get_tiles_ids())
	#tileset.remove_tile(id)
	var player = preload("res://scenes/tiles/Player.tscn")
	#para remover un mosaico completo
	#tilemap.tileset.remove_tile(id)
	
	var tile : Vector2 = world_to_map(pos)
	
	set_cell(tile.x, tile.y, -1)
	print("posicion en Celda ",  tile)


	
	
	#var id = tilemap.get_cell(int(tile.x), int(tile.y))
	#if id != -1:
	#tilemap.set_cell(int(tile.x), int(tile.y), -1)
