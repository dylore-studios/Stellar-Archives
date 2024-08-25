extends ParallaxBackground

@export var num_of_layers := 5

var parallax_layer = "res://scenes/Stargazer/Parallax/parallax_layer.tscn"

func _ready():
	for i in range(num_of_layers):
		await get_tree().create_timer(1).timeout
		spawn_parallax()

func spawn_parallax():
	var parallax_instance = load(parallax_layer).instantiate()
	parallax_instance.stargazer = get_parent()
	parallax_instance.has_disappeared.connect(spawn_parallax)
	add_child(parallax_instance)
	parallax_instance.create_spawn()
	move_child(parallax_instance, parallax_instance.parallax_index)
