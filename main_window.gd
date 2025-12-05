extends Control

@onready var inventory_window: Control = $InventoryWindow
@onready var viewport = $MainLayout/LeftColumn/SubViewportContainer/MainView

const DOOM_LEVELS: Array[PackedScene] = [
	preload("res://doom_level_1.tscn")
]

enum {DOOM_LEVEL1}

var starting_scene = DOOM_LEVELS[DOOM_LEVEL1]

func change_viewport_scene(new_scene: PackedScene) -> void:
	print("Changing ", viewport.name)
	for child in viewport.get_children():
		child.queue_free()
	
	var new_scene_inst = new_scene.instantiate()
	print("Switching ", viewport.name, " to ", new_scene_inst.name)
	
	viewport.add_child(new_scene_inst)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	change_viewport_scene(starting_scene)

func _unhandled_input(event: InputEvent) -> void:	
	if event.is_action_pressed("inventory"):
		toggle_inventory()

func toggle_inventory() -> void:
	inventory_window.toggle_inventory()
