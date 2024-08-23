extends Node

@export var scale_multiplier : float = 1.2
var normal_scale

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().mouse_entered.connect(_on_star_mouse_entered)
	get_parent().mouse_exited.connect(_on_star_mouse_exited)
	
	normal_scale = $"../Layers".scale
	
	if self.has_node("States"):
		$States.play("idle_disconnected")

func _on_star_mouse_entered():
	var scale_tween = create_tween()
	scale_tween.tween_property($"../Layers", "scale", normal_scale * scale_multiplier, 0.1)

func _on_star_mouse_exited():
	var scale_tween = create_tween()
	scale_tween.tween_property($"../Layers", "scale", normal_scale, 0.1)
