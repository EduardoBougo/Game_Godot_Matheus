extends Node2D






func _on_entrada_taverna_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://scenes/main_02.tscn")
