extends Node

var	music_enabled = true
var	test_mode = false
var	level_unlocked = 0

signal solved()
signal to_be_solved()
signal return_menu()
signal start_match()
signal animation_level_00()
signal animation_level_01()
signal animation_level_02()
signal animation_level_03()
signal animation_level_04()
signal music_on()
signal music_off()
signal open_menu()
signal really_solved()

func	_ready():
	var Game = SaveGame.load_savegame()
	level_unlocked = Game.level
