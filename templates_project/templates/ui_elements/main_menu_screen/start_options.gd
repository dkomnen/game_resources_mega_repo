extends Control

@onready
var options_screen = get_tree().get_root().get_node("MainMenu/OptionsScreen")
var start_game_scene = load("res://scenes/top_down_test.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_game_btn_button_up():
	get_tree().change_scene_to_packed(start_game_scene)

func _on_options_btn_button_up():
	options_screen.visible = true

func _on_exit_game_btn_button_up():
	get_tree().quit()


func _on_exit_options_btn_button_up():
	options_screen.visible = false
