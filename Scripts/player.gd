extends CharacterBody2D

class_name Player

@export var allowed_instruments: Array[String]
@export var allowed_notes: Array[String]
@export var level: int
@export var SPEED = 200.0
@export var JUMP_VELOCITY = -400.0
@export var animation_time: float = 0.80
@export var jump_buffer_time = 0.10
@export var coyote_time = 0.15

var num_notes_played: int = 0
var num_error_played: int = 0
var player_accuracy: float = Global.player_accuracy

var isSinging = false
var footstep_frames : Array = [4,9]

@onready var music_resolver = get_node("MusicResolver")
@onready var animated_sprite_2d = get_node("AnimatedSprite2D")
@onready var animated_notes = get_node("AnimatedNote")
@onready var jump = $Jump
@onready var walk = $Walk
@onready var fall = $Fall
@onready var jump_buffer_timer = 0
@onready var coyote_timer = 0

# Should probably move the movement itself to another function
# So add-ons to the player is functional
func _physics_process(delta: float) -> void:
	
	# Gravity.
	if not is_on_floor():
		if velocity.y < 0:
			velocity += get_gravity() * delta
		else:
			velocity += get_gravity() * delta / 4.8
		coyote_timer -= delta
	else:
		coyote_timer = coyote_time

	# Jump State
	if Input.is_action_just_pressed("Jump"):
		fall.pitch_scale = randf_range(0.8, 1.2)
		if is_on_floor() or coyote_timer > 0:
			velocity.y = JUMP_VELOCITY
			jump.play()
			fall.play()
			jump_buffer_timer = jump_buffer_time
			coyote_timer = 0
		else:
			await get_tree().create_timer(jump_buffer_timer).timeout
			if is_on_floor():
				velocity.y = JUMP_VELOCITY
				jump.play()
				fall.play()
	
		
	if Input.is_action_just_pressed("scene_reset"):
		Global.reset_scene()

	# Running State
	var direction := Input.get_axis("Left", "Right")
	if direction:
		$AnimatedSprite2D.scale.x = abs($AnimatedSprite2D.scale.x)*direction
		if abs(velocity.y) < 0.25:
			$AnimatedSprite2D.play("Run")
		else:
			$AnimatedSprite2D.play("Jump")
		velocity.x = direction * SPEED
		
		if direction > 0:
			animated_notes.position = Vector2(13, -10)
		elif direction < 0:
			animated_notes.position = Vector2(-15,-10)
		
	# Idle State
	else:
		if abs(velocity.y) > 0.25:
			$AnimatedSprite2D.play("Jump")
		elif music_resolver.is_playing_sound():
			$AnimatedSprite2D.play("Sing")
		else:
			$AnimatedSprite2D.play("Idle")
			$AnimatedNote.play("blank")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if Input.is_action_just_pressed("play_instrument"):
		$MusicResolver.resolve_instrument()
	if Input.is_action_just_pressed("play_note"):
		$MusicResolver.play_music()
		
		if num_notes_played > 0:
			player_accuracy = (1 - (float(num_error_played) / num_notes_played)) * 100
	
	move_and_slide()
	
func _on_animated_sprite_2d_frame_changed() -> void:
	if animated_sprite_2d.animation == "Idle": return
	if animated_sprite_2d.animation == "Jump": return
	if animated_sprite_2d.animation == "Sing": return
	if animated_sprite_2d.frame in footstep_frames:
		walk.pitch_scale = randf_range(0.8, 1.2)
		walk.play()
		
