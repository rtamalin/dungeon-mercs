extends Panel

@export var item_slot_scene: PackedScene
@onready var grid: GridContainer = $MarginContainer/InventoryLayout/ScrollContainer/ItemGrid
@onready var close_btn: Button = $MarginContainer/InventoryLayout/Close

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not item_slot_scene:
		push_error("ERROR: no item slot scene defined.")
	close_btn.pressed.connect(hide_inventory)
	
	Game.time_advanced.connect(func(_clock_tick: int): refresh())

func show_inventory() -> void:
	visible = true

func hide_inventory() -> void:
	visible = false

func toggle_inventory() -> void:
	if not visible:
		visible = true
		refresh()
	else:
		visible = false

func refresh() -> void:
	print("DBG: Refreshing Inventory Window")
	# clear out existing ItemGrid items
	for child in grid.get_children():
		child.queue_free()

	for item in Game.shared_inventory:
		if item_slot_scene:
			var slot = item_slot_scene.instantiate()
			grid.add_child(slot)
			slot.setup(item)
			
			slot.size_flags_horizontal = Control.SIZE_EXPAND_FILL
