extends Node3D

@export var building: StaticBody3D
@export var border_radius: Area3D
@export var sprites: Sprite3D
@export var checker_raycast: RayCast3D

const mouse_distance = 2000

var is_moving = true
var can_place = false
var has_collision = false

func _ready():
	$"../CollisionShape3D".disabled = true
	border_radius.body_entered.connect(_on_border_radius_body_entered)
	border_radius.body_exited.connect(_on_border_radius_body_exited)

func _input(event):
	if Input.is_action_just_pressed("interact") and can_place and not has_collision:
		is_moving = false
		$"../CollisionShape3D".disabled = false
		sprites.modulate = Color.WHITE
		set_process(false)

func _process(delta):
	if is_moving:
		check_placement()
		move_telescope_with_mouse()
		change_color()

func change_color():
	if can_place and not has_collision:
		sprites.modulate = Color.GREEN
	else:
		sprites.modulate = Color.RED

func move_telescope_with_mouse():
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
	
	if not rayResult.is_empty():
		building.global_position.x = rayResult["position"].x
		building.global_position.z = rayResult["position"].z

func check_placement():
	if checker_raycast.is_colliding():
		can_place = true
		var checker_raycast_position = checker_raycast.get_collision_point()
		building.global_position.y = checker_raycast_position.y
		building.global_position.y -= 4.65
	else:
		can_place = false

func _on_border_radius_body_entered(body):
	if not body.is_in_group("Player") and body != building:
		has_collision = true

func _on_border_radius_body_exited(body):
	if not body.is_in_group("Player") and body != building:
		has_collision = false
