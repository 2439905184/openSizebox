extends KinematicBody
enum all_state{fly_float,fly,walk,idle,drop}
var state=all_state.idle
var move_speed = 2
var speed = 100
var drop_speed = 1
onready var anim = $anata/AnimationPlayer
onready var foot = $foot
onready var se_fly = $fly
var grow_speed = 0.05
var player_state:Label
var p_state_t = "玩家状态机:"
func _ready():
	player_state = get_parent().get_node("player_state")
	pass
func _process(delta):
	#括号后面的是并列条件
	if state == all_state.fly_float and (Input.is_action_pressed("jump") or Input.is_action_pressed("e")):
		move_and_slide(Vector3(0,speed*delta,0))
		if !se_fly.is_playing():
			$fly.play(0.08)
	if state == all_state.fly_float and Input.is_action_pressed("q"):
		move_and_slide(Vector3(0,-speed*delta,0))
		if !se_fly.is_playing():
			$fly.play(0.08)
	#重力下落
	if state == all_state.drop:
		if !is_on_floor():
			move_and_slide(Vector3(0,-drop_speed,0),Vector3.UP)
		if is_on_floor():
			state = all_state.idle
	#根据第三人称相机的指向飞行
#	if state == all_state.fly_float and Input.is_action_pressed("walk"):
#		move_and_slide(Vector3(0,0,-speed*delta).rotated(Vector3.UP,)
#		$anata/anim.play("fly")
#		pass
	if Input.is_action_just_pressed("walk"):
		if state == all_state.fly_float:
			state = all_state.idle
			anim.play("idle")
			print_debug("状态机",state)
			player_state.text = p_state_t + "idle"
		#$anata/Armature/Skeleton.rotation.y=$anata/h.rotation.y
		pass
	if Input.is_action_pressed("walk"):
		walk("front")
	if Input.is_action_pressed("walk_back"):
		walk("back")
	#变大变小
	if Input.is_action_pressed("grow"):
		self.scale+=Vector3(grow_speed,grow_speed,grow_speed)
		show_size()
	if Input.is_action_pressed("small"):
		self.scale-=Vector3(grow_speed,grow_speed,grow_speed)
		show_size()
func walk(dir):
	if dir == "front":
		move_and_slide(Vector3(0,0,move_speed))
		pass
	if dir == "back":
		move_and_slide(Vector3(0,0,-move_speed))
	if !foot.is_playing():
		foot.play()
	if !anim.is_playing():
		anim.play("walk")
		pass
	pass

func _input(event):
	#再次按下f 下落
	if event.is_action_pressed("fly") and state == all_state.fly_float:
		state = all_state.drop
		player_state.text = p_state_t + "drop"
		print_debug("下落！")
	if event.is_action_pressed("fly") and state == all_state.idle:
#		state = all_state.drop
		print_debug("悬浮！")
		state = all_state.fly_float
		player_state.text = p_state_t + "fly_float"
		#先复位 后飞行
		anim.play("idle")
		anim.play("fly_float")
func show_size():
	if not $Size.visible:
		$Size.show()
	$Size.text="Size:"+str(self.scale.x)
func _on_Tab_track_enable():
	$anata/h.track_mouse=true
	pass # Replace with function body.
