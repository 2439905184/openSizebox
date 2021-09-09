extends GridContainer
#选中
signal select
func _ready():
	pass
func _on_Alice_pressed():
	var select_obj= load("res://scene/models/alice.tscn").instance()
	emit_signal("select",select_obj)
func _on_Giantess_toggled(button_pressed):
	if button_pressed:
		show()
	else:
		hide()
	pass 
func _on_lilylily_pressed():
	var select_obj= load("res://scene/models/lilylily.tscn").instance()
	emit_signal("select",select_obj)
