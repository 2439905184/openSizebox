extends GridContainer
var select_obj
#选中
signal select
func _ready():
	pass
func _on_Alice_pressed():
	select_obj= load("res://AliciaSolid_vrm051.tscn").instance()
	emit_signal("select",select_obj)
func _on_Giantess_toggled(button_pressed):
	if button_pressed:
		show()
	else:
		hide()
	pass # Replace with function body.
