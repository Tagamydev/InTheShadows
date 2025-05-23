extends Control

var	start = false
var to_be_solved = 0
var solved = 0
@export var level_number: int = 0
var finish = false


func add_solved():
	solved = solved + 1


func add_to_be_solved():
	to_be_solved = to_be_solved + 1
	start = true


func start_match():
	start = true


func return_menu():
	var	Game = SaveGame.load_savegame()
	if (SignalBus.level_unlocked < level_number) and solved == to_be_solved and not SignalBus.test_mode:
		SignalBus.level_unlocked = level_number
		Game.level = level_number
		Game.write_savegame()
	visible = true
	finish = true
	SignalBus.really_solved.emit()
	#get_tree().change_scene_to_file("res://Scenes/Menus/map.tscn")


func	hide_menu():
	visible = false


func _ready():
	visible = false
	SignalBus.to_be_solved.connect(add_to_be_solved)
	SignalBus.solved.connect(add_solved)
	SignalBus.return_menu.connect(return_menu)
	SignalBus.start_match.connect(start_match)
	SignalBus.open_menu.connect(hide_menu)
	

func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE and event.is_pressed() and not finish:
			visible = !visible


func _process(delta):
	if start:
		if solved == to_be_solved:
			return_menu()


func _on_button_5_button_down() -> void:
	get_tree().quit()
	pass # Replace with function body.
