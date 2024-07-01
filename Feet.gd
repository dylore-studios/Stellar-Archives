extends Node3D

@onready var left_foot = $LeftFoot
@onready var right_foot = $RightFoot
@onready var left_foot_raycast = $LeftFoot/LeftFootRaycast
@onready var right_foot_raycast = $RightFoot/RightFootRaycast
@onready var left_foot_target = $LeftFootTarget
@onready var right_foot_target = $RightFootTarget
@onready var player = $"../.."
@onready var timer = $Timer
@onready var left_foot_animation = $LeftFoot/LeftFootAnimation
@onready var right_foot_animation = $RightFoot/RightFootAnimation

var foot_initial_global_pos = [Vector3.ZERO, Vector3.ZERO]
var foot_timings = [0.25, 0.0]
var foot_is_moving = [true, true]
var foot_walk_anims = ["left_foot_walk", "right_foot_walk"]
var foot_sprint_anims = ["left_foot_sprint", "right_foot_sprint"]
var foot_animations = []

var initial_pos = Vector3.ZERO
var player_velocity = Vector3.ZERO

var foot_offset = 0.0
var foot_time_limit = 0.5

@export var left_foot_y = 0.0
@export var right_foot_y = 0.0

var rng = RandomNumberGenerator.new()

func _ready():
	foot_animations = [left_foot_animation, right_foot_animation]
	foot_initial_global_pos[0] = left_foot.global_position
	foot_initial_global_pos[1] = right_foot.global_position

func get_velocity(delta):
	var velocity = Vector3(0, 0, 0)
	var final_pos = player.position
	var difference_in_pos = final_pos - initial_pos
	velocity = difference_in_pos / delta
	initial_pos = player.position
	player_velocity = velocity

func update_foot_offset():
	if player.is_sprinting:
		foot_offset = 3.4
		foot_time_limit = 0.4
	else:
		foot_offset = 2.4
		foot_time_limit = 0.5

func move_foot(foot, foot_raycast, delta, n, foot_target, foot_y):
	# Raycast 3D Logic, basically for y value of position
	var collider = foot_raycast.get_collider()
	var target_height = 0.0
	if collider:
		target_height = foot_raycast.get_collision_point().y + 0.2
	foot.global_position.y = lerp(foot.global_position.y, target_height + foot_y, delta * 24)
	
	#For moving the Foot on X and Z Axis
	var target_position = to_global(foot_target.position + player_velocity.normalized() * foot_offset)
	if foot_timings[n] > foot_time_limit:
		if player.is_moving:
			foot_initial_global_pos[n].x = target_position.x
			foot_initial_global_pos[n].z = target_position.z
			if player.is_sprinting:
				foot_animations[n].play(foot_sprint_anims[n])
			else:
				foot_animations[n].play(foot_walk_anims[n])
		foot_timings[n] = 0.0
	else:
		foot.global_position.x = lerp(foot.global_position.x, foot_initial_global_pos[n].x, foot_timings[n])
		foot.global_position.z = lerp(foot.global_position.z, foot_initial_global_pos[n].z, foot_timings[n])


func _process(delta):
	update_foot_offset()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	for i in range(foot_timings.size()):
		foot_timings[i] += delta
	
	get_velocity(delta)
	move_foot(left_foot, left_foot_raycast, delta, 0, left_foot_target, left_foot_y)
	move_foot(right_foot, right_foot_raycast, delta, 1, right_foot_target, right_foot_y)
