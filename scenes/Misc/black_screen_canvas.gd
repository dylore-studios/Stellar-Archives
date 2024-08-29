extends CanvasLayer
class_name BlackScreenCanvas

signal animation_finished

func fade_into_black():
	$BlackScreen/Fader.play("fade_into_black")

func fade_outof_black():
	$BlackScreen/Fader.play("fade_outof_black")

func reset():
	$BlackScreen/Fader.play("RESET")

func _on_fader_animation_finished(anim_name: StringName) -> void:
	animation_finished.emit()
