class_name Player
extends CharacterBody2D

# Constants
const TILE_SIZE := 16
const MOVE_SPEED := 0.1

# Sub-nodes
@onready var sprite := $Sprite2D
@onready var sensor_suite := $SensorSuite as SensorSuite

# Local State
var moving := false


func _physics_process(delta: float) -> void:
	position_move(delta)

# Tile-Based Movement
func position_move(_delta: float) -> void:
	# Query Input
	
	var target_tile : TileType = null
	var move_direction := Vector2.ZERO;
	if Input.is_action_just_pressed("left"):
		target_tile = sensor_suite.get_left_tile()
		if not target_tile or target_tile.is_walkable():
			sprite.flip_h = true
			move_direction.x = -TILE_SIZE;
			
	elif Input.is_action_just_pressed("right"):
		target_tile = sensor_suite.get_right_tile()
		if not target_tile or target_tile.is_walkable():
			sprite.flip_h = false
			move_direction.x = TILE_SIZE;
			
	elif Input.is_action_just_pressed("up"):
		target_tile = sensor_suite.get_up_tile()
		if not target_tile or target_tile.is_walkable():
			move_direction.y = -TILE_SIZE;
			
	elif Input.is_action_just_pressed("down"):
		target_tile = sensor_suite.get_down_tile()
		if not target_tile or target_tile.is_walkable():
			move_direction.y = TILE_SIZE;

	# move_direction *= _delta
		
	
	if move_direction != Vector2.ZERO:
		if not moving:
			moving = true
			var position_tween := create_tween()
			position_tween.tween_property(self, "position", position + move_direction, 0)
			position_tween.tween_callback(
				func(): 
					moving = false
					# sensor_suite.print_state()		
			)
			
	if target_tile:
		if target_tile.is_walkable():
			target_tile._on_overlap()
		else:
			target_tile._on_blocked()	
