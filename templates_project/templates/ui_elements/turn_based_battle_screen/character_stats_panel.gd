extends PanelContainer

func set_stats(stats: CharacterStats):
	#free the placeholder children
	for child in $VBoxContainer.get_children():
		child.free()

	#populate the stats panel with all the stats
	var stats_dict = stats.get_as_dictionary()
	for stat in stats_dict:
		var stat_panel_resource := load("res://templates/ui_elements/turn_based_battle_screen/stat_panel.tscn")
		var stat_panel: PanelContainer = stat_panel_resource.instantiate()

		var label: Label = stat_panel.get_node("Label")
		var progress_bar: ProgressBar = stat_panel.get_node("ProgressBar")

		label.set_text(stat)
		progress_bar.set_max(stats_dict[stat])
		progress_bar.set_value(progress_bar.get_max())

		$VBoxContainer.add_child(stat_panel)
