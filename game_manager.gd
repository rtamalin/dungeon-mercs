extends Node

# Signal sent when a action that triggers passage of time completes
signal time_advanced(tick)

var clock: int = 0

# Allow access to party from anywhere
var party: Array[CharacterSheet] = []

var shared_inventory: Array[ItemData] = []

var message_log : Node = null # Will be assigned by main UI when ready

func notify_time() -> void:
	time_advanced.emit(clock)

func advance_time() -> void:
	clock += 1
	print("Game Time: ", clock)
	
	notify_time()
	
	# TODO - Loop through active effects and regeneration

func add_shared_inventory(item: ItemData) -> void:
	shared_inventory.append(item)
	log_msg("Picked up: " + item.name)
	
func log_msg(text: String) -> void:
	if message_log:
		message_log.add_message(text)
	else:
		print("WARNING: Message Log not setup! Logging Message: ", text)

func consume_item(item: ItemData) -> void:
	match item.effect:
		"heal":
			# really should have some means of selecting active character
			# that effect will be applied to
			var active_char = 0
			if party.size() > 0:
				party[active_char].heal(item.magnitude)

	print("DBG: deleting the item from the shared inventory")
	print("DBG: [before] shared inventory has %s items" % [shared_inventory.size()])
	shared_inventory.erase(item)
	print("DBG: [after]  shared inventory has %s items" % [shared_inventory.size()])

	advance_time()

func use_item(item: ItemData) -> void:
	if item.is_consumable:
		consume_item(item)

#
# Godot Built-in Methods
#

func _ready() -> void:
	# Load the character resource file from disk
	var hero = load("res://hero_warrior.tres")
	
	# Add to the global party array
	if hero:
		party.append(hero)
		print("Party initialised with: ", hero.name)
