extends Spatial
func _ready():
	if check_morph():
		#do something
		pass
	else:
		print_debug("本模型没有表情")
	pass
#检查模型是否有表情形态建
func check_morph():
	var meshes=$Root/Skeleton.get_children()
	var has_morph
	for mesh in meshes:
		if mesh.get("blend_shapes")==null:
			has_morph=false
			return
		else:
			has_morph=true
	return has_morph
	pass # Replace with function body.
