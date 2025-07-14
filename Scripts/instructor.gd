extends Area2D

class_name Sparkle

@onready var animated_sprite = $AnimatedSprite2D
@onready var audio_player = $AudioStreamPlayer

@export var speech_sound: AudioStream
@export var lines: Array[String]

var player_near: bool = false

func _ready():
	animated_sprite.play("default")

func _on_body_entered(body: Node2D) -> void:
	print("player entered")
	if body is Player && !player_near:
		DialogManager.start_dialog(global_position, lines, speech_sound)
		player_near = true

func _on_body_exited(body: Node2D) -> void:
	if body is Player && player_near:
		DialogManager.terminate_dialog()
		player_near = false

func _physics_process(_delta: float) -> void:
	if player_near and Input.is_action_just_pressed("speak"):
		DialogManager.continue_dialog()
		audio_player.play()
		
