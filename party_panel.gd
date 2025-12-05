extends Panel

@export var row_scene: PackedScene
@onready var container: VBoxContainer = $PartyList

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Wait for Game singleton to be ready and then render
	update_party_display()
	
	# List for clock ticks to refresh stats
	Game.time_advanced.connect(func(_t): update_party_display())

func update_party_display() -> void:
	
	# clean up old rows
	for child in container.get_children():
		# skip party stats level
		if child is Label and child.text == "Party Stats":
			continue
		child.queue_free()

	for member in Game.party:
		if row_scene:
			var new_row = row_scene.instantiate()
			container.add_child(new_row)
			new_row.setup(member)
	
