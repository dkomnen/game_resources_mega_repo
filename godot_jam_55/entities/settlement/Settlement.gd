extends Area2D

@export
var neighbour_settlements : Array = []

var settlement_units : Array = []
var settlement_unit_resource : Resource = load("res://entities/unit/unit.tscn")

var army_resource : PackedScene = load("res://entities/army/army.tscn")

var game_coordinator : Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	game_coordinator = get_tree().get_root().get_node("/root/Main")
	for idx in range(neighbour_settlements.size()):
		neighbour_settlements[idx] = get_node(neighbour_settlements[idx])



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func clear_selection() -> void:
	$LineContainer.queue_free()
	if $Army:
		$Army.queue_free()

func get_settlement_units() -> Array:
	return settlement_units

func get_army() -> Node2D:
	# Warning - this can be full so need to refactor
	return $Army

func select_settlement() -> void:
	game_coordinator.set_selected_settlement(self)
	var army = army_resource.instantiate()
	add_child(army)
	army.global_position = global_position
	army.name = "Army"
	var line_container = Node2D.new()
	add_child(line_container)
	line_container.name = "LineContainer"
	line_container.z_index = 1
	for x in neighbour_settlements:
		var line_2d = Line2D.new()
		line_container.add_child(line_2d)
		line_2d.add_point(Vector2(0,0))
		line_2d.add_point(position.direction_to(x.position) * position.distance_to(x.position))

func _on_settlement_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton && event.pressed && event.button_index == MOUSE_BUTTON_LEFT):
		var selected_settlement = game_coordinator.get_selected_settlement()
		if selected_settlement != null:
			game_coordinator.perform_attack(selected_settlement, self)
		else:
			select_settlement()
	

func _on_unit_spawn_timer_timeout():
	if settlement_units.size() >= 10:
		return
	var unit = settlement_unit_resource.instantiate()
	get_parent().add_child(unit)
	unit.global_position = global_position
	settlement_units.append(unit)
