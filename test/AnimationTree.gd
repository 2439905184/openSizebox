extends AnimationTree

onready var playback=get("parameters/playback")
onready var blend=get("parameters/a/blend_position")
func _ready():
#	playback.travel("rotate")
	pass
func _input(event):
	if event.is_action_pressed("fly"):
		playback.travel("a")
		set("parameters/a/blend_position",1)
		#playback.travel("rotate")
	if event.is_action_pressed("esc"):
		playback.travel("idle")
		#set("parameters/a/blend_position",0)
		pass
