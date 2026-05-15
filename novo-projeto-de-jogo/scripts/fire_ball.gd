extends Area2D

var speed := 500;
var direction := Vector2.ZERO;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += direction * speed * delta;


func _on_body_entered(body: Node2D) -> void:
	if (body.is_in_group("enemies")):
		body.take_damage(1, global_position)
		queue_free();
