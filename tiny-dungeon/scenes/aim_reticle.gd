class_name AimReticle
extends Area2D

var _is_interacting: bool = false
var _selected_node: Node2D = null

@onready var collider: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer

func _ready() -> void:
	animation_player.speed_scale = 6
	animation_player.play("Idle")

func get_aim_direction() -> Vector2:
	return position
	
func set_aim_direction(direction: Vector2) -> void:
	position = direction

func begin_interact() -> void:
	if _is_interacting: 
		return
	
	animate_begin_interact()
	_is_interacting = true
	
	# TODO: Need to reduce this to only select "Interactable" objects
	var interaction_candidates := get_overlapping_bodies()
	if not interaction_candidates.is_empty():
		_selected_node = interaction_candidates.front()
	
func end_interact() -> void:
	if not _is_interacting:
		return
	animate_end_interact()
	
	_is_interacting = false
	_selected_node = null
	
func animate_begin_interact() -> void:
	animation_player.play("Interact")
	pass
	
func animate_end_interact() -> void:
	animation_player.play_backwards("Interact")
	animation_player.queue("Idle")
	
	pass
	
