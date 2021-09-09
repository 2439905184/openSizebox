extends Spatial
class_name VRMTopLevel

export var vrm_skeleton: NodePath
export var vrm_animplayer: NodePath
export var vrm_secondary: NodePath

export var vrm_meta: Resource

export var update_secondary_fixed: bool = false

export var update_in_editor: bool = false
export var gizmo_spring_bone: bool = false
export var gizmo_spring_bone_color: Color = Color.yellow
var del=0.05
var speed=2
#掉落速度
var drop_speed=8
#onready var third=$thrid
var foot
onready var anim=$anim
var rotate_speed=0.2
var action

#var selected=false

enum player_actions{fly,idle,walk}
var player_action
signal selected
var anim_tree
var anim_playback
func _ready():
	if self.name=="anata":
		foot=$foot
		anim_tree=$AnimationTree
		anim_playback=anim_tree["parameters/playback"]#.get("parameters/playback")
		print_debug(anim_tree)
		print_debug(anim_playback)
	pass
func show_size():
	if not $Label.visible:
		$Label.show()
	$Label.text="Size:"+str(self.scale.x)
func _process(delta):
	if self.name=="alice":
		if action=="stop_other":
			pass
	if self.name=="anata":
		if Input.is_action_pressed("grow"):
			self.scale+=Vector3(del,del,del)
			show_size()
		if Input.is_action_pressed("small"):
			self.scale-=Vector3(del,del,del)
			show_size()
		if Input.is_action_just_pressed("jump"):
			self.translation.y+=10
		if self.translation.y>0:
			self.translation.y-=drop_speed*delta
			print_debug("下落")
		if Input.is_action_just_released("walk"):
			anim_playback.travel("idle")
		if Input.is_action_just_pressed("walk"):
			$Skeleton.rotation.y=$h.rotation.y
			$Skeleton.translate_object_local(Vector3(0,0,-speed*delta))
			#if !anim.is_playing():
			anim_playback.start("walk")
			print_debug("走路状态")
				#anim.play("walk")
			if foot!=null:
				if !foot.is_playing():
					foot.play()
func _input(event):
	if self.name=="anata":
		#F
		if event.is_action_pressed("fly"):
			player_action=player_actions.fly
		if event is InputEventMouseButton:
			if event.button_index==BUTTON_MIDDLE:
				$face.make_current()
			if event.button_index==BUTTON_RIGHT:
				$h/v/Camera.make_current()
		if event.is_action_pressed("r"):
			get_tree().reload_current_scene()
class VRMUtil:
	static func from_to_rotation(from: Vector3, to: Vector3):
		var axis: Vector3 = from.cross(to)
		if is_equal_approx(axis.x, 0.0) and is_equal_approx(axis.y, 0.0) and is_equal_approx(axis.z, 0.0):
			return Quat.IDENTITY
		var angle: float = from.angle_to(to)
		if is_equal_approx(angle, 0.0):
			angle = 0.0
		return Quat(axis.normalized(), angle)
	
	static func transform_point(transform: Transform, point: Vector3) -> Vector3:
		var sc = transform.basis.get_scale()
		return transform.basis.get_rotation_quat() * Vector3(point.x * sc.x, point.y * sc.y, point.z * sc.z) + transform.origin
	
	static func inv_transform_point(transform: Transform, point: Vector3) -> Vector3:
		var diff = point - transform.origin
		var sc = transform.basis.get_scale()
		return transform.basis.get_rotation_quat().inverse() * Vector3(diff.x / sc.x, diff.y / sc.y, diff.z / sc.z)
	
	# UniVRM will match XY-axis between Unity and OpenGL, so Z-axis will be flipped.
	# The coordinate issue may be fixed in VRM 1.0 or later.
	# https://github.com/vrm-c/vrm-specification/issues/205
	static func coordinate_u2g(vec: Vector3) -> Vector3:
		return Vector3(vec.x, vec.y, -vec.z)
func _on_Tab_track_enable():
	if self.name=="anata":
		$h.track_mouse=true
		print_debug($h.track_mouse)



func _on_stop_pressed():
	if self.name=="alice":
		action="stop_other"
func _on_close_pressed():
	$vbox.hide()
func _on_remove_pressed():
	queue_free()
func _on_select_pressed():
	emit_signal("selected",self)
	pass # Replace with function body.
