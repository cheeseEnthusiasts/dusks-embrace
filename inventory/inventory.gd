extends Resource
# inventory setup, this can be used for any inventory system

class_name Inventory

@export var items: Array[InvItem]  # Makes it so that InvItems can go into the inventory, as defined in inventory_item.gd