extends Spatial
#灵敏度
var mouse_sense=0.005
#反向
var invert_y = false
var invert_x = false
var zoom_speed = 0.09
var max_zoom=3.0
var min_zoom=0.5
var zoom=1.5
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass
func _input(event):
	#缩小
	if event.is_action_pressed("zoom_in"):
		zoom -= zoom_speed
	if event.is_action_pressed("zoom_out"):
		zoom += zoom_speed
	zoom = clamp(zoom,min_zoom,max_zoom)
	if event.is_action_pressed("esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#相机旋转代码
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
			$v.rotate_object_local(Vector3.RIGHT, dir*y_rotation * mouse_sense)
func _process(delta):
	scale=lerp(scale, Vector3.ONE * zoom, zoom_speed)
	pass
