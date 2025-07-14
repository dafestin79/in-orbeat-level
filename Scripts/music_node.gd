extends Node2D

class_name MusicNode
###################################################
## should make this a State?
###################################################

var animation_playing: bool = false
signal note_played(note_name: String)


func _draw() -> void:
	if animation_playing:
		$Area2D/CollisionShape2D.disabled = false
		draw_circle(Vector2(0,0), 50, $Area2D/CollisionShape2D.debug_color)
	else:
		$Area2D/CollisionShape2D.disabled = true

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("play_note") and !animation_playing:
		queue_redraw()
		$Sprite2D.show()
		$Timer.start()
		
		resolve_music_key()
		animation_playing = true

func _on_timer_timeout() -> void:
	$Sprite2D.hide()
	queue_redraw()
	animation_playing = false
	
func resolve_music_key () -> void:
	#var animation_finished: bool = true
	#
	#if !animation_finished:
		#$MusicNote.position = Vector2(0, 0)
	if Input.is_key_pressed(KEY_U):
		note_played.emit("1")
		
	elif Input.is_key_pressed(KEY_I):
		note_played.emit("3")
		
	elif Input.is_key_pressed(KEY_O):
		note_played.emit("5")

		#$MusicNote.visible = true
		#$MusicNote.position = Vector2(0, 0)
		## $MusicNote.Colo = Color8(0,255,255)
		#var tween: Tween = get_tree().create_tween()
		#tween.tween_property(
			#$MusicNote, "position", 
			#$MusicNote.position + Vector2(0, -30), 
			#0.3
		#)
		#await tween.finished
		#tween.stop()
