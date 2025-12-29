class_name Danger
extends TileType

@export var damage : int = 0

func _init():
	resource_name = "Danger"

func _on_blocked():
	pass
	
func _on_overlap():
	print("You've taken %d damage!" % damage)
	pass
	
func _on_interact():
	pass
