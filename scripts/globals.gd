extends Node

var player1: CharacterBody2D = null
var player2: CharacterBody2D = null


func is_player(body: Node) -> bool:
	return body == player1 or body == player2


func get_players() -> Array[CharacterBody2D]:
	var players: Array[CharacterBody2D] = []

	if is_instance_valid(player1):
		players.append(player1)

	if is_instance_valid(player2):
		players.append(player2)

	return players
