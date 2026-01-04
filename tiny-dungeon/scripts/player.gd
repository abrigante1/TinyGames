class_name Player
extends CharacterBody2D

# Test

# Constants
const TILE_SIZE := 16
const MOVE_SPEED := 0.1

# Sub-nodes
@onready var _sprite := $Sprite2D
@onready var _aim_reticle := $AimReticle as AimReticle

# Local State
var moving := false

func _process(_delta: float) -> void:
	check_interact()

func _physics_process(delta: float) -> void:
	position_move(delta)
	

# Tile-Based Movement
func position_move(_delta: float) -> void:
	# Query Input
	var move_direction := Vector2.ZERO;
	if Input.is_action_just_pressed("left"):
		_sprite.flip_h = true
		move_direction.x = -TILE_SIZE;
	elif Input.is_action_just_pressed("right"):
		_sprite.flip_h = false
		move_direction.x = TILE_SIZE;
	elif Input.is_action_just_pressed("up"):
		move_direction.y = -TILE_SIZE;
	elif Input.is_action_just_pressed("down"):
		move_direction.y = TILE_SIZE;
	
	# move_direction *= _delta
	if move_direction != Vector2.ZERO:

		# Update the Aim Reticle 
		var aim_direction := _aim_reticle.get_aim_direction()
		if aim_direction != move_direction:
			_aim_reticle.set_aim_direction(move_direction)
		else:
			# Collision Check		
			var collided := test_move(transform, move_direction)
			if collided:
				return
			elif not moving:
				moving = true
				
				var return_tween := create_tween()
				return_tween.set_parallel(true)
				return_tween.tween_property(_aim_reticle, "position", move_direction, MOVE_SPEED)
				return_tween.tween_property(self, "global_position", global_position + move_direction, MOVE_SPEED)
				
				var position_tween := create_tween()
				position_tween.tween_property(_aim_reticle, "position", move_direction * 2, MOVE_SPEED / 2)
				position_tween.tween_subtween(return_tween)
				position_tween.tween_callback(func(): moving = false )
			
func check_interact() -> void:
	if Input.is_action_just_pressed("interact"):
		_aim_reticle.begin_interact()
	elif Input.is_action_just_released("interact"):
		_aim_reticle.end_interact()
