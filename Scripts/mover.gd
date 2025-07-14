extends Area2D

@export var lifeform: Lifeform

@export var dest_for_decreasing: Node2D
@export var dest_for_increasing: Node2D

var states: Array[String] = ["zero", "first_inc", "first_dec", "second_inc", "second_dec"]
var current_state: String = states[0]

var notes: Array[int] = [1,3,5,6,8,10,12]
var note_sequence: Array[String]

func _on_ready() -> void:
	var mover_note = lifeform.song_list[0].split("_")
	var instrument_to_use: String = mover_note[0]
	var note_to_play: int = int(mover_note[1])
	
	var note_index: int = notes.find(note_to_play)
	
	note_sequence.append_array([
		instrument_to_use + "_" + str(notes[note_index - 1]),
		instrument_to_use + "_" + str(notes[note_index]),
		instrument_to_use + "_" + str(notes[note_index + 1])
	])
	
	# print(note_sequence)
	
func _on_area_entered(area: Area2D) -> void:
	var music_resolver: MusicResolver = area.get_parent()
	var music_played: String = music_resolver.instrument_played + "_" + str(music_resolver.note_played)
	
	# Increasing Sequence
	if current_state == states[0] and music_played == note_sequence[0]:
		current_state = states[1]
		$TileMapLayer.set_cell(Vector2i(0,0), 0, Vector2i(10,15))
		$TileMapLayer.set_cell(Vector2i(2,0), 0, Vector2i(12,15))
	
	# Decreasing Sequence
	elif current_state == states[0] and music_played == note_sequence[2]:
		current_state = states[2]
		$TileMapLayer.set_cell(Vector2i(0,1), 0, Vector2i(7,15))
		$TileMapLayer.set_cell(Vector2i(2,1), 0, Vector2i(9,15))
	
	# Note played is Middle of Sequence	
	elif (current_state == states[1] or current_state == states[2]) and music_played == note_sequence[1]:
		if current_state == states[1]: # Middle of INCREASING sequence
			current_state = states[3]
			$TileMapLayer.set_cell(Vector2i(0,1), 0, Vector2i(7,15))
			$TileMapLayer.set_cell(Vector2i(2,1), 0, Vector2i(9,15))
			
		if current_state == states[2]: # Middle of DECREASING sequence
			current_state = states[4]
			$TileMapLayer.set_cell(Vector2i(0,0), 0, Vector2i(10,15))
			$TileMapLayer.set_cell(Vector2i(2,0), 0, Vector2i(12,15))
		
		## Top mid and Bottom mid tiles
		$TileMapLayer.set_cell(Vector2i(1,0), 0, Vector2i(11,15))
		$TileMapLayer.set_cell(Vector2i(1,1), 0, Vector2i(8,15))
		
	
	# Playing Third note in Increasing Sequence
	elif current_state == states[3] and music_played == note_sequence[2]:
		var player: Player = area.get_parent().get_parent()
		
		# Teleport
		# player.position = dest_for_decreasing.global_position
		var tween: Tween = create_tween()
		tween.tween_property(player, "position", dest_for_decreasing.global_position, 1)
		
		current_state = states[0]
		reset()
	
	# Playing Third note in Decreasing Sequence
	elif current_state == states[4] and music_played == note_sequence[0]:
		var player: Player = area.get_parent().get_parent()
		
		# Teleport
		# player.position = dest_for_increasing.global_position
		var tween: Tween = create_tween()
		tween.tween_property(player, "position", dest_for_increasing.global_position, 1)
		
		current_state = states[0]
		reset()
	
	# Incorrect Sequence Played
	else:
		current_state = states[0]
		reset()
		
		var player: Player = music_resolver.get_parent()
		player.num_error_played += 1
		

func reset () -> void:
	## Top right and Top left tiles
	$TileMapLayer.set_cell(Vector2i(0,0), 0, Vector2i(12,15))
	$TileMapLayer.set_cell(Vector2i(2,0), 0, Vector2i(10,15))
		
	## Bottom right and Bottom left tiles
	$TileMapLayer.set_cell(Vector2i(0,1), 0, Vector2i(9,15))
	$TileMapLayer.set_cell(Vector2i(2,1), 0, Vector2i(7,15))
		
	## Top mid and Bottom mid tiles
	$TileMapLayer.set_cell(Vector2i(1,0), 0, Vector2i(8,15))
	$TileMapLayer.set_cell(Vector2i(1,1), 0, Vector2i(11,15))
