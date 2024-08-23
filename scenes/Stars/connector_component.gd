extends Node2D

var line_instance := preload("res://scenes/Stargazer/constellation_line.tscn")
var mouse_entered := false
var active_line : Line2D
var is_connecting = false

var entered_another := false

signal line_connected
signal other_entered
signal other_exited

var lines_array : Array

func _ready():
	get_parent().mouse_entered.connect(_on_star_mouse_entered)
	get_parent().mouse_exited.connect(_on_star_mouse_exited)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_connecting:
		move_line_on_mouse_pos()

func move_line_on_mouse_pos():
	var mouse_position = get_local_mouse_position()
	if active_line:
		active_line.points[-1] = mouse_position

func _on_star_mouse_entered():
	mouse_entered = true
	other_entered.emit(self)

func _on_star_mouse_exited():
	other_exited.emit(self)
	mouse_entered = false

func _on_line_connected(star):
	if is_connecting and star != self:
		is_connecting = false
		active_line.points[-1] = to_local(star.global_position)

func _on_other_mouse_entered(star):
	if star != self:
		entered_another = true

func _on_other_mouse_exited(star):
	if star != self:
		entered_another = false

func _input(event):
	if Input.is_action_just_pressed("left_click"):
		if mouse_entered and not is_connecting:
			is_connecting = true
			create_line()
			line_connected.emit(self)
		elif not mouse_entered and is_connecting and not entered_another:
			is_connecting = false
			remove_line(active_line)
			
	if Input.is_action_just_pressed("interact"):
		if mouse_entered:
			remove_all_lines()

func create_line():
	active_line = line_instance.instantiate()
	lines_array.append(active_line)
	active_line.points[0] = position
	add_child(active_line)

func remove_line(line):
	if line:
		line.queue_free()

func remove_all_lines():
	if get_children():
		for line in get_children():
			line.queue_free()
