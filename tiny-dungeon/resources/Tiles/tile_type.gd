class_name TileType
extends Resource

enum CollisionResponseType {
	OVERLAP,
	BLOCK,
}

@export var collision_response_type := CollisionResponseType.OVERLAP

func _on_blocked() -> void:
	pass
	
	
func _on_overlap() -> void:
	pass
	
	
func _on_interact() -> void:
	pass

func is_walkable() -> bool:
	return collision_response_type == CollisionResponseType.OVERLAP
