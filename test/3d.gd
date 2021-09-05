extends Spatial
onready var playback=$AnimationTree.get("parameters/playback")
func _ready():
	print_debug(playback)
func _input(event):
	if event.is_action_pressed("fly"):
		playback.travel("r")
	if event.is_action_pressed("esc"):
		playback.travel("l")
