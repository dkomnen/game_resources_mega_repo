class_name CharacterStats

extends Resource

@export var health: float
@export var energy: float


func get_as_dictionary() -> Dictionary:
	return {
        "health": health,
        "energy": energy
    }
