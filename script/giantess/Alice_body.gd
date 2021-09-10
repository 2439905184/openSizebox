extends KinematicBody
enum action{grow,small,stop_grow}
var grow_speed=0.25
var act
signal selected
func _ready():
	connect("selected",get_tree().current_scene.get_node("."),"_on_obj_selected",[])
	pass
func _process(delta):
	if act == action.grow:
		change_scale("big",delta)
	if act == action.small:
		change_scale("small",delta)
	if act == action.stop_grow:
		pass
func _on_grow_pressed():
	act = action.grow
func _on_shrunk_pressed():
	act = action.small
#mode: big or small
func change_scale(mode,delta):
	if mode == "big":
		self.scale+=Vector3(1,1,1)*grow_speed*delta
	if mode == "small":
		self.scale-=Vector3(1,1,1)*grow_speed*delta
func _on_select_pressed():
	$vbox.hide()
	emit_signal("selected",self)
	pass # Replace with function body.
func _on_close_pressed():
	$vbox.hide()
	pass # Replace with function body.
func _on_remove_pressed():
	queue_free()
	pass
#放置模型代码 可能移动代码位置
func _on_alice_input_event(camera, event, click_position, click_normal, shape_idx):
	if "alice" in self.name and event is InputEventMouseButton:
		if event.button_index==BUTTON_RIGHT:
			$vbox.show()
			var pos=camera.unproject_position(click_position)
			print_debug(pos)
			$vbox.set_global_position(pos)
func _on_stop_pressed():
	act = action.stop_grow
	pass 
