tool
extends EditorPlugin
func _enter_tree():
	SpatialGizmo.new()
#	add_spatial_gizmo_plugin()
	pass


func _exit_tree():
	#remove_spatial_gizmo_plugin()
	pass
