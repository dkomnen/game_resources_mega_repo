extends Node2D

enum State {
	ALLY_TURN,
	ENEMY_TURN,
	START_BATTLE,
	END_BATTLE
}

var current_state: State = State.START_BATTLE

func _ready() -> void:
	match typeof(current_state):
		State.START_BATTLE:
			print("Start")
		_:
			pass

func _process(_delta: float) -> void:
	pass