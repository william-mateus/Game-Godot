extends Area2D

@onready var water: Area2D = $"."
@onready var anim: AnimatedSprite2D = $anim
@onready var collision: CollisionShape2D = $collision


var is_dead := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
