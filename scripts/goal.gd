extends Area2D

@export var next_level: String = ""

@onready var transition: CanvasLayer = get_tree().current_scene.get_node("Transition")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player" and next_level != "":
		transition.call_deferred("change_scene", next_level)
	else:
		print("sem cena configurada")
