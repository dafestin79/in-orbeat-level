extends Panel

@export var move_distance: float 
@export var move_speed: float = 1.0 # Units per second
@export var start_position: Vector2 = Vector2(0, 0)
@export var move_direction: Vector2 = Vector2(0, -1) # Up by default
@export var pixel_step: float = 1.6 # Size of each movement step
@export var time_offset: float

var time_elapsed: float = 0.0
var initial_position: Vector2

func _ready():
	initial_position = position
	start_position = position

func _process(delta):
	time_elapsed += delta
	var offset = move_distance * sin(time_elapsed * move_speed + time_offset) / 2.0
	var stepped_offset = round(offset / pixel_step) * pixel_step
	position = start_position + move_direction * stepped_offset
