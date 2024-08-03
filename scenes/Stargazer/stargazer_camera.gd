extends Camera2D

@export var camera_speed: float = 1.0
@export var space_size: Vector2 = Vector2(2000, 2000)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_to_mouse_pos(delta)
	stop_on_space_border()

func move_to_mouse_pos(delta):
	var mouse_pos = get_global_mouse_position()
	global_position = lerp(global_position, mouse_pos, delta * camera_speed)

func stop_on_space_border():
	var minimum = -(space_size/2) + (get_viewport_rect().size/2)
	var maximum = (space_size/2) - (get_viewport_rect().size/2)
	global_position.x = clamp(global_position.x, minimum.x, maximum.x)
	global_position.y = clamp(global_position.y, minimum.y, maximum.y)
