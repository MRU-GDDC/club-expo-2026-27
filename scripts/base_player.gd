extends CharacterBody2D
class_name BasePlayer

signal died

const SPEED: float = 250.0
const JUMP_VELOCITY: float = -300.0
const MAX_PLAYER_DISTANCE: float = 464.0

@export var min_x: float = 8.0
@export var max_x: float = 472.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func get_left_action() -> StringName:
	return &""


func get_right_action() -> StringName:
	return &""


func get_jump_action() -> StringName:
	return &""


func get_other_player() -> CharacterBody2D:
	return null


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed(get_jump_action()) and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction: float = Input.get_axis(get_left_action(), get_right_action())
	if direction != 0.0:
		sprite.play()
		velocity.x = direction * SPEED
		sprite.flip_h = direction < 0.0
	else:
		sprite.stop()
		sprite.frame = 0
		velocity.x = move_toward(velocity.x, 0.0, SPEED)
	apply_player_leash(delta)
	move_and_slide()
	position.x = clamp(position.x, min_x, max_x)


func apply_player_leash(delta: float) -> void:
	var other_player: CharacterBody2D = get_other_player()
	if not is_instance_valid(other_player):
		return
	var min_allowed_x: float = (other_player.position.x - MAX_PLAYER_DISTANCE)
	var max_allowed_x: float = (other_player.position.x + MAX_PLAYER_DISTANCE)
	var intended_x: float = position.x + velocity.x * delta
	var allowed_x: float = clamp(intended_x, min_allowed_x, max_allowed_x)
	velocity.x = (allowed_x - position.x) / delta


func die() -> void:
	died.emit()
