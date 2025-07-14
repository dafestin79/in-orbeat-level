extends Node2D

func _on_area_2d_area_entered(_area: Area2D) -> void:
	$Sprite2D.hide()
	
func _on_area_2d_area_exited(_area: Area2D) -> void:
	$Sprite2D.show()

func _on_guitar_pressed() -> void:
	hide()

func _on_piano_pressed() -> void:
	show()
