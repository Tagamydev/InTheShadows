extends Control


func _on_button_button_down():
	get_tree().change_scene_to_file("res://Scenes/Menus/map.tscn")
	pass # Replace with function body.


func _on_button_2_button_down():
	SignalBus.test_mode = true
	get_tree().change_scene_to_file("res://Scenes/Menus/map.tscn")
	pass # Replace with function body.
