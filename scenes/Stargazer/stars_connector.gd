extends Node2D

func connect_stars_to_signals():
	for from_star in get_children():
		for to_star in get_children():
			if from_star != to_star:
				from_star.connector.line_connected.connect(to_star.connector._on_line_connected)
				from_star.connector.other_entered.connect(to_star.connector._on_other_mouse_entered)
				from_star.connector.other_exited.connect(to_star.connector._on_other_mouse_exited)

func _on_space_generator_done_generating():
	connect_stars_to_signals()
