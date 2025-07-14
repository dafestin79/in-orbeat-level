extends Node

@onready var text_box_scene = preload("res://Scenes/text_box.tscn")

var dialog_lines: Array[String] = []
var current_line_index = 0

var text_box
var text_box_position: Vector2

var sfx: AudioStream

var is_dialog_active = false
var can_advance_line = false

func start_dialog(position: Vector2, lines: Array[String], speech_sfx: AudioStream):
	if is_dialog_active:
		return
		
	dialog_lines = lines
	text_box_position = position
	sfx = speech_sfx
	show_text_box()
		
	is_dialog_active = true
		
func show_text_box():
	text_box = text_box_scene.instantiate()
	text_box.finished_displaying.connect(on_text_box_finished_displaying)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	text_box.display_text(dialog_lines[current_line_index], sfx)
	can_advance_line = false
	
func on_text_box_finished_displaying():
	can_advance_line = true
	
func continue_dialog():
	if (
		is_dialog_active && can_advance_line
	):
		print("dialog box advanced")
		text_box.queue_free()
		
		current_line_index += 1
		if current_line_index >= dialog_lines.size():
			is_dialog_active = false
			current_line_index = 0
			return
			
		show_text_box()
		
func terminate_dialog():
	if is_dialog_active:
		if text_box: #Check if text_box exists before queue_free()
			text_box.queue_free()
		is_dialog_active = false
		current_line_index = 0
