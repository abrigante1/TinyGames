class_name RecoveryPotion
extends TileType

enum RecoveryType {
	HEALTH,
	MANA,
}

@export var recovery_type := RecoveryType.HEALTH
@export var heal_amount : int = 0

func _on_overlap() -> void:
	if recovery_type == RecoveryType.HEALTH:
		print("You healed %d health!" % heal_amount)
	else:
		print("You healed %d mana!" % heal_amount)
		
	# Ah fuck. This isn't an actual entity...
	
	pass
