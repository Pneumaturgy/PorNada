extends CanvasLayer
class_name Inventory

signal collect_item

var player
var max_inventory_slot = 32
var index = {}

const INVENTORY_SLOT = preload("res://Scenes/Player/inventory_slot.tscn")

@onready var InventoryGrid = $"Control/InventoryGrid"

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent()
	player.collected.connect(add_to_inventory)
	set_up_inventory()

func set_up_inventory():
	for slot in player.current_inventory_slots:
		var new_slot = INVENTORY_SLOT.instantiate()
		InventoryGrid.add_child(new_slot)
		


func add_to_inventory(drop):
	var current_slot
	var item_stored = false
	var inventory_slot = index.get(drop.drop_resource.item_identifier)
	if inventory_slot == null:
		var slot_index = 0
		for slot in InventoryGrid.get_children():
			current_slot = slot
			if !item_stored and slot.current_item == null:
				slot.current_item = drop.drop_resource
				slot.quantity = drop.quantity
				index[drop.drop_resource.item_identifier] = slot_index
				inventory_slot = slot_index
				item_stored = true
				break
			slot_index += 1
	else:
		current_slot = InventoryGrid.get_children()[inventory_slot]
		current_slot.quantity += drop.quantity
		item_stored = true
	if item_stored:
		current_slot.update_slot()
		#print("drop: ", drop.drop_resource.item_identifier, " current quantity: ", InventoryGrid.get_children()[inventory_slot].quantity )
		drop.destroy()
	# for each inventory slot
	# if slot is empty:
	# if slots contains item key
	# sum quantities
	# else, is slot empty? find next empty slot
	# insert new key
	# if no new empty slots
	
	# send signal to destroy if added
	# else, don't send signal
	#print("adding: ", item_key, "quantity: ", quantity )

#var max_inventory_slots = 32
#func on_collected(item_key,quantity):
	#add_inventory(item_key, quantity)
#
#func add_inventory(item_key, quantity):
	#inventory_2[item_key] = inventory_2.get(item_key, 0) + quantity
	#print("Player has ", str(inventory_2[item_key]), " ", item_key) # TODO: Transport this to new inventory class
