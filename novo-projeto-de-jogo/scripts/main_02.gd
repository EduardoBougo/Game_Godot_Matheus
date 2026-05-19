extends Node

@export var item_cena: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.arma_is_coleted == false:
		var novo_item = item_cena.instantiate()
		novo_item.global_position = Vector2(0, -70)
		add_child(novo_item)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
