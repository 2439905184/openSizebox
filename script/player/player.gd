extends KinematicBody
enum all_state{fly_float,fly,walk,idle,jump,drop}
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
var jumping = false
var apply_gravity = true
#线性速度
var linear_velocity = Vector3()
#实时f3显示线性速度
export (NodePath)var linear_path
var label_linear:Label
func _ready():
	player_state = get_parent().get_node("player_state")
	label_linear = get_node(linear_path)
	#print_debug(linear_path)
	#print_debug(label_linear)
	pass
var gravity = Vector3(0,-9.8,0)
func _process(delta):
	#掉出场景 自动重置
	if self.translation.y < -100:
		get_tree().reload_current_scene()
	#线性重力
	linear_velocity += gravity * delta
	#纵向速度
	var vv = linear_velocity.y
	#括号后面的是并列条件
	if state == all_state.fly_float and Input.is_action_just_pressed("jump"):
		state = all_state.fly
		apply_gravity = false
		player_state.text = p_state_t + "fly"
	#垂直飞行
	if state == all_state.fly and (Input.is_action_pressed("jump") or Input.is_action_pressed("e")):
		move_and_slide(Vector3(0,speed*delta,0))
		if !se_fly.is_playing():
			$fly.play(0.08)
	#松开空格 变成悬浮
	if state == all_state.fly and Input.is_action_just_released("jump"):
		state = all_state.fly_float
		player_state.text = p_state_t + "fly float"
	if state == all_state.fly and Input.is_action_pressed("walk"):
		self.rotation_degrees.x = -15
		print_debug("向前飞行 动作")
		player_state.text = p_state_t +"fly "
	#垂直下非
	if state == all_state.fly_float and Input.is_action_pressed("q"):
		move_and_slide(Vector3(0,-speed*delta,0))
		if !se_fly.is_playing():
			$fly.play(0.08)
	#悬浮
	if state == all_state.fly_float:
		var pos_y = fly_float()
		#print_debug(pos_y)
		translate(Vector3(0,pos_y,0))
	#跳起
	if state == all_state.idle and Input.is_action_just_pressed("jump"):
		print_debug("跳起")
		vv = 10.0
		move_and_slide(linear_velocity,Vector3(0,9.8,0))
		state = all_state.drop
		pass
	#不理解为什么两个写一起
	if apply_gravity:
		linear_velocity = Vector3.UP * vv
		linear_velocity = move_and_slide(linear_velocity, Vector3(0,9.8,0))
	label_linear.text = "线性速度:"+str(linear_velocity)
	#重力下落
	if state == all_state.drop:
		if !is_on_floor():
			move_and_slide(Vector3(0,-drop_speed,0),Vector3.UP)
		if is_on_floor():
			state = all_state.idle
			apply_gravity = true
	if state != all_state.fly_float and Input.is_action_just_pressed("walk"):
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
	#变大变小 速度同时变化
	if Input.is_action_pressed("grow"):
		self.scale += Vector3(grow_speed,grow_speed,grow_speed)
		move_speed += grow_speed
		print_debug("移动速度",move_speed)
		show_size()
	if Input.is_action_pressed("small"):
		if self.scale > Vector3(0.09,0.09,0.09):
			move_speed -= grow_speed
			print_debug("移动速度",move_speed)
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
func fly_float():
	var pos_y=0.005*sin(0.03*PI*Engine.get_idle_frames())
	return pos_y
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
#用于重构的同步状态代码
func sync_state_label(value:String):
	player_state.text = p_state_t + value
	pass
#根据第三人称相机的指向飞行
#	if state == all_state.fly_float and Input.is_action_pressed("walk"):
#		move_and_slide(Vector3(0,0,-speed*delta).rotated(Vector3.UP,)
#		$anata/anim.play("fly")
#		pass
