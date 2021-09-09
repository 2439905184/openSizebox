extends KinematicBody
enum all_state{fly_float,fly,walk,idle}
var state
var speed = 100
func _process(delta):
	if state == all_state.fly_float and Input.is_action_pressed("jump") or Input.is_action_pressed("e"):
		if state == all_state.fly_float:
			move_and_slide(Vector3(0,speed*delta,0))
	if state == all_state.fly_float and Input.is_action_pressed("q"):
		move_and_slide(Vector3(0,-speed*delta,0))
	#根据第三人称相机的指向飞行
	if state == all_state.fly_float and Input.is_action_pressed("walk"):
#		move_and_slide(Vector3(0,0,-speed*delta).rotated(Vector3.UP,)
		$anata/anim.play("fly")
func _input(event):
	if event.is_action_pressed("fly"):
		state = all_state.fly_float
		$anata/anim.play("LOOKUP")
	
