extends BasePlayer


func _ready() -> void:
	Globals.player1 = self


func _exit_tree() -> void:
	if Globals.player1 == self:
		Globals.player1 = null


func get_left_action() -> StringName:
	return &"player1_left"


func get_right_action() -> StringName:
	return &"player1_right"


func get_jump_action() -> StringName:
	return &"player1_up"


func get_other_player() -> CharacterBody2D:
	return Globals.player2
