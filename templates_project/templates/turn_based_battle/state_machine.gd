class_name StateMachine
extends Node

signal transitioned(state_name)

@export var initial_state: State
@onready var current_state: State = initial_state

func _ready() -> void:
    current_state.enter()

func _process(delta: float):
    current_state.update(delta)
 
func _physics_process(delta: float) -> void:
    current_state.physics_update(delta)