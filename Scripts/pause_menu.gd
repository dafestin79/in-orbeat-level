extends Control

func _ready():
	$"..".layer = -1
	$AnimationPlayer.play("RESET")

func resume():
	$"..".layer = -1
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	
func pause():
	$"..".layer = 1
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
func testEsc():
	if Input.is_action_just_pressed("Escape") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("Escape") and get_tree().paused == true:
		resume()


func _on_resume_pressed() -> void:
	resume()


func _on_restart_pressed() -> void:
	resume()
	Global.reset_scene()


func _on_quit_pressed() -> void:
	resume()
	Global.goto_scene("res://Scenes/main_menu.tscn")

func _process(_delta: float) -> void:
	testEsc()
