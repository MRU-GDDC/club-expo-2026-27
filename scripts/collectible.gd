extends Area2D

signal collected

var is_collected: bool = false


func _on_body_entered(body: Node2D) -> void:
	if is_collected:
		return
	if not Globals.is_player(body):
		return
	is_collected = true
	hide()
	set_deferred("monitoring", false)
	collected.emit()


func reset() -> void:
	is_collected = false
	show()
	set_deferred("monitoring", true)
