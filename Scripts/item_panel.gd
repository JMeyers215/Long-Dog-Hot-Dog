extends Panel
class_name store_item

var store_items

var bought : bool = false
var equipped : bool = false

@export var item : Texture
@export var cost : int
@export var equipped_id : int
@export var item_name : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if equipped_id == Global.item_1_id:
		bought = Global.item_1_bought
	if equipped_id == Global.item_2_id:
		bought = Global.item_2_bought
	if equipped_id == Global.item_3_id:
		bought = Global.item_3_bought
	$PlaceholderItemArt.texture = item
	$Cost.text = "Cost: " + str(cost)
	$Name.text = item_name	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if bought == true:
		$ItemButton.visible = false
		$Cost.visible = false
		$EquipButton.visible = true
	if equipped_id == Global.equipped:
		$EquipButton.text = "Unequip"
		equipped = true
	else:
		$EquipButton.text = "Equip"

func _on_item_button_pressed() -> void:
	Global.buy_item(equipped_id, cost)
	if equipped_id == Global.item_1_id:
		bought = Global.item_1_bought
	elif equipped_id == Global.item_2_id:
		bought = Global.item_2_bought
	elif equipped_id == Global.item_3_id:
		bought = Global.item_3_bought 
	else:
		bought = false
	Global.save_game()

func _on_equip_button_pressed() -> void:
	if equipped_id == Global.equipped:
		Global.equipped = -1
	else:
		Global.equipped = equipped_id

