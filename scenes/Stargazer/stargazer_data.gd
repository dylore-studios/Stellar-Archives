extends Interface
class_name Stargazer

@export var space_size := Vector2(2000, 2000)

func update_info(data : Array):
	for i in range(data.size() - 1):
		if data[i] is String:
			$SpaceGenerator.star_rarity[data[i]] = data[i+1]

func _on_tree_entered() -> void:
	$BlackScreenCanvas.fade_outof_black()

func _on_tree_exited() -> void:
	$BlackScreenCanvas.reset()
