extends CharacterBody2D

#Variaveis 
var move_speed := 100.0
var mouse_position;
var move_direction := Vector2.ZERO
var last_direction = Vector2.DOWN;
var canShoot = true;
var timeToShoot = 1;

var vida_maxima := 100
var vida_atual: int = vida_maxima

@export var fireBall : PackedScene;
@onready var animatedSprite := $AnimatedSprite2D;
@onready var cooldownTimer := $Cooldown;

func _ready() -> void:
	Global.player = self
	
	if Global.target_door_name != "":
		# Procura na cena atual por um nó com o nome que salvamos no Global
		var door = get_tree().current_scene.find_child(Global.target_door_name, true, false)
		if door:
			# Move o player para a posição da porta
			# Dica: adicione um pequeno offset para ele não nascer EXATAMENTE colidindo
			global_position = door.global_position + Vector2(0, 20)


func _process(delta: float) -> void:
	mouse_position = get_global_mouse_position();

func _physics_process(delta: float) -> void:
	# Teclas de atalho
	move_direction = Input.get_vector("Esquerda", "Direita", "Cima", "Baixo")
	velocity = move_direction * move_speed
	
	last_direction = move_direction.normalized();
	
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
		
func _input(event: InputEvent) -> void:
	if Global.arma:
		if Input.is_action_just_pressed("Atacar"):
			if canShoot:
				spawnFireBall();
				canShoot = false;
				cooldownTimer.start(timeToShoot);

func spawnFireBall():
	var instance := fireBall.instantiate();
	instance.position = global_position;
	
	var mouse_direction = (mouse_position - instance.position).normalized();
	
	instance.direction = mouse_direction;
	
	get_parent().add_child(instance);


func _on_cooldown_timeout() -> void:
	canShoot = true;
	cooldownTimer.stop();


func tomar_dano(quantidade: int) -> void:
	vida_atual -= quantidade
	print("Ai! Vida atual: ", vida_atual)
	
	if vida_atual <= 0:
		print("Game Over!")
		#tela de morte
		return
