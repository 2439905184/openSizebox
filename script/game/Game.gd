extends Spatial
var alice
var move_pos
var speed=1
var index=0
var action="前"
var sel_obj
#是否放下物体
var placed=false
var sel_anim
func _ready():
	move_pos=get_tree().get_nodes_in_group("move_pos")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _input(event):
	if event.is_action_pressed("esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event.is_action_pressed("editMode"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$player/anata/h.track_mouse=false
		$Tab.show()
# warning-ignore:unused_argument
func _process(delta):
	#s[index].translation,delta*speed)
	pass
# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if sel_obj!=null:
		if event is InputEventMouseMotion and placed==false:
			sel_obj.translation=click_position
		if event is InputEventMouseButton and placed==false:
			placed=true
			sel_obj.translation = click_position
		print_debug(placed)
#选择了gts 准备放置
func _on_GridContainer_select(select_obj):
	sel_obj=select_obj
	add_child(sel_obj)
	#sel_obj.connect("selected",self,"select",[])
	#sel_anim=sel_obj.get_node("anim")
	$tip.text="选中的对象:"+str(sel_obj)
func select(obj):
	sel_obj=obj
	$tip.text="选中的对象:"+str(sel_obj)
	pass
func _on_Animation_toggled(button_pressed):
	$AnimationPanel.visible=button_pressed
	pass # Replace with function body.
func _on_walk_pressed():
	sel_anim.play("walk")
	pass
func _on_angry_pressed():
	sel_anim.play("ANGRY")
	pass # Replace with function body.
func _on_Transform_toggled(button_pressed):
	$TransfromPanel.visible=button_pressed
	pass # Replace with function body.
func _on_slider_scale_value_changed(value):
	if sel_obj!=null:
		sel_obj.scale=Vector3(value,value,value)
func _on_slider_rot_x_value_changed(value):
	if sel_obj!=null:
		sel_obj.rotation_degrees.x=value
func _on_slider_rot_y_value_changed(value):
	if sel_obj!=null:
		sel_obj.rotation_degrees.y=value
func _on_slider_rot_z_value_changed(value):
	if sel_obj!=null:
		sel_obj.rotation_degrees.z=value
#移动选中的对象
func _on_Move_pressed():
	if sel_obj!=null:
		placed=false
	pass
#选中了对象 alice被选中 gts被选中等 接受信号的地方
func _on_obj_selected(obj):
	sel_obj=obj
	$tip.text="选中的对象:"+str(sel_obj)
