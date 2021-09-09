extends AnimationTree
#动画树测试代码
onready var playback=get("parameters/playback")
#onready var a=get("parameters/a/be")
func _ready():
	pass 
func _input(event):
	if event.is_action_pressed("fly"):
		playback.travel("rotate")
		#set("parameters/a/blend_position",1)
		print_debug("rot")
	if event.is_action_pressed("esc"):
		playback.travel("idle")
		#set("parameters/a/blend_position",0)
		print_debug("idle")
