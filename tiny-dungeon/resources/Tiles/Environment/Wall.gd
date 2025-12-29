class_name Wall
extends TileType

func _init() -> void:
	resource_name = "Wall"

func _on_blocked():
	print("This is a Wall.")

func _on_overlap():
	pass

func _on_interact():
	pass
	
