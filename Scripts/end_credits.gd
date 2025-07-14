extends Control

const SCROLLSPEED: int = 20

var og_pos: Vector2

func _ready() -> void:
	og_pos = $Panel/Label.position

func _process(delta: float) -> void:
	$Panel/Label.position += Vector2(0, SCROLLSPEED * delta)
	
	if $Panel/Label.position[1] > 666:
		$Panel/Label.position = og_pos

func _on_backbutton_pressed() -> void:
	Global.goto_scene("res://Scenes/main_menu.tscn")
