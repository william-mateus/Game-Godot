extends Area2D

@onready var anim: AnimatedSprite2D = $anim
@onready var collision: CollisionShape2D = $collision

var is_dead := false

func _ready() -> void:
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player") and not is_dead:
		is_dead = true
		body.morrer()
