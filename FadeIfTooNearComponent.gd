extends Node3D

@export var sprites: Sprite3D
@export var minimum_distance: float = 12.0
var target_opacity = 1.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fade_when_too_near(delta)

# fades if global position is too close to camera global position
func fade_when_too_near(delta):
	var camera_position = get_viewport().get_camera_3d().global_position
	if global_position.distance_to(camera_position) < minimum_distance:
		target_opacity = lerp(target_opacity, 0.0, delta * 4)
	else:
		target_opacity = lerp(target_opacity, 1.0, delta * 4)
	
	sprites.modulate.a = target_opacity
