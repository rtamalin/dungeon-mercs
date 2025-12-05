extends Button

var slot_item: ItemData

func setup(item: ItemData) -> void:
	slot_item = item
	text = item.name
	icon = item.icon

	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	print("Clicked on: ", slot_item.name)
	# Do something with the item
	Game.use_item(slot_item)
