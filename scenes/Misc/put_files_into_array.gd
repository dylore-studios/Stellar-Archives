extends Node
class_name FileAppender

func append_scenes_to_array(path : String, array : Array):
	var dir = DirAccess.open(path)
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			break
		else:
			array.append(load(path + file_name))
	dir.list_dir_end()

func append_images_to_array(path : String, array : Array):
	var dir = DirAccess.open(path)
	dir.list_dir_begin()
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			break
		elif not file_name.ends_with(".import"):
			array.append(path + file_name)
	dir.list_dir_end()
