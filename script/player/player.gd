extends KinematicBody
enum all_state{fly_float,fly,walk,idle}
var state
var move_speed = 2
var speed = 100
onready var anim = $anata/AnimationPlayer
onready var foot = $foot
var grow_speed = 0.05
func _process(delta):
	if state == all_state.fly_float and Input.is_action_pressed("jump") or Input.is_action_pressed("e"):
		if state == all_state.fly_float:
			move_and_slide(Vector3(0,speed*delta,0))
	if state == all_state.fly_float and Input.is_action_pressed("q"):
		move_and_slide(Vector3(0,-speed*delta,0))
	#根据第三人称相机的指向飞行
	if state == all_state.fly_float and Input.is_action_pressed("walk"):
#		move_and_slide(Vector3(0,0,-speed*delta).rotated(Vector3.UP,)
		#$anata/anim.play("fly")
		pass
	if Input.is_action_just_pressed("walk"):
		#$anata/Armature/Skeleton.rotation.y=$anata/h.rotation.y
		pass
	if Input.is_action_pressed("walk"):
		move_and_slide(Vector3(0,0,move_speed))
		if !foot.is_playing():
			foot.play()
		if !anim.is_playing():
			#print_debug("走路状态")
			anim.play("walk")
	#变大变小
	if Input.is_action_pressed("grow"):
		self.scale+=Vector3(grow_speed,grow_speed,grow_speed)
		show_size()
	if Input.is_action_pressed("small"):
		self.scale-=Vector3(grow_speed,grow_speed,grow_speed)
		show_size()
func _input(event):
	if event.is_action_pressed("fly"):
		state = all_state.fly_float
func show_size():
	if not $Size.visible:
		$Size.show()
	$Size.text="Size:"+str(self.scale.x)
func _on_Tab_track_enable():
	$anata/h.track_mouse=true
	pass # Replace with function body.
