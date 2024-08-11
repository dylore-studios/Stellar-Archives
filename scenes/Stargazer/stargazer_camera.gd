extends Camera2D

@export var stargazer := Node2D
@export var camera_speed: float = 0.3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_to_mouse_pos(delta)
	stop_on_space_border()

# we lerp the global position of the camera to the position of the mouse by the camera_speed
func move_to_mouse_pos(delta):
	var mouse_pos = get_global_mouse_position()
	global_position = lerp(global_position, mouse_pos, delta * camera_speed)

# We have to clamp the the position of the camera to the minimum and maximum of a border
# This is a variable which will be taken from the telescope data. Each telescope has a
# different size of border.
func stop_on_space_border():
	var minimum = -(stargazer.space_size/2) + (get_viewport_rect().size/2)
	var maximum = (stargazer.space_size/2) - (get_viewport_rect().size/2)
	global_position.x = clamp(global_position.x, minimum.x, maximum.x)
	global_position.y = clamp(global_position.y, minimum.y, maximum.y)
