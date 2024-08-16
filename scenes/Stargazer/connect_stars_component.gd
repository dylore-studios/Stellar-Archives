extends Node2D

@export var stars : Node2D
@export var star_parallax : Node2D
@export var line_instance = preload("res://scenes/Stargazer/constellation_line.tscn")
var line : Line2D

var lines_array : Array
var stars_array : Array

var is_inside_star := false
var is_first_point := true
var is_building := false

var target_point_position : Vector2
var entered_star : Area2D
var previously_entered_star : Area2D

# on ready, we connect all the stars by their mouse entered and mouse exited signals
func _ready():
	connect_stars_to_signal()

# On process, make the last point follow the mouse
func _process(delta):
	point_follow_mouse()

# We get all children in stars component and connect them to the mouse entered and exited signals
func connect_stars_to_signal():
	for star in stars.get_children():
		star.mouse_entered.connect(_on_mouse_entered_star.bind(star))
		star.mouse_exited.connect(_on_mouse_exited_star.bind(star))

# we call this everytime we create a first point
# we add our line as a child to our star parallax layer
func make_line(point_position):
	line = line_instance.instantiate()
	star_parallax.add_child(line)
	star_parallax.move_child(line, 0)
	line.add_point(point_position)
	line.add_point(point_position)
	lines_array.append(line)
	
	print(lines_array)

func create_first_line(point_position):
	make_line(point_position)
	if not stars_array.has(entered_star):
		stars_array.append(entered_star)
	entered_star.has_point = true
	previously_entered_star = entered_star
	print(stars_array)

func create_another_line(point_position):
	line.points[line.points.size() - 1] = point_position
	make_line(point_position)
	if not stars_array.has(entered_star):
		stars_array.append(entered_star)
	entered_star.has_point = true
	previously_entered_star = entered_star
	print(stars_array)

func start_building():
	is_building = true
	is_first_point = true

func stop_building():
	is_building = false

func remove_connection(line_to_remove):
	if lines_array.has(line_to_remove):
		lines_array.erase(line_to_remove)
		star_parallax.remove_child(line_to_remove)
	if is_first_point or (not is_first_point and not previously_entered_star.has_point):
		if stars_array.has(previously_entered_star):
			stars_array.erase(previously_entered_star)
	
	print(lines_array)
	print(stars_array)

# all events related to inputs
func _input(event):
	if Input.is_action_just_pressed("left_click"):
		# If you are inside a star and you are doing your first point,
		if is_inside_star and not is_building:
			start_building()
			create_first_line(target_point_position)
		# If you are inside a star and it is not your first point,
		elif is_inside_star and is_building and previously_entered_star != entered_star:
			is_first_point = false
			create_another_line(target_point_position)
		# If you are not inside a star and you are still building,
		elif not is_inside_star and is_building:
			stop_building()
			remove_connection(lines_array[lines_array.size() - 1])
	if Input.is_action_just_pressed("interact"):
		if is_inside_star:
			pass

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
