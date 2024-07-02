extends Node3D

@onready var left_foot = $LeftFoot
@onready var right_foot = $RightFoot
@onready var left_foot_raycast = $LeftFoot/LeftFootRaycast
@onready var right_foot_raycast = $RightFoot/RightFootRaycast
@onready var left_foot_target = $LeftFootTarget
@onready var right_foot_target = $RightFootTarget
@onready var player = $"../.."
@onready var left_foot_animation = $LeftFoot/LeftFootAnimation
@onready var right_foot_animation = $RightFoot/RightFootAnimation
@onready var left_timer = $LeftFoot/LeftTimer
@onready var right_timer = $RightFoot/RightTimer

var target_position = [Vector3.ZERO, Vector3.ZERO]
var foot_timings = [0.25, 0.0]
var foot_is_moving = [true, true]
var foot_walk_anims = ["left_foot_walk", "right_foot_walk"]
var foot_sprint_anims = ["left_foot_sprint", "right_foot_sprint"]
var foot_animations = []
var foot_targets = []
var foot_timers = []

var initial_pos = Vector3.ZERO
var player_velocity = Vector3.ZERO

var foot_offset = 0.0
var foot_time_limit = 0.5
var can_move_once = true
var can_move = 2
var can_move_first = true

@export var left_foot_y = 0.0
@export var right_foot_y = 0.0

var rng = RandomNumberGenerator.new()

func _ready():
	foot_animations = [left_foot_animation, right_foot_animation]
	target_position[0] = left_foot.global_position
	target_position[1] = right_foot.global_position
	foot_targets = [left_foot_target, right_foot_target]
	foot_timers = [left_timer, right_timer]

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
		foot_time_limit = 0.2
	else:
		foot_offset = 2.4
		foot_time_limit = 0.3

func move_foot(foot, foot_raycast, delta, n, foot_target, foot_y, foot_timer):
	# Raycast 3D Logic, basically for y value of position
	var collider = foot_raycast.get_collider()
	var target_height = 0.0
	if collider:
		target_height = foot_raycast.get_collision_point().y + 0.2
	foot.global_position.y = lerp(foot.global_position.y, target_height + foot_y, delta * 24)
	
	#For moving the Foot on X and Z Axis
	foot.global_position.x = lerp(foot.global_position.x, target_position[n].x, foot_timer.wait_time - foot_timer.time_left)
	foot.global_position.z = lerp(foot.global_position.z, target_position[n].z, foot_timer.wait_time - foot_timer.time_left)

func change_foot_position(n):
	foot_timers[n].start()
	if player.is_moving:
		target_position[n] = to_global(foot_targets[n].position + player_velocity.normalized() * foot_offset)
		if player.is_sprinting:
			foot_animations[n].play(foot_sprint_anims[n])
		else:
			foot_animations[n].play(foot_walk_anims[n])
		can_move_once = true
		can_move = 2
	else:
		if can_move_once:
			can_move -= 1
			foot_animations[n].play(foot_walk_anims[n])
		if can_move == 0:
			can_move_once = false
		target_position[n] = to_global(foot_targets[n].position)

func _process(delta):
	update_foot_offset()
	left_timer.set_wait_time(foot_time_limit)
	right_timer.set_wait_time(foot_time_limit)
	
	if can_move_first and player.is_moving:
		var random_index = rng.randi_range(0, 1)
		change_foot_position(random_index)
		can_move_first = false
	elif not player.is_moving:
		can_move_first = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_velocity(delta)
	move_foot(left_foot, left_foot_raycast, delta, 0, left_foot_target, left_foot_y, left_timer)
	move_foot(right_foot, right_foot_raycast, delta, 1, right_foot_target, right_foot_y, right_timer)
	print(left_timer.wait_time)
	print(right_timer.wait_time)

func _on_left_timer_timeout():
	foot_timers[0].stop()
	change_foot_position(1)

func _on_right_timer_timeout():
	foot_timers[1].stop()
	change_foot_position(0)
