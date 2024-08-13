extends Node2D

@export var stars : Node2D
@export var star_parallax : Node2D
@export var line_instance = preload("res://scenes/Stargazer/constellation_line.tscn")
var line : Line2D

var stars_array : Array

var is_inside_star := false
var is_first_point := true
var is_building := false

var target_point_position : Vector2
var entered_star : Area2D

var stars_connected : Array

# on ready, we connect all the stars by their mouse entered and mouse exited signals
func _ready():
	connect_stars_to_signal()

# On process, make the last point follow the mouse
func _process(delta):
	point_follow_mouse()

# We get all children in stars component and connect them to the mouse entered and exited signals
func connect_stars_to_signal():
	stars_array = stars.get_children()
	for star in stars_array:
		star.mouse_entered.connect(_on_mouse_entered_star.bind(star))
		star.mouse_exited.connect(_on_mouse_exited_star.bind(star))

# we call this everytime we create a first point
# we add our line as a child to our star parallax layer
func create_line_at_position(point_position):
	line = line_instance.instantiate()
	star_parallax.add_child(line)
	star_parallax.move_child(line, 0)
	line.add_point(point_position)

# we call this when we want to add a point to a certain position
func set_last_point_at_position(point_position):
	line.points[line.get_point_count() - 1] = point_position
	if not stars_connected.has(entered_star):
		stars_connected.append(entered_star)

func remove_point(point_position):
	if line:
		if line.points:
			line.remove_point(point_position)

# all events related to inputs
func _input(event):
	if Input.is_action_just_pressed("left_click"):
		# If you are inside a star and you are doing your first point,
		if is_inside_star and is_first_point:
			is_building = true
			is_first_point = false
			create_line_at_position(target_point_position)
			line.add_point(target_point_position)
		# If you are inside a star and it is not your first point,
		elif is_inside_star and not is_first_point:
			set_last_point_at_position(target_point_position)
			line = null
			create_line_at_position(target_point_position)
		# If you are not inside a star and you are still building,
		elif not is_inside_star and is_building:
			is_building = false
			is_first_point = true
			remove_point(line.get_point_count() - 1)
	if Input.is_action_just_pressed("interact"):
		if is_inside_star:
			var remove_point = stars_connected.find(entered_star)
			remove_point(line.get_point_count() + remove_point)

# Move the point to follow the mouse
func point_follow_mouse():
	var mouse_pos = get_global_mouse_position()
	if line and is_building:
		if line.points:
			line.points[line.get_point_count() - 1] = mouse_pos

# Update the target_point_position and check the is_inside_star
func _on_mouse_entered_star(star):
	is_inside_star = true
	entered_star = star
	target_point_position = star.position

# turn is_inside_star to false
func _on_mouse_exited_star(star):
	entered_star = null
	is_inside_star = false
