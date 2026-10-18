extends Area2D

signal completed

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var win_timer: Timer = $WinTimer

var is_open: bool = false
var players_inside: Array[Node2D] = []


func _ready() -> void:
	set_open(false)


func set_open(open: bool) -> void:
	is_open = open
	if is_open:
		sprite.animation = &"open"
		update_timer()
	else:
		sprite.animation = &"closed"
		win_timer.stop()


func _on_body_entered(body: Node2D) -> void:
	if not Globals.is_player(body):
		return
	if not players_inside.has(body):
		players_inside.append(body)
	update_timer()


func _on_body_exited(body: Node2D) -> void:
	if not Globals.is_player(body):
		return
	players_inside.erase(body)
	update_timer()


func update_timer() -> void:
	if is_open and all_players_inside():
		if win_timer.is_stopped():
			win_timer.start()
	else:
		win_timer.stop()


func all_players_inside() -> bool:
	var active_players: Array[CharacterBody2D] = Globals.get_players()
	if active_players.is_empty():
		return false
	for player: CharacterBody2D in active_players:
		if not players_inside.has(player):
			return false
	return true


func _on_win_timer_timeout() -> void:
	if is_open and all_players_inside():
		completed.emit()


func reset() -> void:
	win_timer.stop()
	players_inside.clear()
	set_open(false)
