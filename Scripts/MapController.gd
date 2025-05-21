extends Control


func _on_level_00_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Level01.tscn")
	pass # Replace with function body.


func _on_level_01_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Level02.tscn")
	pass # Replace with function body.


func _on_level_02_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Level03.tscn")
	pass # Replace with function body.


func _on_level_03_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Level04.tscn")
	pass # Replace with function body.


func _on_level_04_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/Level05.tscn")
	pass # Replace with function body.

func _ready():
	SignalBus.animation_level_00.emit()
	if SignalBus.level_unlocked >= 1 or SignalBus.test_mode:
		SignalBus.animation_level_01.emit()
	if SignalBus.level_unlocked >= 2 or SignalBus.test_mode:
		SignalBus.animation_level_02.emit()
	if SignalBus.level_unlocked >= 3 or SignalBus.test_mode:
		SignalBus.animation_level_03.emit()
	if SignalBus.level_unlocked >= 4 or SignalBus.test_mode:
		SignalBus.animation_level_04.emit()
