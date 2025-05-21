extends Control

var	start = false
var to_be_solved = 0
var solved = 0


func add_solved():
	solved = solved + 1


func add_to_be_solved():
	to_be_solved = to_be_solved + 1
	start = true


func start_match():
	start = true


func return_menu():
	get_tree().change_scene_to_file("res://Scenes/Menus/map.tscn")


func _ready():
	SignalBus.solved.connect(add_solved)
	SignalBus.to_be_solved.connect(add_to_be_solved)
	SignalBus.return_menu.connect(return_menu)
	SignalBus.start_match.connect(start_match)
	

func _process(delta):
	if start:
		if solved == to_be_solved:
			return_menu()
	print(solved)
	print(start)
