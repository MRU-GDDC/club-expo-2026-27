extends Node

@export var player1_spawn: Marker2D
@export var player2_spawn: Marker2D
@export var level_exit: Area2D
@export var ui: UI
var item_collected: int = 0
var max_item: int = 0


func _ready() -> void:
	await get_tree().process_frame
	refresh_collectibles()


func refresh_collectibles() -> void:
	var collectibles: Array[Node] = get_tree().get_nodes_in_group("collectible")
	var callback: Callable = Callable(self, "_on_collectible_collected")

	item_collected = 0
	max_item = collectibles.size()

	for collectible: Node in collectibles:
		if collectible.has_method("reset"):
			collectible.reset()
		if collectible.has_signal("collected"):
			if not collectible.is_connected("collected", callback):
				collectible.connect("collected", callback)

	update_counter()
	ui.win_message.hide()
	update_exit()


func _on_collectible_collected() -> void:
	item_collected = min(item_collected + 1, max_item)
	update_counter()
	update_exit()


func update_exit() -> void:
	if level_exit != null:
		level_exit.set_open(item_collected >= max_item)


func restart() -> void:
	_restart_player(Globals.player1, player1_spawn)
	_restart_player(Globals.player2, player2_spawn)
	item_collected = 0
	for collectible: Node in get_tree().get_nodes_in_group("collectible"):
		if collectible.has_method("reset"):
			collectible.call("reset")
	update_counter()
	if ui != null:
		ui.win_message.hide()
	if level_exit != null and level_exit.has_method("reset"):
		level_exit.reset()
	update_exit()


func _restart_player(player: CharacterBody2D, spawn: Marker2D) -> void:
	if not is_instance_valid(player):
		return
	if not is_instance_valid(spawn):
		return
	player.global_position = spawn.global_position
	player.velocity = Vector2.ZERO


func update_counter() -> void:
	ui.update_counter(item_collected, max_item)


func win_game() -> void:
	ui.win_message.show()
	await get_tree().create_timer(2.0).timeout
	restart()


func _on_bottom_boundary_body_entered(body: Node2D) -> void:
	if Globals.is_player(body):
		restart()


func _on_player_died() -> void:
	restart()


func _on_level_builder_level_changed() -> void:
	refresh_collectibles()


func _on_exit_completed() -> void:
	win_game()
