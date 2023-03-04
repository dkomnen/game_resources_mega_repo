extends HBoxContainer

var remap_box_id: String
signal remap_start
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_remap_button_pressed():
	emit_signal("remap_start", remap_box_id)
