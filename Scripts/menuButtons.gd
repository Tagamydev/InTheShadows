extends VBoxContainer

@export var level_number: int = 5

func _on_button_4_button_down():
	var str1 = "res://Scenes/Levels/Level0"
	var str2 = ".tscn"
	var result = str1 + str(level_number) + str2
	get_tree().change_scene_to_file(result)
	print(result)
	pass # Replace with function body.


func _on_button_2_button_down():
	pass # Replace with function body.


func _on_button_3_button_down():
	get_tree().change_scene_to_file("res://Scenes/Menus/map.tscn")
	pass # Replace with function body.
