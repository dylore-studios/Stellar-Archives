extends Node

@export var telescope_animation : AnimationPlayer
@export var lookbox : Area3D
@export var stargazer : PackedScene
@export var building_component : Node3D

var stargazer_instance : Node2D

var stargazer_is_open := false
var first_time_open := true
var player_is_close := false

func _ready():
	lookbox.body_entered.connect(_on_look_box_body_entered)
	lookbox.body_exited.connect(_on_look_box_body_exited)
	telescope_animation.play("close_telescope")

func _input(event):
	if Input.is_action_just_pressed("right_click") and not building_component.is_moving:
		if not stargazer_is_open and player_is_close:
			open_stargazer()
		elif stargazer_is_open and player_is_close:
			close_stargazer()

func generate_stargazer():
	stargazer_instance = stargazer.instantiate()

func open_stargazer():
	if first_time_open:
		generate_stargazer()
		first_time_open = false
	add_child(stargazer_instance)
	stargazer_is_open = true
	Global.player_can_move = false

func close_stargazer():
	remove_child(stargazer_instance)
	stargazer_is_open = false
	Global.player_can_move = true

func _on_look_box_body_entered(body):
	if body.is_in_group("Player"):
		player_is_close = true
		telescope_animation.play("open_telescope")

func _on_look_box_body_exited(body):
	if body.is_in_group("Player"):
		player_is_close = false
		telescope_animation.play("close_telescope")
