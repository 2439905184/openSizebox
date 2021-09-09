extends Spatial
func _ready():
#	if check_morph():
#		#do something
#		pass
#	else:
#		print_debug("本模型没有表情")
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
	pass 
#放置模型代码 可能移动代码位置
func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if "alice" in self.name and event is InputEventMouseButton:
		if event.button_index==BUTTON_RIGHT:
			$vbox.show()
			var pos=camera.unproject_position(click_position)
			print_debug(pos)
			$vbox.set_global_position(pos)
			emit_signal("selected",self)
