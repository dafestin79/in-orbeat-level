extends Control

var next_level = Global.next_level
var accuracy_output: float = snapped(Global.player_accuracy,0.01)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.player_accuracy >= 20 and Global.player_accuracy < 60 :
		$star2.visible = false
		$star3.visible = false
	elif Global.player_accuracy >= 60 and Global.player_accuracy < 90:
		$star3.visible = false
		
	$Label2.text = "ACCURACY:" + str(accuracy_output) + "%"
	pass # Replace with function body.

func _on_next_pressed() -> void:
	Global.player_accuracy = 100
	Global.level_completed = false
	Global.goto_scene(next_level)

func _on_home_pressed() -> void:
	Global.goto_scene("res://Scenes/main_menu.tscn") 

func _on_replay_pressed() -> void:
	Global.player_accuracy = 100
	Global.level_completed = false
	if Global.previous_level:
		Global.goto_scene(Global.previous_level)
