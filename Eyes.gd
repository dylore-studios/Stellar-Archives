extends Node3D

@onready var player = $"../.."
@onready var left_eye = $LeftEye
@onready var right_eye = $RightEye

@export var z_offset = 0.7
@export var x_offset = 0.7
var offset = Vector3(0, 0, z_offset)
var moving_horizontally = false

func move_on_direction(delta):
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		moving_horizontally = true
	else:
		moving_horizontally = false
	
	if Input.is_action_just_pressed("move_down"):
		offset.z = z_offset
	elif Input.is_action_just_pressed("move_up"):
		offset.z = -z_offset
	
	if Input.is_action_pressed("move_down") or Input.is_action_pressed("move_up"):
		if not moving_horizontally:
			offset.x = 0
	
	if Input.is_action_pressed("move_right"):
		offset.x = x_offset
	elif Input.is_action_pressed("move_left"):
		offset.x = -x_offset
	
	position = lerp(position, offset, delta * 24)

func move_on_mousepos():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_on_direction(delta)
	move_on_mousepos()
