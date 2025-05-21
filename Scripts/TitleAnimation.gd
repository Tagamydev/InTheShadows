extends Button

@export var scene_number: int = 0
var animation_enabled = false
var timer = 0.0
@export var max_alpha: float = 1
@export var total_animation_time: float = 2.0

func animation():
	animation_enabled = true
	disabled = false


func _process(delta):
	if animation_enabled:
		timer = timer + delta
		var alpha = lerp(0.0, max_alpha, timer / total_animation_time)
		$".".add_theme_color_override("font_color", Color(1, 1, 1, alpha))
		if timer >= total_animation_time:
			animation_enabled = false
			timer = 0.0


func _ready():
	$".".add_theme_color_override("font_color", Color(0, 0, 0, 0))
	$".".add_theme_color_override("font_disabled_color", Color(0, 0, 0, 0))
	disabled = true
	if scene_number == 0:
		SignalBus.animation_level_00.connect(animation)
	if scene_number == 1:
		SignalBus.animation_level_01.connect(animation)
	if scene_number == 2:
		SignalBus.animation_level_02.connect(animation)
	if scene_number == 3:
		SignalBus.animation_level_03.connect(animation)
	if scene_number == 4:
		SignalBus.animation_level_04.connect(animation)
