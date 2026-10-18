extends BasePlayer


func _ready() -> void:
	Globals.player2 = self


func _exit_tree() -> void:
	if Globals.player2 == self:
		Globals.player2 = null


func get_left_action() -> StringName:
	return &"player2_left"


func get_right_action() -> StringName:
	return &"player2_right"


func get_jump_action() -> StringName:
	return &"player2_up"


func get_other_player() -> CharacterBody2D:
	return Globals.player1
