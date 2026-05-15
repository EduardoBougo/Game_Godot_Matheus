extends Area2D

var speed := 500;
var direction := Vector2.ZERO;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += direction * speed * delta;


func _on_body_entered(body: Node2D) -> void:
	if(!body.is_in_group("player")): # Mudar a verificação quando tiver inimigos
		queue_free();
