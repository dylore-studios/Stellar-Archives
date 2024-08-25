extends ParallaxLayer

@export var midground_path : String
@export var foreground_path : String
@export var stargazer : Stargazer
@export var is_foreground := true

var parallax_index
var array_of_layers : Array

signal has_disappeared

func create_spawn():
	var random = randi_range(0, 1)
	if random == 0:
		spawn(midground_path)
		motion_scale = Vector2(0.5, 0.5)
		parallax_index = 1
	else:
		spawn(foreground_path)
		motion_scale = Vector2(1.3, 1.3)
		parallax_index = -1
	
	$ParallaxLayerAnimation.play("spawn_in")

func spawn(path):
	array_of_layers = []
	var file_appender = FileAppender.new()
	file_appender.append_images_to_array(path, array_of_layers)
	
	$Sprite2D.texture = load(array_of_layers.pick_random())
	var xpos = randf_range(-stargazer.space_size.x/3, stargazer.space_size.x/3)
	var ypos = randf_range(-stargazer.space_size.y/3, stargazer.space_size.y/3)
	$Sprite2D.position = Vector2(xpos, ypos)
	var random_scale = randf_range(0.2, 0.5)
	$Sprite2D.scale = Vector2(random_scale, random_scale)


func _on_parallax_layer_animation_animation_finished(anim_name):
	if anim_name == "spawn_in":
		$Lifetime.start()
		await $Lifetime.timeout
		$ParallaxLayerAnimation.play("spawn_out")
		has_disappeared.emit()
	elif anim_name == "spawn_out":
		queue_free()
