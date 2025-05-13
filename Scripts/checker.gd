extends Node3D

@onready var obj = self
@onready var first_rotation = obj.rotation_degrees

func _init():
	print()

func _check_rotation():
	var now = obj.rotation_degrees
	var	x = false
	var	y = false
	var	z = false
	var limit = 13

	if abs(now.x - first_rotation.x) < limit:
		x = true
	if abs(now.y - first_rotation.y) < limit:
		y = true
	if abs(now.z - first_rotation.z) < limit:
		z = true
	if not (x and y and z):
		print("bad!!!!!")


func _process(delta):
	_check_rotation()
