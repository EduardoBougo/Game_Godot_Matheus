extends Area2D


var pode_coletar: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(0.2).timeout
	pode_coletar = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if pode_coletar and body.is_in_group("player"):
		Global.arma = true
		Global.arma_is_coleted = true
		queue_free()
