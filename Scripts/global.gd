extends Node

@onready var global_vars = get_node("/root/Global")

#score variables
var total_count : int = 0
var high_score : int = 0

#options variables
var is_cat_or_dog : String = "Dog"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Persist", true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit()
