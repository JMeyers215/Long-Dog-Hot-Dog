extends Node

@onready var global_vars = get_node("/root/Global")

#score variables
var total_count : int = 0
var high_score : int = 0

#options variables
var dog_or_cat : bool 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
