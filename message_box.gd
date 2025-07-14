extends CanvasLayer

const CHAR_READ_RATE = 0.05

@onready var textbox_container = $TextboxContainer
@onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/start
@onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/end
@onready var message = $TextboxContainer/MarginContainer/HBoxContainer/message

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []
var current_tween: Tween

func _ready() -> void:
	print("Starting state to: State.READY")
	hide_textbox()
	queue_text("Hello world! Englishera latina arf arf")
	queue_text("The quick brown fox jumps over the lazy dog")
	queue_text("The quick brown Englishera latina jumps over the lazy golden retriever arf arf dog")

func _process(delta: float) -> void:
	match current_state:
		State.READY:
			if !text_queue.is_empty():
				display_text()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				message.visible_ratio = 1.0
				if current_tween:
					current_tween.kill()
					current_tween = null
				end_symbol.text = "v"
				change_state(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				message.visible_ratio = 0.04
				change_state(State.READY)
				hide_textbox()
				
	#print("visible ratio:", message.visible_ratio) #added print statement.

func queue_text(next_text):
	text_queue.push_back(next_text)

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	message.text = ""
	textbox_container.hide()

func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()

func display_text():
	var next_text = text_queue.pop_front()
	message.text = next_text
	show_textbox()
	change_state(State.READING)

	print("Text length:", len(next_text))
	print("Tween duration:", len(next_text) * CHAR_READ_RATE)

	current_tween = create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	current_tween.tween_property(message, "visible_ratio", 1.0, len(next_text) * CHAR_READ_RATE)

	print("visible ratio:", message.visible_ratio)
	print("current tween:", current_tween) # added print statement.

	current_tween.finished.connect(_on_tween_finished)

func _on_tween_finished():
	end_symbol.text = "v"
	change_state(State.FINISHED)
	current_tween = null


func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to: State.READY")
		State.READING:
			print("Changing state to: State.READING")
		State.FINISHED:
			print("Changing state to: State.FINISHED")
