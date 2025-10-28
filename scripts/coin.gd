extends Area2D

@onready var coin_sound: AudioStreamPlayer = $coin_sound


func _on_body_entered(body: Node2D) -> void:
	$anim.play("collect")
	coin_sound.play()
	


func _on_anim_animation_finished() -> void:
	queue_free()
