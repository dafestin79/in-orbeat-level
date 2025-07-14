extends Node2D

@export var needed_vertices: Array[Switch]
@export var lifeform: Lifeform
@export var is_ordered: bool = false
	

func _process(_delta: float) -> void:
	for vertex in needed_vertices:
		
		## Assume needed_vertices are all triggered
		var all_vertices_opened: bool = true
		
		## if any vertex wasn't triggered by the correct key then close Gate
		if not (vertex.switch_name in lifeform.song_list):
			all_vertices_opened = false
			close_door()
			break
			
		if all_vertices_opened:
			open_door()

func open_door() -> void:
	$TileMapLayer.set_cell(Vector2i(0,0), 5, Vector2i(4,0))
	$TileMapLayer.set_cell(Vector2i(0,1), 5, Vector2i(4,1))
	
func close_door() -> void:
	$TileMapLayer.set_cell(Vector2i(0,0), 5, Vector2i(3,0))
	$TileMapLayer.set_cell(Vector2i(0,1), 5, Vector2i(3,1))
