extends TileMap

@export var emitter_tile_coords: Vector2i

func _input(event):
	# hold space and click
	if event is InputEventMouseButton and Input.is_action_pressed("ui_accept"):
		var clicked_tile_coords := local_to_map(to_local(get_global_mouse_position()))
		print(clicked_tile_coords) #wrong... maybe the custom coursor is fucking this up?

		#places an emmiter
		set_cell(0, clicked_tile_coords, tile_set.get_source_id(0), emitter_tile_coords)

		#ereases neighbors -> to be changed to swap the tiles instead
		for cell in get_surrounding_cells(clicked_tile_coords):
			set_cell(0, cell, tile_set.get_source_id(0))
		
