extends Node3D

var rotating := false
var last_mouse_pos := Vector2.ZERO

const RAY_LENGTH = 1000.0

func _physics_process(delta):
	var space_state = get_world_3d().direct_space_state

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == 1:
		var camera3d = $Camera3D
		var from = camera3d.project_ray_origin(event.position)
		var to = from + camera3d.project_ray_normal(event.position) * RAY_LENGTH
