extends CharacterBody2D

const SPEED = 35.0  # ajuste conforme necessário

@onready var texture := $texture as Sprite2D
@onready var anim := $anim as AnimationPlayer
@onready var death_sound: AudioStreamPlayer = $death_sound

var direction := -1
var is_dead := false
var turn_cooldown := 0.1
var turn_timer := 0.0

func _ready() -> void:
	# Direção inicial aleatória
	if randf() > 0.5:
		direction = 1
	else:
		direction = -1

func _physics_process(delta: float) -> void:
	if is_dead:
		return

	# Atualiza cooldown
	if turn_timer > 0.0:
		turn_timer -= delta

	# Aplica gravidade se não estiver no chão
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Define velocidade horizontal
	velocity.x = direction * SPEED

	# Move o personagem e obtém colisões
	move_and_slide()

	# Verifica colisões com paredes
	for i in range(get_slide_collision_count()):
		var col = get_slide_collision(i)
		if col:
			var normal = col.get_normal()  # pega a normal da colisão
			if normal.x != 0 and turn_timer <= 0.0:
				# zera a velocidade horizontal para não continuar empurrando
				velocity.x = 0
				# inverte a direção
				direction *= -1
				# atualiza o flip da sprite
				texture.flip_h = (direction == 1)
				# reinicia cooldown
				turn_timer = turn_cooldown

# Função de morte
func die() -> void:
	if is_dead:
		return
		
	is_dead = true
	death_sound.play()
	anim.play("hurt")
	
	await death_sound.finished
	
	queue_free()
