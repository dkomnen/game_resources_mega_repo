class_name PlayerTurnState
extends State

func enter(_msg: Dictionary = {}) -> void:
    print("Entered player turn state")

func on_turn_ended() -> void:
    state_machine.switch_state("EnemyTurnState")