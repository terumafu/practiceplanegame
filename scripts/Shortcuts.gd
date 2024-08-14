extends Node

func _process(delta):
	if Input.is_action_just_pressed("Close"):
		get_tree().quit()
	if Input.is_action_just_pressed("Reset"):
		get_tree().reload_current_scene()
