class_name EnemyTurnState
extends State

func enter(_msg: Dictionary = {}) -> void:
    print("Entered enemy turn state")

func on_turn_ended() -> void:
    state_machine.switch_state("PlayerTurnState")