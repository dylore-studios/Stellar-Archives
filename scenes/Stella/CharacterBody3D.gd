extends CharacterBody3D

var player_speed = 0
var sprint_speed = 0
@export var walk_speed = 7.0
var is_sprinting = false
var is_moving = false

@onready var floor_raycast = $Sprites/Body/BodyRaycast
@onready var left_foot = $Sprites/Feet/LeftFoot
@onready var right_foot = $Sprites/Feet/RightFoot

func _ready():
	# On ready, set player speed to walk speed as default.
	# Set sprint speed to more than walk_speed.
	player_speed = walk_speed
	sprint_speed = walk_speed + 7.0

func float_player(delta):
	var collider = floor_raycast.get_collider()
	if collider:
		var target_height = floor_raycast.get_collision_point().y + abs(floor_raycast.target_position.y) - 3.6
		position.y = lerp(position.y, target_height, delta * 10)

func move_player(delta):
	# Set sprint logic and input.
	if Input.is_action_pressed("sprint"):
		player_speed = sprint_speed
		is_sprinting = true
	else:
		is_sprinting = false
		player_speed = walk_speed

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Let player move
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * player_speed, player_speed * delta * 5)
		velocity.z = move_toward(velocity.z, direction.z * player_speed, player_speed * delta * 5)
		is_moving = true
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed * delta * 7)
		velocity.z = move_toward(velocity.z, 0, player_speed * delta * 7)
		is_moving = false
	
	var target_position = (left_foot.global_position + right_foot.global_position)/2
	global_position.x = lerp(global_position.x, target_position.x, delta * 2)
	global_position.z = lerp(global_position.z, target_position.z, delta * 2)

	move_and_slide()

func _physics_process(delta):
	move_player(delta)
	float_player(delta)
