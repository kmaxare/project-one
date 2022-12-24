extends TileMap

func _ready():
	remove_tile(0)
	#pass
# warning-ignore:unused_argument
func remove_tile(id):

	var tilemap = preload("res://scenes/tiles/design.tres")	
	#print(tileset.get_tiles_ids())
	#tileset.remove_tile(id)
	var player = preload("res://scenes/tiles/Player.tscn")
	#para remover un mosaico completo
	#tilemap.tileset.remove_tile(id)
	set_cell(13, 9, -1)
	print("Removido")


	var tile : Vector2 = tilemap.world_to_map(player.global_position)
	print("posicion del player", tile)
	#var id = tilemap.get_cell(int(tile.x), int(tile.y))
	#if id != -1:
	#tilemap.set_cell(int(tile.x), int(tile.y), -1)
