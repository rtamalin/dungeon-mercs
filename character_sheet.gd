extends Resource
class_name CharacterSheet

enum CharacterRole {NONE, FIGHTER, HEALER, THIEF, MAGE}

# Basic Information
@export var name: String = "Character"
@export var portrait: Texture2D
@export var level: int = 1
@export var experience: int = 0
@export var primary_role: CharacterRole = CharacterRole.FIGHTER
@export var secondary_role: CharacterRole = CharacterRole.NONE

# Resource Stat Maximum
@export var max_health: int = 20
@export var max_stamina: int = 20
@export var max_mana: int = 20

# Resource Stat Current
@export var cur_health: int = 20
@export var cur_stamina: int = 20
@export var cur_mana: int = 20

# Core Attributes
@export var strength: int = 10
@export var agility: int = 10
@export var vitality: int = 10
@export var intelligence: int = 10
@export var wisdom: int = 10
@export var personality: int = 10
@export var luck: int = 0

# Equipment
# TODO

# Personal Inventory
# TODO

# Methods for character effects
func heal(amount: int) -> void:
	if cur_health < max_health:
		cur_health = min(cur_health + amount, max_health)
		Game.log_msg("Healed %s by %d to %d HP" % [name, amount, cur_health])
	else:
		Game.log_msg("Healing %s had no effect." % [name])
