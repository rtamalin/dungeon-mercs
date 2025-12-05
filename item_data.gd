extends Resource
class_name ItemData

@export var name: String = "Item"
@export_multiline var description: String = "..."
@export var icon: Texture2D # add this via the UI later
@export var is_consumable: bool = false
@export var effect: String
@export var magnitude: int
