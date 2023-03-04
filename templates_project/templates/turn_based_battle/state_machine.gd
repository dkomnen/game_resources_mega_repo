class_name StateMachine
extends Node

signal transitioned(state_name)

@export var initial_state: State
@onready var current_state: State = initial_state

func _ready() -> void:
    for child in get_children():
        child.initialize(self)
    current_state.enter()

func _process(delta: float):
    current_state.update(delta)
 
func _physics_process(delta: float) -> void:
    current_state.physics_update(delta)

func switch_state(new_state_name: String, msg: Dictionary = {}) -> void:
    
    
    current_state.exit()
    current_state = get_node(new_state_name)
    current_state.enter(msg)
    transitioned.emit(current_state.name)