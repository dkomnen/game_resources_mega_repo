extends TileMap

@onready var tileset: TileSet = get_tileset()

var runtime_generated_tile_ids: Array = []
var last_updated_tile: Vector2i


# Called when the node enters the scene tree for the first time.
func _ready():
	create_packed_scenes_from_atlas(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func create_packed_scenes_from_atlas(atlas_source_id: int):
	var atlas: TileSetAtlasSource = tileset.get_source(atlas_source_id)
	var margins: Vector2i = atlas.get_margins()
	var separation: Vector2i = atlas.get_separation()
	var texture_region_size: Vector2i = atlas.get_texture_region_size()

	var texture: Texture = atlas.get_texture()
	var texture_size: Vector2i = texture.get_size()

	# ID 7 comes from in-engine id for the tilemap source
	var runtime_generated_tilesource: TileSetScenesCollectionSource = tileset.get_source(7)

	for x in range(atlas.get_atlas_grid_size().x):
		for y in range(atlas.get_atlas_grid_size().y):
			var tile_data: TileData = atlas.get_tile_data(Vector2i(x, y), 0)
			if tile_data == null:
				continue
			var node = Node2D.new()
			node.script = load("res://entities/terrain_manager/PackedSceneTileData.gd")
			var sprite = Sprite2D.new()

			sprite.set_texture(texture)
			sprite.set_region_enabled(true)
			sprite.set_region_rect(
				Rect2i(
					Vector2i(x * texture_region_size.x, y * texture_region_size.y),
					Vector2i(texture_region_size.x, texture_region_size.y)
				)
			)

			sprite.position = -tile_data.texture_origin  # Offset the sprite position by the texture_origin offset
			node.add_child(sprite)
			sprite.owner = node
			var scene = PackedScene.new()
			scene.pack(node)
			var new_id: int = runtime_generated_tilesource.create_scene_tile(scene)
			print("Creating PackedScene tiles from Atlas")
			runtime_generated_tile_ids.append(new_id)


func _input(event):
	if event is InputEventMouseButton and Input.is_action_pressed("test_key_2"):
		var clicked_tile_coords = local_to_map(to_local(get_global_mouse_position()))
		erase_cell(0, clicked_tile_coords)

	if event is InputEventMouseButton and Input.is_action_pressed("test_key"):
		if runtime_generated_tile_ids.size() == 0:
			create_packed_scenes_from_atlas(7)
		var clicked_tile_coords = local_to_map(to_local(get_global_mouse_position()))
		var tmp = runtime_generated_tile_ids[randi_range(0, runtime_generated_tile_ids.size() - 1)]
		last_updated_tile = clicked_tile_coords
		# Doesn't really work well, as PackedScene tiles don't have TileData property so they can only be placed on empty tiles
		# A tile needs to have TileData property in order to be updateable
		set_cell(0, clicked_tile_coords, 7, Vector2i(0, 0), tmp)
	if event.is_action_released("ui_accept"):
		var atlas: TileSetAtlasSource = tileset.get_source(0)
		print(tileset.get_source(0))
		var tile_data: TileData = atlas.get_tile_data(Vector2i(0, 0), 0)
		var tween: Tween = create_tween()
		tween.tween_property(tile_data, "texture_origin", Vector2i(0, -260), 1.0)


func _use_tile_data_runtime_update(layer: int, coords: Vector2i):
	print("use tile at runtime")
	if coords == last_updated_tile and layer == 0:
		return true
	return false
