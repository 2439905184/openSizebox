extends Control
#捕捉鼠标位置
signal track_enable
func _on_Close_pressed():
	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	emit_signal("track_enable")
