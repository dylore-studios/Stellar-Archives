extends Node2D

@export var stars: Node2D
@export var star_parallax: Node2D

@onready var line_instance = preload("res://scenes/Stargazer/constellation_line.tscn")
var line: Line2D

var stars_array

var can_point = false
var inside_star = false
var first_point = true
var is_building = true

var target_point_position: Vector2
var entered_star: Area2D

func _ready():
	connect_stars_to_signal()

func _input(event):
	if Input.is_action_just_pressed("left_click") and can_point:
		if first_point:
			line = line_instance.instantiate()
			star_parallax.add_child(line)
			star_parallax.move_child(line, 0)
			is_building = true
			line.add_point(target_point_position)
			line.points[line.get_point_count() - 1] = target_point_position
			line.add_point(target_point_position)
			first_point = false
		else:
			line.points[line.get_point_count() - 1] = target_point_position
			line.add_point(target_point_position)
	elif Input.is_action_just_pressed("left_click") and \
									is_building and \
									not can_point and \
									not inside_star:
		is_building = false
		first_point = true
		if line:
			if line.points:
				line.remove_point(line.get_point_count() - 1)

func _process(delta):
	point_follow_mouse()

func point_follow_mouse():
	var mouse_pos = get_global_mouse_position()
	if line and is_building:
		if line.points:
			line.points[line.get_point_count() - 1] = mouse_pos

func connect_stars_to_signal():
	stars_array = stars.get_children()
	for star in stars_array:
		star.mouse_entered.connect(_on_mouse_entered_star.bind(star))
		star.mouse_exited.connect(_on_mouse_exited_star.bind(star))

func _on_mouse_entered_star(star):
	inside_star = true
	can_point = true
	target_point_position = star.position

func _on_mouse_exited_star(star):
	inside_star = false
	can_point = false
