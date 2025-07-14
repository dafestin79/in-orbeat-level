extends Node2D
class_name MovingPlatform

@export var offset: Vector2 = Vector2(0, -250)
@export var duration: float = 5.0
@export var is_ledge: bool = false
var up: String = ""

func moving_tween():
	var tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops(1)
	tween.tween_property($".", "position", position + offset, duration / 2)
	tween.tween_property($".", "position", position, duration / 2)
	
func ledge_tween():
	var tween = get_tree().create_tween().set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.set_loops(1)
	tween.tween_property($".", "position", position + offset, duration / 2)

func _on_switch_switch_on(name: String) -> void:
	if is_ledge:
		ledge_tween()
	
	if Input.is_key_pressed(KEY_U) and up.length() == 0:
		up += "1"
		
	elif Input.is_key_pressed(KEY_I) and up.length() == 1:
		up += "1"
		
	elif Input.is_key_pressed(KEY_O) and up.length() == 2:
		up += "1"
	else:
		up = ""
		
	if up == "111":
		moving_tween()


func _on_switch_2_switch_on(name: String) -> void:
	if is_ledge:
		ledge_tween()


func _on_switch_3_switch_on(name: String) -> void:
	if is_ledge:
		ledge_tween()


func _on_switch_4_switch_on(name: String) -> void:
	if is_ledge:
		ledge_tween()
