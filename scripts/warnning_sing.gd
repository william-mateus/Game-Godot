extends Node2D

@onready var texture: Sprite2D = $texture
@onready var area_sing: Area2D = $area_sing
@onready var menssage_sound: AudioStreamPlayer = $menssage_sound

const lines : Array[String] = [
	"Ola, Viajante!",
	"Vi que voce caiu do céu",
	"Bom....",
	"isso é meio comum...",
	"O melhor agora é seguir em frente!",
	"mas cuidado...",
	"...",
	"não gostaria de te ver...",
	"DIFERENTE"
]

func _unhandled_input(event):
	#alguem bateu nessa porcaria 
	if area_sing.get_overlapping_bodies().size() > 0:
		texture.show()
		if event.is_action_pressed("interact") && !DialogMenager.is_menssage_active:
			texture.hide()
			menssage_sound.stop()
			menssage_sound.play(0.0)
			DialogMenager.start_menssage(global_position, lines)
	else:
		texture.hide()
		if DialogMenager.dialog_box != null:
			DialogMenager.dialog_box.queue_free()
			DialogMenager.is_menssage_active = false
	
