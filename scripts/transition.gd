extends CanvasLayer

@onready var color_rect: ColorRect = $Fill

func _ready():
	color_rect.material.set_shader_parameter("progress", 0.0)

func change_scene(path: String):
	# Fade-in
	var fade_in = get_tree().create_tween()
	fade_in.tween_property(
		color_rect.material,
		"shader_parameter/progress",
		1.0,
		0.5
	)
	await fade_in.finished

	# Troca de cena
	get_tree().change_scene_to_file(path)
