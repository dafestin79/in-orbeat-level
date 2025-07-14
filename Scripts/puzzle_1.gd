extends Node2D


func _on_instrument_node_instrument_switched(instrument_name: String) -> void:
	if instrument_name == "piano":
		visible = true
	if instrument_name == "violin":
		visible = false
