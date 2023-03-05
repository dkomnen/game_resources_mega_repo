class_name State
extends Node

var state_machine

func initialize(_state_machine) -> void:
    state_machine = _state_machine

func enter(_msg : Dictionary = {}) -> void:
    pass

func update(_delta: float) -> void:
    pass

func physics_update(_delta: float) -> void:
    pass

func on_turn_ended() -> void:
    pass

func exit() -> void:
    pass