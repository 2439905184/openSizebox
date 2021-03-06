extends Spatial
var alice
var move_pos
var speed=1
var index=0
var action="前"
var sel_obj
#是否放下物体
var placed = false
var sel_anim
var enable_debug_info = false
func _ready():
	move_pos=get_tree().get_nodes_in_group("move_pos")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _input(event):
	#调试信息
	if event.is_action_pressed("f3"):
		enable_debug_info = true
		$debug.show()
		get_tree().debug_collisions_hint=true
	if event.is_action_pressed("esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event.is_action_pressed("editMode"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$player/anata/h.track_mouse=false
		$Tab.show()
# warning-ignore:unused_argument
func _process(delta):
	if enable_debug_info:
		$debug.text = "位置:"+str($player.translation)

func _on_StaticBody_input_event(camera, event, click_position, click_normal, shape_idx):
	if sel_obj != null:
		if event is InputEventMouseMotion and placed == false:
			sel_obj.translation = click_position
		if event is InputEventMouseButton and placed == false:
			placed = true
			print_debug("放置",placed)
	#print_debug(camera)
#选择了gts 准备放置
func _on_GridContainer_select(select_obj):
	sel_obj = select_obj
	add_child(sel_obj)
	placed = false
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
	sel_obj = obj
	$tip.text = "选中的对象:"+str(sel_obj)
#添加程序化城市
func _on_code_city_pressed():
	#城市空隙
	var city_space = 100
	#是否有npc
	var has_people = false
	#城市楼房高度
	var city_height = 100
	#城市大小
	var city_size = 100 
	#单独的楼房场景
#	var city_cell = load("res://models/building.obj").instance()
#	sel_obj = city_cell
#	for i in 100:
#		city_cell.translation.x += city_space
#		add_child(city_cell)
	pass
