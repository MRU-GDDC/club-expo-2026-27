extends CanvasLayer
class_name UI

@onready var counter: Label = $Counter
@onready var win_message: Label = $WinMessage


func _ready() -> void:
	hide_win_message()


func update_counter(current: int, maximum: int) -> void:
	counter.text = str(current) + "/" + str(maximum)


func show_win_message() -> void:
	win_message.show()


func hide_win_message() -> void:
	win_message.hide()


func _on_reset_pressed() -> void:
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
