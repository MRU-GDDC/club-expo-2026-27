extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if Globals.is_player(body) and body.has_method("die"):
		body.call("die")
