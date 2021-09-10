extends WorldEnvironment



func _on_glow_toggled(button_pressed):
	self.environment.glow_enabled=button_pressed

func _on_ss_reflection_toggled(button_pressed):
	self.environment.ss_reflections_enabled=button_pressed


func _on_graphics_set_item_selected(index):
	if index == 0:
		self.environment = load("res://default_env.tres")
	if index == 1:
		self.environment = load("res://heigh_graphics.tres")
	if index == 2:
		self.environment = load("res://light_break_eyes.tres")
	pass # Replace with function body.
