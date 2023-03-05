extends Control

signal ended_turn
signal attacked

func _on_end_turn_button_pressed() -> void:
	ended_turn.emit()

func _on_attack_button_pressed() -> void:
	attacked.emit()