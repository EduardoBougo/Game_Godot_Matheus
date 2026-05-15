extends Area2D

@export var target_scene: String  # Caminho da cena (ex: res://fase_2.tscn)
@export var target_door: String   # Nome da porta de destino (ex: "PortaEntrada")

func _on_body_entered(body):
	if body.name == "Player":
		Global.target_door_name = target_door
		get_tree().change_scene_to_file(target_scene)
