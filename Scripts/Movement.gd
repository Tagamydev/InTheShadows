extends Node3D


# Whether we’re currently dragging/rotating
var rotating: bool = false
# Where the mouse was last frame
var last_mouse_pos: Vector2 = Vector2.ZERO
var	obj = null;
var	normal = null;

func rotate_vertical(mouse_delta):
	var rotation_speed := 0.01
	if abs(normal.x) > 0.3 && abs(normal.z) > 0.5:
		if mouse_delta.y > 0:
			obj.rotate_z(1 * rotation_speed)
			obj.rotate_x(1 * rotation_speed)
		if mouse_delta.y < 0:
			obj.rotate_z(-1 * rotation_speed)
			obj.rotate_x(-1 * rotation_speed)
		return
	if abs(normal.x) > abs(normal.z):
		if mouse_delta.y > 0:
			obj.rotate_z(1 * rotation_speed)
		if mouse_delta.y < 0:
			obj.rotate_z(-1 * rotation_speed)
	else:
		if mouse_delta.y > 0:
			obj.rotate_x(1 * rotation_speed)
		if mouse_delta.y < 0:
			obj.rotate_x(-1 * rotation_speed)
	#calculate_rot()
	
func rotate_horizontal(mouse_delta):
	var rotation_speed := 0.01
	if mouse_delta.x > 0:
		obj.rotate_y(1 * rotation_speed)
	if mouse_delta.x < 0:
		obj.rotate_y(-1 * rotation_speed)

func _input(event):
	# Handle mouse button presses
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Cast a ray from the camera through the mouse cursor
			var camera = get_viewport().get_camera_3d()
			var from = $Camera3D.position
			var to   = from + camera.project_ray_normal(event.position) * 1000

			var space_state = get_world_3d().direct_space_state
			var ray = PhysicsRayQueryParameters3D.create(from, to)
			var result = space_state.intersect_ray(ray)
			

			if result.size() != 0:
				obj = result.collider
				normal = result.normal
				rotating = true
		else:
			last_mouse_pos = Vector2.ZERO
			obj = null
			normal = null
			rotating = false

	# Handle mouse motion when in “rotating” mode
	elif event is InputEventMouseMotion and rotating:
		var mouse_delta = event.position - last_mouse_pos
		last_mouse_pos = event.position
		print(normal)
		# Y-axis (up) rotation for horizontal mouse movement
		if abs(mouse_delta.y) > abs(mouse_delta.x):
			rotate_vertical(mouse_delta)
		else:
			rotate_horizontal(mouse_delta)
		# X-axis (sideways) rotation for vertical mouse movement
		#obj.rotate_x(-mouse_delta.y * rotation_speed)
