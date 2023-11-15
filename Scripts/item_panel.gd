extends Panel
class_name store_item

var store_items

var bought : bool = false
var equipped : bool = false

@export var item : Sprite2D
@export var cost : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var store_items = get_tree().get_nodes_in_group("StoreItems")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if bought == true:
		$ItemButton.visible = false
		$Cost.visible = false
		$EquipButton.visible = true

func _on_item_button_pressed() -> void:
	if Global.total_count >= cost:
		bought = true
		Global.total_count -= cost
		#Global.save_game()

func _on_equip_button_pressed() -> void:
	for node in store_items:
		if node == self :
			equipped = true
		else:
			node.equipped = false

