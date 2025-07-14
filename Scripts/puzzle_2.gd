extends Node2D

@export var switch_order: Array[String]
var current_order: Array[bool]

func _process(delta: float) -> void:
	if current_order.is_empty():
		for child in get_children():
			if child is Switch:
				child.switch_reset()
				
	if current_order.size() == 5:
		$Gate.open_door()

func _on_switch_1_switch_on(name: String) -> void:
	if current_order.size() == 0:
		current_order.append(true)


func _on_switch_2_switch_on(name: String) -> void:
	if current_order.size() == 1:
		current_order.append(true)
	else:
		current_order = []

func _on_switch_3_switch_on(name: String) -> void:
	if current_order.size() == 2:
		current_order.append(true)
	else:
		current_order = []

func _on_switch_4_switch_on(name: String) -> void:
	if current_order.size() == 3:
		current_order.append(true)
	else:
		current_order = []

func _on_switch_5_switch_on(name: String) -> void:
	if current_order.size() == 4:
		current_order.append(true)
	else:
		current_order = []
