extends Node2D

signal instrument_switched(instrument_name: String)

func _ready() -> void:
	instrument_switched.emit("piano")

func _process(_delta: float) -> void:
	resolve_instrument()
		
func resolve_instrument() -> void:
	if Input.is_key_pressed(KEY_1):
		instrument_switched.emit("piano")
		print("emitted piano")
		
	if Input.is_key_pressed(KEY_2):
		instrument_switched.emit("violin")
		print("emitted violin")

func _on_guitar_pressed() -> void:
	$Control/Guitar.hide()
	$Control/Piano.show()

func _on_piano_pressed() -> void:
	$Control/Guitar.show()
	$Control/Piano.hide()
