extends Spatial
onready var tree = $AnimationTree
var state_machine
func _ready():
	#state_machine = $AnimationTree.get("parameters/playback")
	#print_debug(state_machine)
	pass
func _input(event):
	if event.is_action_pressed("r"):
		get_tree().reload_current_scene()
#	if event.is_action_pressed("fly"):
#
#		pass
		#tree.set("parameters/walk/blend_amount",1)
		#print_debug(tree.get("parameters/walk/blend_amount"))
		#print_debug("travel")
		pass
