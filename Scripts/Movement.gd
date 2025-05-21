extends Node3D

@export var only_horizontal: bool = true
@export var not_movement: bool = true
var rotating: bool = false
var grabbed: bool = false
var last_mouse_pos: Vector2 = Vector2.ZERO
var	obj = null;
var	normal = null;

func _clean():
	obj = null
	normal = null
	last_mouse_pos = Vector2.ZERO
	rotating = false
	grabbed = false

func _ready():
	SignalBus.solved.connect(_clean)

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


func rotate_horizontal(mouse_delta):
	var rotation_speed := 0.03
	if mouse_delta.x > 0:
		obj.rotate_y(1 * rotation_speed)
	if mouse_delta.x < 0:
		obj.rotate_y(-1 * rotation_speed)


func _ray_cast(event):
	var camera = get_viewport().get_camera_3d()
	var from = $Camera3D.position
	var to   = from + camera.project_ray_normal(event.position) * 1000
	var space_state = get_world_3d().direct_space_state
	var ray = PhysicsRayQueryParameters3D.create(from, to)
	var result = space_state.intersect_ray(ray)
	return result;


func _input(event):
	if event is InputEventMouseButton and \
	(event.button_index == MOUSE_BUTTON_WHEEL_DOWN or \
	event.button_index == MOUSE_BUTTON_WHEEL_UP or \
	event.button_index == MOUSE_BUTTON_RIGHT or \
	event.button_index == MOUSE_BUTTON_LEFT):
		var result = _ray_cast(event)
		if result.size() != 0:
			obj = result.collider
			obj = obj.get_parent()
			obj = obj.get_parent()
		else:
			if event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
				last_mouse_pos = Vector2.ZERO
				obj = null
				normal = null
				rotating = false
			elif event.button_index == MOUSE_BUTTON_RIGHT and event.is_released():
				last_mouse_pos = Vector2.ZERO
				grabbed = false
			else:
				return
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				normal = result.normal
				rotating = true
			else:
				last_mouse_pos = Vector2.ZERO
				obj = null
				normal = null
				rotating = false
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_RIGHT:
				grabbed = true
				last_mouse_pos = event.position 
			else:
				if event.button_index == MOUSE_BUTTON_WHEEL_UP:
					obj.rotate_z(-1 * 0.1)
				else:
					obj.rotate_z(1 * 0.1)
		else:
			if event.button_index == MOUSE_BUTTON_RIGHT:
				last_mouse_pos = Vector2.ZERO
				grabbed = false


	elif event is InputEventMouseMotion and rotating:
		var mouse_delta = event.position - last_mouse_pos
		last_mouse_pos = event.position
		if abs(mouse_delta.y) > abs(mouse_delta.x):
			rotate_vertical(mouse_delta)
		else:
			rotate_horizontal(mouse_delta)
	elif event is InputEventMouseMotion and grabbed:
		if only_horizontal:
			return
		var mouse_delta = event.position - last_mouse_pos
		last_mouse_pos = event.position

		if abs(mouse_delta.y) > 0.1:
			obj.position += Vector3(0, -0.001 * mouse_delta.y, 0)
		if abs(mouse_delta.x) > 0.1:
			obj.position += Vector3(0.001 * mouse_delta.x, 0, 0)
