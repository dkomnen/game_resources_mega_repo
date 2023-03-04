extends Control

var current_active = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_node("OptionWindow").get_child(current_active).visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_submenu_button_up(submenu_id:int):
	var option_window = get_parent().get_node("OptionWindow")
	option_window.get_child(current_active).visible = false
	option_window.get_child(submenu_id).visible = true
	current_active = submenu_id


