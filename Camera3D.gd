extends Camera3D

@export var target: Node3D
@export var offset = Vector3(4, 4.4, 14)
@export var camera_speed = 5.0
var horizontal_offset = 0

func _ready():
	horizontal_offset = offset.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !target:
		return
	
	var target_viewport_position = unproject_position(target.global_position)
	
	if get_viewport().get_mouse_position().x > target_viewport_position.x + 130:
		offset.x = horizontal_offset
	elif get_viewport().get_mouse_position().x < target_viewport_position.x - 130:
		offset.x = -horizontal_offset
	
	var target_position = target.global_position + offset
	global_position = lerp(global_position, target_position, camera_speed * delta)
