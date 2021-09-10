extends Panel



func _on_resume_pressed():
	hide()
	pass # Replace with function body.

func _on_exit_pressed():
	get_tree().change_scene("res://Main.tscn")

func _on_Menu_toggled(button_pressed):
	visible = button_pressed

func _on_light_value_changed(value):
	$menu/energy.text="能量:"+str(value)
	pass # Replace with function body.
