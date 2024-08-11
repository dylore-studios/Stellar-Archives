extends Node

@export var telescope_animation : AnimationPlayer
@export var lookbox : Area3D
@export var stargazer : Sprite3D

var stargazer_is_open = true

func _ready():
	lookbox.body_entered.connect(_on_look_box_body_entered)
	lookbox.body_exited.connect(_on_look_box_body_exited)
	telescope_animation.play("close_telescope")

func _input(event):
	if Input.is_action_just_pressed("sprint"):
		if stargazer_is_open:
			stargazer_is_open = false
			stargazer.hide()
		else:
			stargazer_is_open = true
			stargazer.show()

func _on_look_box_body_entered(body):
	if body.is_in_group("Player"):
		telescope_animation.play("open_telescope")

func _on_look_box_body_exited(body):
	if body.is_in_group("Player"):
		telescope_animation.play("close_telescope")
