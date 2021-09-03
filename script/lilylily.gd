extends Spatial
onready var tree=$AnimationTree
onready var playback=tree["parameters/lily/playback"]
func _ready():
	print_debug(playback)
func _input(event):
	if event.is_action_pressed("grow"):
		playback.travel("rotate")
	if event.is_action_pressed("esc"):
		playback.travel("idle")
