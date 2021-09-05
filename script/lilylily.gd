extends Spatial
onready var playback=$AnimationTree.get("parameters/playback")
func _ready():
	pass
#设置表情
func set_morph():
	
	pass
func _input(event):
	if event.is_action_pressed("fly"):
		playback.travel("test")
		#set("parameters/a/blend_position",1)
		#playback.travel("rotate")
	if event.is_action_pressed("esc"):
		playback.travel("idle")
		#set("parameters/a/blend_position",0)
		pass
