class_name Player
extends CharacterBody2D

# Constants
const TILE_SIZE := 16
const MOVE_SPEED := 0.1

# Sub-nodes
@onready var sprite := $Sprite2D

# Local State
var moving := false


func _physics_process(delta: float) -> void:
	position_move(delta)

# Tile-Based Movement
func position_move(_delta: float) -> void:
	# Query Input
	var move_direction := Vector2.ZERO;
	if Input.is_action_just_pressed("left"):
		sprite.flip_h = true
		move_direction.x = -TILE_SIZE;
	elif Input.is_action_just_pressed("right"):
		sprite.flip_h = false
		move_direction.x = TILE_SIZE;
	elif Input.is_action_just_pressed("up"):
		move_direction.y = -TILE_SIZE;
	elif Input.is_action_just_pressed("down"):
		move_direction.y = TILE_SIZE;

	# move_direction *= _delta
	if move_direction != Vector2.ZERO:
		var collided := test_move(transform, move_direction)
		if collided:
			return
		elif not moving:
			moving = true
			var position_tween := create_tween()
			position_tween.tween_property(self, "position", position + move_direction, MOVE_SPEED)
			position_tween.tween_callback(func(): moving = false)
