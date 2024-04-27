extends Control

#@onready var inv: Inventory = preload("res://inventory/player_inventory.tres")
#@onready var slots: Array = $GridContainer.get_children()

var is_open = false  #inventory check

func _ready():
	#update_slots()
	close()

#func update_slots():
	#for i in range(min(inv.items.size(), slots.size())):
		#slots[i].update(inv.items[i])


func _process(_delta):
	if Input.is_action_just_pressed("Inventory"):
		if is_open:
			close()
		else:
			open()


# inventory
func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
