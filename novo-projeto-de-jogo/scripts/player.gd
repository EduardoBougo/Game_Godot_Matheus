extends CharacterBody2D

# --- Variaveis de movimento --- 
var move_speed := 100.0
var mouse_position;
var move_direction := Vector2.ZERO
var last_direction = Vector2.DOWN;
var canShoot = true;
var timeToShoot = 1;
@export var fireBall : PackedScene;
@onready var animatedSprite := $AnimatedSprite2D;
@onready var cooldownTimer := $Cooldown;

func _ready() -> void:
	Global.player = self


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
