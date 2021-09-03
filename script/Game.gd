extends Spatial
var alice
var move_pos
var speed=1
var index=0
var action="前"
var sel_obj
#是否放下物体
var placed=false
func _ready():
	#alice=$"AliciaSolid_vrm-051"
	move_pos=get_tree().get_nodes_in_group("move_pos")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _input(event):
	if event.is_action_pressed("esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event.is_action_pressed("editMode"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$anata/h.track_mouse=false
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
			sel_obj.translation=click_position
		print_debug(placed)
func _on_GridContainer_select(select_obj):
	sel_obj=select_obj
	add_child(sel_obj)
	pass # Replace with function body.
