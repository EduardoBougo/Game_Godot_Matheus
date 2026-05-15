extends CharacterBody2D


func _physics_process(delta: float) -> void:

	move_and_slide()


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


# --- Exports --- 
@export var move_speed: float = 200.0
@export var health : int = 1

# --- Variaveis de movimento --- 
var direction : Vector2 = Vector2.ZERO
var player = null

# --- Variaveis de Knockback ---
var knockback_velocity : Vector2 = Vector2.ZERO
var knockback_decay : float = 600.0
var knockback_force : float = 150.0


# --- Função Padrão do Objeto (Inicio) --- 
func _ready() -> void:
	player = Global.player

# --- Função Padrão do Objeto (Toda a execução) --- 
func _physics_process(delta: float) -> void:
	direction = global_position.direction_to(player.global_position)
	velocity = direction * move_speed
	move_and_slide()

# --- Função para Receber Dano--- 
func take_damage(amount: int, source_position: Vector2):
	# [Vida - Dano Recebido]
	health -= amount
	
	animated_sprite_2d.play("hit")
	
	if health <= 0:
		animated_sprite_2d.play("dead")
		await get_tree().create_timer(1.5).timeout
		queue_free()
