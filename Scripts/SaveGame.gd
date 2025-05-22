# SaveGame.gd
class_name SaveGame
extends Resource

const SAVE_GAME_PATH := "user://savegame.tres"

@export var level: int = 0

func write_savegame() -> void:
	ResourceSaver.save(self, SAVE_GAME_PATH)

static func load_savegame() -> SaveGame:
	if ResourceLoader.exists(SAVE_GAME_PATH):
		return load(SAVE_GAME_PATH) as SaveGame
	return SaveGame.new()
