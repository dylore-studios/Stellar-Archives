class_name FadeIfTooNearComponent
extends Node3D

@export var sprites: Sprite3D
@export var telescope_animation: AnimationPlayer

@export var left_raycast: RayCast3D
@export var right_raycast: RayCast3D

const mouse_distance = 2000

var is_moving = true
var can_place = false
var has_collision = false

var target_opacity = 1.0

func _ready():
	telescope_animation.play("close_telescope")
	is_moving = true
	can_place = false
	has_collision = false

func _input(event):
	if Input.is_action_just_pressed("interact") and can_place and not has_collision:
		is_moving = false
		sprites.modulate = Color.WHITE

func _process(delta):
	if is_moving:
		move_telescope_with_mouse()
		change_color()

func change_color():
	if can_place and not has_collision:
		sprites.modulate = Color.GREEN
	else:
		sprites.modulate = Color.RED

func move_telescope_with_mouse():
	check_placement()
	
	var space_state = get_world_3d().direct_space_state
	var mouse_position = get_viewport().get_mouse_position()
	var camera = get_tree().root.get_camera_3d()
	
	var rayOrigin = camera.project_ray_origin(mouse_position)
	var rayEnd = rayOrigin + camera.project_ray_normal(mouse_position) * mouse_distance
	
	var query = PhysicsRayQueryParameters3D.new()
	query.from = rayOrigin
	query.to = rayEnd
	query.collision_mask = 1
	
	var rayResult = space_state.intersect_ray(query)
	
	if !rayResult.is_empty():
		global_position.x = rayResult["position"].x
		global_position.z = rayResult["position"].z

func check_placement():
	if left_raycast.is_colliding() and right_raycast.is_colliding():
		var left_raycast_position = left_raycast.get_collision_point()
		var right_raycast_position = right_raycast.get_collision_point()
		if left_raycast_position.y == right_raycast_position.y:
			global_position.y = left_raycast_position.y
			global_position.y -= 4.65
			can_place = true
		else:
			can_place = false

func _on_area_3d_body_entered(body):
	if body.is_in_group("Player"):
		telescope_animation.play("open_telescope")
	elif body.is_in_group("Telescope"):
		if body != self:
			has_collision = true

func _on_area_3d_body_exited(body):
	if body.is_in_group("Player"):
		telescope_animation.play("close_telescope")
	elif body.is_in_group("Telescope"):
		if body != self:
			has_collision = false
