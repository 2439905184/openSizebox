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
var gravity = Vector3(0,-9.8,0) #重力
#实时f3显示线性速度
export (NodePath)var linear_path
var label_linear:Label
#跳跃力度
var jump_vec = 10
func _ready():
	player_state = get_parent().get_node("player_state")
	label_linear = get_node(linear_path)
func _process(delta):
	#掉出场景 自动重置
	if self.translation.y < -100:
		get_tree().reload_current_scene()
	#线性重力
	linear_velocity += gravity * delta
	#纵向速度
	var vv = linear_velocity.y
	#垂直上飞
	if state == all_state.fly and (Input.is_action_pressed("jump") or Input.is_action_pressed("e")):
		move_and_slide(Vector3(0,speed*delta,0))
		if !se_fly.is_playing():
			$fly.play(0.08)
	#垂直下飞
	if state == all_state.fly and Input.is_action_pressed("q"):
		move_and_slide(Vector3(0,-speed*delta,0))
		if !se_fly.is_playing():
			$fly.play(0.08)
	#向前飞行 做的动作
	if state == all_state.fly_float and Input.is_action_pressed("walk"):
		self.rotation_degrees.x = 45
		print_debug("向前飞行 动作")
		sync_state_label("fly")
	#悬浮
	if state == all_state.fly_float:
		var pos_y = fly_float()
		translate(Vector3(0,pos_y,0))
	#跳起后下落
	if state == all_state.idle and Input.is_action_just_pressed("jump"):
		print_debug("跳起")
		vv = jump_vec
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
		#下落实现
		if !is_on_floor():
#			if Input.is_action_just_pressed("fly"):
#				state = all_state.fly_float
#				print_debug("下落中悬浮")
#				sync_state_label("fly float")
			move_and_slide(Vector3(0,-drop_speed,0),Vector3.UP)
		if is_on_floor():
			state = all_state.idle
			apply_gravity = true
	#走路代码实现
	if Input.is_action_pressed("walk"):
		walk("front")
	if Input.is_action_pressed("walk_back"):
		walk("back")
	#变大变小 速度同时变化 跳跃力度同时变化 
	if Input.is_action_pressed("grow"):
		self.scale += Vector3(grow_speed,grow_speed,grow_speed)
		move_speed += grow_speed
		jump_vec += grow_speed
		print_debug("移动速度",move_speed)
		print_debug("跳跃力度",jump_vec)
		show_size()
	if Input.is_action_pressed("small"):
		if self.scale > Vector3(0.09,0.09,0.09):
			move_speed -= grow_speed
			jump_vec -= grow_speed
			print_debug("移动速度",move_speed)
			print_debug("跳跃力度",jump_vec)
			self.scale-=Vector3(grow_speed,grow_speed,grow_speed)
			show_size()
func walk(dir):
	if dir == "front":
		move_and_slide(Vector3(0,0,move_speed))
		
	if dir == "back":
		move_and_slide(Vector3(0,0,-move_speed))
		
	if !foot.is_playing():
		foot.play()
		
	if !anim.is_playing():
		anim.play("walk")
		
	pass
#悬浮计算
func fly_float():
	var pos_y=0.005*sin(0.03*PI*Engine.get_idle_frames())
	return pos_y
	
func _input(event):
	#再次按下f 下落
	if event.is_action_pressed("fly") and state == all_state.fly_float:
		state = all_state.drop
		sync_state_label("drop")
		print_debug("下落！")
	if event.is_action_pressed("fly") and (state == all_state.idle or state ==all_state.walk):
		print_debug("悬浮！")
		state = all_state.fly_float
		sync_state_label("fly_float")
		#先复位 后飞行
		anim.play("idle")
		anim.play("fly_float")
	#如果在悬浮 并按下空格 或者e 或者q 切换到飞行状态 并禁用重力
	if state == all_state.fly_float and (event.is_action_pressed("jump") or event.is_action_pressed("e") or event.is_action_pressed("q")):
		state = all_state.fly
		apply_gravity = false
		sync_state_label("fly")
		player_state.text = p_state_t + "fly"
	#松开空格和q 变成悬浮
	if state == all_state.fly and (event.is_action_released("jump") or event.is_action_released("q")):
		state = all_state.fly_float
		sync_state_label("fly float")
	#切换到走路状态
	if state == all_state.idle and Input.is_action_just_pressed("walk"):
			state = all_state.walk
			sync_state_label("walk")
	#切换到待机状态
	if state == all_state.walk and Input.is_action_just_released("walk"):
			state = all_state.idle
			sync_state_label("idle")
func show_size():
	if not $Size.visible:
		$Size.show()
	$Size.text="Size:"+str(self.scale.x)
	
func _on_Tab_track_enable():
	$anata/h.track_mouse=true
#同步状态 显示在游戏屏幕
func sync_state_label(value:String):
	player_state.text = p_state_t + value 
	pass
# todo 根据第三人称相机的指向飞行
