extends Camera2D

@export var level: int = 0

@onready var music_resolver: MusicResolver = get_node("../MusicResolver")

var active_instrument: String = "piano"

func _ready() -> void:
	var player: Player = get_parent()
	active_instrument = player.allowed_instruments[0]
	
	
	if "piano" in player.allowed_instruments:
		$Control/Piano.disabled = false
		
	if "violin" in player.allowed_instruments:
		$Control/Violin.disabled = false
		
	if "woodwind" in player.allowed_instruments:
		$Control/Woodwind.disabled = false
		
	if "1" in player.allowed_notes:
		$Control/C.disabled = false
		
	if "3" in player.allowed_notes:
		$Control/D.disabled = false
		
	if "5" in player.allowed_notes:
		$Control/E.disabled = false
		
	if "6" in player.allowed_notes:
		$Control/F.disabled = false
		
	if "8" in player.allowed_notes:
		$Control/G.disabled = false
		
	if "10" in player.allowed_notes:
		$Control/A.disabled = false
		
	if "12" in player.allowed_notes:
		$Control/B.disabled = false
	
	#if level == 1:
		#$Control/Violin.disabled = true
		#$Control/Woodwind.disabled = true
		#$Control/F.disabled = true
		#$Control/G.disabled = true
		#$Control/A.disabled = true
		#$Control/B.disabled = true
	#elif level == 2:
		#$Control/Violin.disabled = true
		#$Control/Woodwind.disabled = true
		#$Control/C.disabled = true
		#$Control/D.disabled = true
		#$Control/E.disabled = true
	#elif level == 3:
		##$Control/Piano.disabled = true
		#$Control/Woodwind.disabled = true
		#active_instrument = "violin"

func _on_c_button_down() -> void:
	Input.action_press("play_note")
	Input.action_release("play_note")
	Input.action_press("note_1")
	Input.action_release("note_1")


func _on_d_button_down() -> void:
	Input.action_press("play_note")
	Input.action_release("play_note")
	Input.action_press("note_3")
	Input.action_release("note_3")


func _on_e_button_down() -> void:
	Input.action_press("play_note")
	Input.action_release("play_note")
	Input.action_press("note_5")
	Input.action_release("note_5")


func _on_f_button_down() -> void:
	Input.action_press("play_note")
	Input.action_release("play_note")
	Input.action_press("note_6")
	Input.action_release("note_6")


func _on_g_button_down() -> void:
	Input.action_press("play_note")
	Input.action_release("play_note")
	Input.action_press("note_8")
	Input.action_release("note_8")


func _on_a_button_down() -> void:
	Input.action_press("play_note")
	Input.action_release("play_note")
	Input.action_press("note_10")
	Input.action_release("note_10")


func _on_b_button_down() -> void:
	Input.action_press("play_note")
	Input.action_release("play_note")
	Input.action_press("note_12")
	Input.action_release("note_12")
	
func _on_piano_button_down() -> void:
	Input.action_press("piano")
	Input.action_release("piano")
	active_instrument = "piano"
	music_resolver.instrument_played = "piano"
	
func _on_violin_button_down() -> void:
	Input.action_press("violin")
	Input.action_release("violin")
	active_instrument = "violin"
	music_resolver.instrument_played = "violin"

func _on_woodwind_button_down() -> void:
	#Input.action_press("woodwind")
	#Input.action_release("woodwind")
	active_instrument = "woodwind"

func _on_option_button_item_selected(index: int) -> void:
	Input.action_press("play_instrument")
	Input.action_release("play_instrument")
	
	if index == 0:
		Input.action_press("piano")
		Input.action_release("piano")
		
	if index == 1:
		Input.action_press("violin")
		Input.action_release("violin")
		
func _process(delta: float) -> void:
	if active_instrument == "piano":
		$Control/Radar/AnimatedSprite2D.play("piano")
	elif active_instrument == "violin":
		$Control/Radar/AnimatedSprite2D.play("violin")
	elif active_instrument == "woodwind":
		$Control/Radar/AnimatedSprite2D.play("woodwind")
