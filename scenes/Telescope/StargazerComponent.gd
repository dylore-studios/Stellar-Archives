extends Node
class_name Openable

@export var activate_animation : AnimationPlayer
@export var lookbox : Area3D
@export var interface : PackedScene
@export var building_component : Node3D

var interface_instance : Node2D

var is_open := false
var first_time_open := true
var player_is_close := false
var can_press := true

signal interface_opened
signal interface_closed

func _ready():
	lookbox.body_entered.connect(_on_look_box_body_entered)
	lookbox.body_exited.connect(_on_look_box_body_exited)
	activate_animation.play("close")

func _input(event):
	if Input.is_action_just_pressed("right_click") and not building_component.is_moving and can_press:
		if not is_open and player_is_close:
			interface_opened.emit(self)
			Global.player_can_move = false
			is_open = true
			can_press = false
		elif is_open:
			interface_closed.emit(self)
			close()

func generate_interface():
	interface_instance = interface.instantiate()

func open():
	if first_time_open:
		generate_interface()
		first_time_open = false
	add_child(interface_instance)
	can_press = true

func close():
	remove_child(interface_instance)
	is_open = false
	Global.player_can_move = true

func _on_look_box_body_entered(body):
	if body is Player:
		interface_opened.connect(body.open_object)
		interface_closed.connect(body.close_object)
		player_is_close = true
		activate_animation.play("open")

func _on_look_box_body_exited(body):
	if body is Player:
		interface_opened.disconnect(body.open_object)
		interface_closed.disconnect(body.close_object)
		player_is_close = false
		activate_animation.play("close")
