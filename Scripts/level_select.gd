extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in $CenterContainer/levels.get_children():
		i.text = i.name
	
	for i in range($CenterContainer/levels.get_child_count()):
		Global.levels.append(i+1)
	
	for level in $CenterContainer/levels.get_children():
		if str_to_var(level.name) in range(Global.unlocked_levels+1):
			level.disabled = false
			level.pressed.connect(self.goto_level.bind(level.name))
		else:
			level.disabled = true


func goto_level(level_number):
	var scene: String = "res://Scenes/level_" + str(level_number) + ".tscn"
	if ResourceLoader.exists(scene):
		Global.goto_scene(scene)

func _on_back_pressed() -> void:
	Global.goto_scene("res://Scenes/main_menu.tscn")
