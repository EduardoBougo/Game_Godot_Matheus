extends CharacterBody2D
class_name Player

# --- Variaveis de movimento --- 
var move_speed := 600.0
var move_direction := Vector2.ZERO



func _physics_process(delta: float) -> void:
	# Teclas de atalho
	move_direction = Input.get_vector("Esquerda", "Direita", "Cima", "Baixo")
	velocity = move_direction * move_speed
	move_and_slide()
