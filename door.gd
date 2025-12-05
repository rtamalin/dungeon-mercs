extends StaticBody3D

@onready var parent_node = get_parent()
# @onready var door_body = $StaticBody3D
# @onready var door = $Door

const GRID_SIZE = 2.0
var is_open: bool = false

func interact() -> void:
	if not parent_node:
		print("Door StaticBody3D failed to get parent!")
		return
		
	if is_open:
		return

	print("Door opening...")
	is_open = true

	# Animate door opening by sliding into ceiling
	var tween = create_tween()
	tween.tween_property(self, "postition:y", GRID_SIZE * 1.5, 1.0)
	tween.finished.connect(door_opened)
	# position.y -= GRID_SIZE * 1.5

	# Disable collision
	collision_layer = 0

	Game.advance_time()

func door_opened() -> void:
	print("Door opened.")

func _ready() -> void:
	print("DEBUG: Old Door ", name, " - position: ", position, ", global: global_position: ", global_position)
