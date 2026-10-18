extends Node2D


func _on_two_player_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/two_player_world.tscn")


func _on_map_maker_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/map_maker_world.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
