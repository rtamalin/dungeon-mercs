extends Node

class_name Main

# Signals that we may want the main node to generate
signal game_started
signal game_paused

# Exported Attributes
@export var main_menu_scene: PackedScene
@export var starting_city_scene: PackedScene
@export var starting_dungeon_scene: PackedScene

# Member Variables
var _current_game_instance: Node = null

#
# Built-in Godot Methods
#

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Setup initial state, load first scene
	print("Loading main menu...")
	_load_main_menu()
	print("Main menu ready")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#
# Private Custom Methods
#
func _load_main_menu() -> void:
	pass

#
# Public Methods for use by other nodes or autoloads
#

func start_new_gane() -> void:
	print("Starting new game...")
	
	# Clean up any existing game content
	if _current_game_instance:
		_current_game_instance.queue_free()
		
	# Instantiate a new game instance
	_current_game_instance = starting_city_scene.instantiate()
	add_child(_current_game_instance)
	
	# Signal that the game has started
	emit_signal("game_started")
