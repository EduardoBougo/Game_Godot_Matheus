extends Area2D

var speed := 500;
var direction := Vector2.ZERO;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += direction * speed * delta;
