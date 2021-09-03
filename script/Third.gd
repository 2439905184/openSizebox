extends Spatial
#灵敏度
var mouse_sense=0.005
#反向
var invert_y = false
var invert_x = false
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass
func _input(event):
	if event.is_action_pressed("esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseMotion:
		if event.relative.x != 0:
			var dir = 1 if invert_x else -1
			#-1.4限制向前旋转 -0.01限制向后旋转 rotation是弧度
			$v.rotation.x= clamp($v.rotation.x,-1.4,0.5)
			rotate_object_local(Vector3.UP, dir * event.relative.x * mouse_sense)
			#print_debug($v.rotation.x)
		if event.relative.y!=0:
			var dir=1 if invert_y else -1
			var y_rotation = clamp(event.relative.y, -30, 30)
			#rotate_object_local(Vector3.UP,event.relative.x*mouse_sense)
			$v.rotate_object_local(Vector3.RIGHT, dir*y_rotation * mouse_sense)
func _process(delta):
	#$h.rotation_degrees.y=camrot_h
	#$h/v/Camera.rotation_degrees.x=camrot_v
	pass
