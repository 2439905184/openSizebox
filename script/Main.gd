extends Node2D



func _on_github_pressed():
	OS.shell_open("https://github.com/2439905184/openSizebox")
	
func _on_start_pressed():
	$menu.hide()
	$map.show()
	pass # Replace with function body.
	
func _on_cancel_pressed():
	$menu.show()
	$map.hide()
	
func _on_startGame_pressed():
	print_debug("加载中...请稍后")
	get_tree().change_scene("res://Game.tscn")
	
func _on_exit_pressed():
	get_tree().quit()
