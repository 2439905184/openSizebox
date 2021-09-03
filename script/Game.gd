extends Spatial
var alice
var move_pos
var speed=1
func _ready():
	alice=$"AliciaSolid_vrm-051"
	move_pos=get_tree().get_nodes_in_group("move_pos")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _input(event):
	if event.is_action_pressed("esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
func _process(delta):
	var target=self.translation.move_toward(move_pos[0].translation,delta*speed)
	alice.translate(target)
	print_debug(target)
	
#	if alice.translation.z<=move_pos[0].translation.z:
#		alice.translate(Vector3(-speed*delta,0,0))
	#print_debug(alice.translation.z)
