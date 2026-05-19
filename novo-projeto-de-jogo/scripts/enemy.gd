extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var move_speed: float = 50.0
@export var health : int = 1

var direction : Vector2 = Vector2.ZERO
var player = null

var eliminado = false

var forca_do_dano: int = 20

func _ready() -> void:
	player = Global.player


func _physics_process(delta: float) -> void:
	if eliminado == false:
		direction = global_position.direction_to(player.global_position)
		velocity = direction * move_speed
		move_and_slide()
		

# --- Função para Receber Dano--- 
func take_damage(amount: int, source_position: Vector2):
	# [Vida - Dano Recebido]
	health -= amount
	
	animated_sprite_2d.play("hit")
	
	
	if health <= 0:
		eliminado = true
		animated_sprite_2d.play("dead")
		await get_tree().create_timer(1.5).timeout
		queue_free()


func _on_area_dano_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.has_method("tomar_dano"):
			body.tomar_dano(forca_do_dano)
