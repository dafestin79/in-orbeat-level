extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.tutorial_passed:
		$"buttons-container/new-game-button".disabled = false
		$"buttons-container/continue-button".disabled = false
		
func _on_start_pressed() -> void:
	#Global.delete_save()
	if Global.tutorial_passed:
		
		Global.goto_scene("res://Scenes/level_1.tscn")


func _on_continue_pressed() -> void:
	if Global.tutorial_passed:
		
		Global.goto_scene("res://Scenes/level_select.tscn")


func _on_tutorial_pressed() -> void:
	Global.goto_scene("res://Scenes/level_tutorial.tscn")


func _on_credits_pressed() -> void:
	Global.goto_scene("res://Scenes/end_credits.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
