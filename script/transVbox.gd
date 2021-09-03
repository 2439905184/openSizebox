extends VBoxContainer
func _ready():
	pass
func _on_slider_scale_value_changed(value):
	$size_info.text="size:"+str(value)
	pass
