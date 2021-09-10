extends GridContainer
#选中
signal select
func _ready():
	
	pass
	
func _on_Alice_pressed():
	var select_obj = load("res://scene/models/alice.tscn").instance()
	emit_signal("select",select_obj)
	
func _on_Giantess_toggled(button_pressed):
	visible = button_pressed
	
func _on_lilylily_pressed():
	var select_obj = load("res://scene/models/lilylily.tscn").instance()
	emit_signal("select",select_obj)
	
func _on_Objects_toggled(button_pressed):
	visible = button_pressed
