extends Resource

class_name  Inventory

signal updated

@export var slots: Array[InventorySlot]

## 23-0539前
#func insert(item: InventoryItem):
#	# 循环每个slot，如果循环到的slot的item跟当前捡到的item一样，则数量加1。
#	for slot in slots:
#		if slot.item == item:
#			slot.amount += 1
#			updated.emit()
#			return
#
#	# 上一步循环完都没有，则重新循环一次，循环到的首个空的slot就存储下当前的item，并把数量记为1。
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
			
		
