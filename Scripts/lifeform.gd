extends Area2D

class_name Lifeform

@export var song_list: Array[String]
@export var instruments_selection: Array[String] = ["piano"]
@export var notes_selection: Array[String] = ["1","3","5"]
@export var num_songs: int = 1
@export var is_lifeform_for_vertice = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var animated_notes = get_node("AnimatedNote")

var player_near: bool = false

func _ready():
	animated_sprite.play("default")
	randomize_song_list()

func _physics_process(_delta: float) -> void:
	if player_near and Input.is_action_just_pressed("interact"):
		for audio in song_list:
			var music_player = "res://Assets/Audio/" + audio + ".wav"
			
			if 1 == int(audio):
				$AnimatedNote.play("green")
			elif 3 == int(audio):
				$AnimatedNote.play("blue")
			elif 5 == int(audio):
				$AnimatedNote.play("cyan")
			elif 6 == int(audio):
				$AnimatedNote.play("red")
			elif 8 == int(audio):
				$AnimatedNote.play("orange")
			elif 10 == int(audio):
				$AnimatedNote.play("purple")
			elif 12 == int(audio):
				$AnimatedNote.play("yellow")
				
			$AudioStreamPlayer2D.stream = ResourceLoader.load(music_player)
			$AudioStreamPlayer2D.play()
			await $AudioStreamPlayer2D.finished

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_near = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		player_near = false

func randomize_song_list () -> void:
	if is_lifeform_for_vertice:
		var new_song_list: Array[String] = []
		
		for song in song_list:
			var song_note = song.split("_")
			var instrument: String = song_note[0]
			var note: String = song_note[1]
			
			var note_index: int = notes_selection.find(note)
			var new_index: int = (note_index + Global.switch_seed) % len(notes_selection)
			
			new_song_list.append(instrument + "_" + notes_selection[new_index])
			
		song_list.assign(new_song_list)
		
	else:
		song_list.clear()
		while len(song_list) < num_songs:
			var temp: String = (
				instruments_selection.pick_random() + "_" + 
				str(notes_selection.pick_random())
			)

			if temp not in song_list:
				song_list.append(
					temp
				)
