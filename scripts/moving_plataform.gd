extends Node2D

const WAIT_DURATION := 1.0
#importa a sprite para o script
@onready var plataform := $plataform as AnimatableBody2D
@export var move_speed := 3.0
@export var distance := 192
@export var move_horizontal := true

var follow := Vector2.ZERO
# o centro é 16 ja que a plataforma é 16+16
var plataform_center := 16  
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#inicia a função aqui 
	move_plataform()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	plataform.position = plataform.position.lerp(follow, 0.5)
	
	
func move_plataform():
	# vai para a esquerda, caso contrario ele sobe
	var move_direction = Vector2.RIGHT * distance if move_horizontal else Vector2.UP * distance
	# o float forca a conversão dos dados para fica uniforme 
	var duration = move_direction.length() / float(move_speed * plataform_center)
	
	var plataform_tween = create_tween().set_loops().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	plataform_tween.tween_property(self, "follow", move_direction, duration).set_delay(WAIT_DURATION)
	plataform_tween.tween_property(self, "follow", Vector2.ZERO, duration).set_delay(duration + WAIT_DURATION * 2)
