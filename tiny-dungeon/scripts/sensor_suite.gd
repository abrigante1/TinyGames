class_name SensorSuite
extends Node2D

@onready var up: RayCast2D = $Up
@onready var down: RayCast2D = $Down
@onready var left: RayCast2D = $Left
@onready var right: RayCast2D = $Right

func _ready() -> void:
	var player := get_parent()
	up.add_exception(player)
	down.add_exception(player)
	left.add_exception(player)
	right.add_exception(player)


func _get_colliding_tile(dir: RayCast2D) -> TileType:
	if dir.is_colliding():
		var collider := dir.get_collider()
		if collider is TileMapLayer:
			var tile_map_layer := collider as TileMapLayer
			var hit_pos := dir.get_collision_point()
			var local_pos := tile_map_layer.to_local(hit_pos)
			var tile_map_coords := tile_map_layer.local_to_map(local_pos)
			var cell_tile_data := tile_map_layer.get_cell_tile_data(tile_map_coords)
			var custom_data = cell_tile_data.get_custom_data_by_layer_id(0)
			if custom_data is TileType:
				return (custom_data) as TileType
				
	return null
	
func force_raycast_update() -> void:
	up.force_raycast_update()
	down.force_raycast_update()
	left.force_raycast_update()
	right.force_raycast_update()

# Directional Queries
func get_left_tile() -> TileType:
	return _get_colliding_tile(left)


func get_right_tile() -> TileType:
	return _get_colliding_tile(right)
	

func get_up_tile() -> TileType:
	return _get_colliding_tile(up)


func get_down_tile() -> TileType:
	return _get_colliding_tile(down)

# Debug Utilities
func print_tile_data(tile: TileType):
	if tile:
		print("\tName: %s" % tile.resource_name)
		print("\tCollision Response: %s" % tile.collision_response_type)
	else:
		print("\tName: Air")

func print_state() -> void:
	force_raycast_update()
	
	print("\n-------------")
	print("Left:")
	print_tile_data(get_left_tile())
	
	print("Right:")
	print_tile_data(get_right_tile())
	
	print("Up:")
	print_tile_data(get_up_tile())
	
	print("Down:")
	print_tile_data(get_down_tile())
	print("-------------\n")
	
	 
