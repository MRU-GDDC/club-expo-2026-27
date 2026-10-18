extends Camera2D

@export var player1: CharacterBody2D
@export var player2: CharacterBody2D


func _physics_process(_delta: float) -> void:
	if not is_instance_valid(player1):
		return
	if not is_instance_valid(player2):
		return

	var middle_x: float = (player1.global_position.x + player2.global_position.x) / 2.0

	var viewport_width: float = get_viewport_rect().size.x
	var half_viewport: float = viewport_width / (2.0 * zoom.x)

	var camera_x: float = clamp(middle_x, limit_left + half_viewport, limit_right - half_viewport)

	var camera_y: float = (float(limit_top) + float(limit_bottom)) / 2.0

	global_position = Vector2(round(camera_x), round(camera_y))
