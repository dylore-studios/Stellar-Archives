extends Node

@export var telescope_animation : AnimationPlayer
@export var lookbox : Area3D
@export var stargazer : PackedScene

var stargazer_instance : Node2D

var stargazer_is_open := true
var first_time_open := true
var player_is_close := false

func _ready():
	lookbox.body_entered.connect(_on_look_box_body_entered)
	lookbox.body_exited.connect(_on_look_box_body_exited)
	telescope_animation.play("close_telescope")

func _input(event):
	if Input.is_action_just_pressed("right_click"):
		if stargazer_is_open and player_is_close:
			stargazer_is_open = false
			if first_time_open:
				generate_stargazer()
				first_time_open = false
			add_child(stargazer_instance)
		elif not stargazer_is_open and player_is_close:
			stargazer_is_open = true
			remove_child(stargazer_instance)

func generate_stargazer():
	stargazer_instance = stargazer.instantiate()

func _on_look_box_body_entered(body):
	if body.is_in_group("Player"):
		player_is_close = true
		telescope_animation.play("open_telescope")

func _on_look_box_body_exited(body):
	if body.is_in_group("Player"):
		player_is_close = false
		telescope_animation.play("close_telescope")
