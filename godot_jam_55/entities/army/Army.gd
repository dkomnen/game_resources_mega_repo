extends Node2D

@onready
var banner_cloth : AnimatedSprite2D = $Banner/Banner
@onready
var banner_badge : AnimatedSprite2D = $Banner/BannerBadge

var army_target : Node2D = null
var army_troops : Array[Node2D] = []
var attack_active : bool = false
var army_move_speed : float = 30
# Called when the node enters the scene tree for the first time.
func _ready():
	banner_cloth.self_modulate = Color(randf(),randf(),randf(),1.0)
	banner_cloth.play()
	banner_badge.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if attack_active:
		position.direction_to(army_target.position)
		position += position.direction_to(army_target.position) * army_move_speed * delta
		if position.distance_to(army_target.position) < 1:
			attack_active = false
			queue_free()

func set_army_target(target_settlement: Node2D) -> void:
	army_target = target_settlement

func execute_attack(units: Array):
	for unit in units:
		var unit_pos = unit.global_position
		unit.get_parent().remove_child(unit)
		add_child(unit)
		unit.global_position = unit_pos
	attack_active = true
	
