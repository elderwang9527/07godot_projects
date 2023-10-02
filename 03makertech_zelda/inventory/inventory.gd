extends Resource

class_name  Inventory

signal updated

@export var slots: Array[InventorySlot]

## 23-0539前
#func insert(item: InventoryItem):
#	for slot in slots:
#		if slot.item == item:
#			slot.amount += 1
#			updated.emit()
#			return
#
#	for i in range(slots.size()):
#		if !slots[i].item:
#			slots[i].item = item
#			slots[i].amount = 1
#			updated.emit()
#			return

# 23-0539后，视频没解释这段代码，需要自己研究
func insert(item: InventoryItem):
#	var itemSlots = slots.filter(func(slot): return slot.item == item && slot.amount < slot.item.max)
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	if !itemSlots.is_empty():
		itemSlots[0].amount += 1
	else:
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		if !emptySlots.is_empty():
			emptySlots[0].item = item
			emptySlots[0].amount = 1

	updated.emit()
			
		
