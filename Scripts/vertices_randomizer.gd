extends Node2D

@export var num_buckets: int = 0
@export var bucket: Array[Lifeform]
@export var instruments_selection: Array[String] = ["piano"]
@export var notes_selection: Array[int] = [1,3,5]

@export var selection_rules: Array[Array]
var note_buckets: Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var temp: Dictionary
	
	for lifeform in bucket:
		temp[lifeform.name] = []
		
	for rule in selection_rules:
		var lifeform_note: String = generate_random_note()
		var check_duplicates: bool = true
		
		while check_duplicates:
			for number in rule:
				if lifeform_note in temp["Lifeform" + str(number)]:
					lifeform_note = generate_random_note()
					break
				else: 
					check_duplicates = false
		
		for number in rule:
			temp["Lifeform" + str(number)].append(lifeform_note)
		
	print(temp)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func generate_random_note () -> String:
	return (
		instruments_selection.pick_random() + "_" + 
		str(notes_selection.pick_random())
	)
