extends CharacterBody2D
class_name Player

# --- Variaveis de movimento --- 
var move_speed := 300.0
var move_direction := Vector2.ZERO
@onready var animatedSprite := $AnimatedSprite2D;



func _physics_process(delta: float) -> void:
	# Teclas de atalho
	move_direction = Input.get_vector("Esquerda", "Direita", "Cima", "Baixo")
	velocity = move_direction * move_speed
	
	verifyMovement();
	
	move_and_slide()
	
func verifyMovement():
	if move_direction:
		if move_direction.x:
			animatedSprite.play("run");
			if move_direction.x > 0:
				animatedSprite.flip_h = true;
			else:
				animatedSprite.flip_h = false;
		elif move_direction.y:
			if move_direction.y > 0:
				animatedSprite.play("down");
			else:
				animatedSprite.play("up");
	else:
		animatedSprite.play("idle");
