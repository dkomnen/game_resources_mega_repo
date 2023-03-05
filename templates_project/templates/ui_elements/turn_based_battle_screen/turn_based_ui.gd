extends Control

signal ended_turn
signal attacked

@export var player: Node
@export var enemy: Node

@onready var player_stats_panel: PanelContainer = $PlayerStatsPanel
@onready var enemy_stats_panel: PanelContainer = $EnemyStatsPanel

func _ready():
	set_character_stats()

func _on_end_turn_button_pressed() -> void:
	ended_turn.emit()

func _on_attack_button_pressed() -> void:
	attacked.emit()

func set_character_stats() -> void:
	if player is Node:
		var player_stats = player.get_meta('Stats')
		player_stats_panel.set_stats(player_stats)
	
	if enemy is Node:
		var enemy_stats = enemy.get_meta('Stats')
		enemy_stats_panel.set_stats(enemy_stats)
