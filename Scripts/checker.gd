extends Node3D

@onready var obj = self
@onready var first_rotation = Vector3(0, 0, 0)

var	finish = false
var	end_position = 0
var end_rotation = 0
var animation_frame = 0
var end = false


func _end():
	SignalBus.solved.emit()
	end = true
	finish = true


func _ready():
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
	var limit = 3

	if abs(now.x - first_rotation.x) < limit:
		x = true
	if abs(now.y - first_rotation.y) < limit:
		y = true
	if abs(now.z - first_rotation.z) < limit * 3:
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
	if not finish and not end:
		_check_rotation()
	if finish and not end:
		lerp_animation(delta)
	if end and not finish:
		_end()
