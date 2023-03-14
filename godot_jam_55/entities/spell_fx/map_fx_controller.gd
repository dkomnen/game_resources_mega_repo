extends TileMap

@export var fx_layer_index := 2
@export var fx_atlas_index := 2

@export var skill_active := true

@onready var fx_atlas := tile_set.get_source_id(fx_atlas_index)

var previous_hovered_tile_coords: Vector2i

func _process(_delta):
	if skill_active:
		var mouse_pos := get_global_mouse_position()
		var hovered_tile_coords := local_to_map(to_local(mouse_pos))
		print("tile coords: " + str(hovered_tile_coords))

		if (hovered_tile_coords != previous_hovered_tile_coords):
			stop_tile_fx(previous_hovered_tile_coords)
			play_tile_fx(hovered_tile_coords)

		previous_hovered_tile_coords = hovered_tile_coords



func play_tile_fx(tile_coords: Vector2i):
	set_cell(fx_layer_index, tile_coords, fx_atlas, Vector2(0, 0))

func stop_tile_fx(tile_coords: Vector2i):
	set_cell(fx_layer_index, tile_coords)
