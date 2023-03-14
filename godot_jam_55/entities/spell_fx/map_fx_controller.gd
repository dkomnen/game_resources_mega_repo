extends TileMap

@export var fx_layer_index := 2
@export var fx_atlas_index := 2

@export var skill_active := true
@export var ranged := false

@onready var fx_atlas := tile_set.get_source_id(fx_atlas_index)

var previous_hovered_tile_coords: Vector2i
var active_tile_coords: Array[Vector2i]

func _process(_delta):
	if skill_active:
		var mouse_pos := get_global_mouse_position()
		var hovered_tile_coords := local_to_map(to_local(mouse_pos))

		if (hovered_tile_coords != previous_hovered_tile_coords):
			stop_all_tile_fx()
			play_tile_fx(hovered_tile_coords)
			for neighbor in get_surrounding_cells(hovered_tile_coords):
				play_tile_fx(neighbor)
			
			previous_hovered_tile_coords = hovered_tile_coords



func play_tile_fx(tile_coords: Vector2i):
	set_cell(fx_layer_index, tile_coords, fx_atlas, Vector2(0, 0)) #Vector2 is an atlas coord of the fx tile - refactor
	active_tile_coords.append(tile_coords)

func stop_tile_fx(tile_coords: Vector2i):
	set_cell(fx_layer_index, tile_coords)

func stop_all_tile_fx():
	for tile in active_tile_coords:
		stop_tile_fx(tile)
	active_tile_coords.clear()
