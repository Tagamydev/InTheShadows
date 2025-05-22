class_name SaveGame
extends Resource

const SAVE_GAME_PATH := "user://savegame.tres"

var	level: int = 0

func update_level(level_n):
	level = level_n


func write_savegame() -> void:
	ResourceSaver.save(self, SAVE_GAME_PATH)

static func load_savegame() -> Resource:
	if ResourceLoader.exists(SAVE_GAME_PATH):
		return load(SAVE_GAME_PATH)
	return null
