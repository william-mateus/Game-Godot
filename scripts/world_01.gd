extends Node2D

# Enum para os tipos de transição
enum TransitionType { PIXELS, SPOT_PLAYER, SPOT_CENTRO, CORTE_VERTICAL, CORTE_HORIZONTAL }

# Variável exportada para selecionar o tipo de transição no editor
@export var transition_type: TransitionType = TransitionType.PIXELS

# Variável exportada para duração da animação (com range no editor)
@export_range(0.1, 10.0, 0.1) var duration: float = 1.0

# Onready nodes
@onready var player := $player as CharacterBody2D
@onready var camera := $camera as Camera2D
@onready var transition := $Transition/Fill
@onready var animation := $Transition/Fill/Animation

func _ready() -> void:
	player.follow_camera(camera)

	var shader_mat := transition.material as ShaderMaterial
	if shader_mat:
		shader_mat.set_shader_parameter("type", int(transition_type))
		shader_mat.set_shader_parameter("progress", 1.0)  # começa escuro

	if animation.has_animation(animation.current_animation):
		animation.speed_scale = animation.current_animation_length / duration
	else:
		animation.speed_scale = 1.0

	# Fade-out: revela a cena
	var fade_out = get_tree().create_tween()
	fade_out.tween_property(
		shader_mat,
		"shader_parameter/progress",
		0.0,
		duration
	)
