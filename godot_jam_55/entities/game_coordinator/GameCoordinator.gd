extends Node2D


var selected_settlement : Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_selected_settlement() -> Node2D:
	return selected_settlement

func set_selected_settlement(settlement: Node2D) -> void:
	selected_settlement = settlement

func perform_attack(origin_settlement: Node2D, target_settlement: Node2D):
	var army = origin_settlement.get_army()
	army.get_parent().remove_child(army)
	add_child(army)
	army.global_position = origin_settlement.global_position
	army.set_army_target(target_settlement)
	var units = origin_settlement.get_settlement_units()
	army.execute_attack(units)
	clear_selections()

func clear_selections() -> void:
	print(selected_settlement)
	if selected_settlement:
		selected_settlement.clear_selection()
		selected_settlement = null

func _input(event):
	if event.is_action_released("ui_cancel"):
		get_tree().quit()
	if (event is InputEventMouseButton && event.pressed && event.button_index == MOUSE_BUTTON_RIGHT):
		print("Clear selection")
		clear_selections()
