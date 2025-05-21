extends Node3D

@onready var obj = self
@onready var first_rotation = Vector3(0, 0, 0)

var	finish = false
var	end_position = 0
var end_rotation = 0
var animation_frame = 0
var end = false
var test = false
@export var threshold_rot_x: int = 3
@export var threshold_rot_y: int = 3
@export var threshold_rot_z: int = 9
@export var threshold_x: float = 0.2
@export var threshold_y: float = 0.09
@export var enable_asymetry: bool = false

func _end():
	OS.delay_msec(1000)
	SignalBus.solved.emit()
	end = true
	finish = true


func _ready():
	OS.delay_msec(1000)
	SignalBus.to_be_solved.emit()


func lerp_animation(delta):
	animation_frame += delta
	position = lerp(end_position, Vector3(0, 0, 0), animation_frame)
	rotation = lerp(end_rotation, Vector3(0, 0, 0), animation_frame)
	if animation_frame >= 1:
		end = true
		finish = false


func _check_rotation():
	var now = obj.rotation_degrees
	var	x = false
	var	y = false
	var	z = false
	var posx = false
	var posy = false

	if abs(now.x - first_rotation.x) < threshold_rot_x:
		x = true
	if abs(now.y - first_rotation.y) < threshold_rot_y:
		y = true
	var	_z = abs(now.z - first_rotation.z)
	if _z < threshold_rot_z:
		z = true
	if abs(position.x) < 0.2:
		posx = true
	if abs(position.y) < 0.09:
		posy = true
	if (x and y and z and posx and posy):
		end_position = position
		end_rotation = rotation
		finish = true
		get_child(0).get_child(0).get_node("CollisionShape3D").disabled = true


func _process(delta):
	if not test:
		SignalBus.to_be_solved.emit()
		test = true
	if not finish and not end:
		_check_rotation()
	if finish and not end:
		lerp_animation(delta)
	if end and not finish:
		_end()
