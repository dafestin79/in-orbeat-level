extends Area2D

@export var notes_list: Array[String]
@export var num_notes_to_play: int = 3
@export var next_scene_path: String
@export var is_randomized: bool = false

var successfully_played: int = 0
var errors_played = 0
var player_near: bool = false

func _ready() -> void:
	randomized_notes_list()

func _physics_process(_delta: float) -> void:
	if player_near and Input.is_action_just_pressed("interact"):
		var i: int = 0
		for audio in notes_list:
			if i < num_notes_to_play:
				var music_player = "res://Assets/Audio/" + audio + ".wav"
				
				$AudioStreamPlayer2D.stream = ResourceLoader.load(music_player)
				$AudioStreamPlayer2D.play()
				await $AudioStreamPlayer2D.finished
			
			i += 1

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_near = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player_near = false	


func _on_area_entered(area: Area2D) -> void:
	var music_resolver: MusicResolver = area.get_parent()
	var music_played: String = music_resolver.instrument_played + "_" + str(music_resolver.note_played)
	# music_resolver.set_disabled(true)

	if music_played == notes_list[successfully_played]:
		$TileMapLayer.set_cell(Vector2i(0,0), 0, Vector2i(12,12))
		successfully_played += 1
		
		if successfully_played == num_notes_to_play: 
			
			successfully_played = 0
			await music_resolver.finished
			
			var player: Player = music_resolver.get_parent()
			Global.player_accuracy = player.player_accuracy
			Global.next_level = next_scene_path
			Global.previous_level = get_tree().current_scene.scene_file_path
			
			if player.level == Global.unlocked_levels:  
				Global.unlocked_levels += 1
				Global.level_completed = true
			
			if get_parent().name == "level_tutorial":
				Global.tutorial_passed = true
			
			# Game automatically saves everytime the level finishes
			Global.save_game()
			
			Global.goto_scene("res://Scenes/level_complete.tscn")
			# get_tree().change_scene_to_file(next_scene_path)
		
	else: # Reset upon MISTAKE
		$TileMapLayer.set_cell(Vector2i(0,0), 0, Vector2i(11,12))
		successfully_played = 0
		errors_played += 1
		
		if errors_played > 3:
			randomized_notes_list()
			errors_played = 0
		
		var player: Player = music_resolver.get_parent()
		player.num_error_played += 1
		
func randomized_notes_list () -> void:
	# randomize()
	notes_list.shuffle()
