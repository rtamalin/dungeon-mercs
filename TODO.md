# Oustanding Areas to work on

## Finish out prototype

### Core Gameplay Mechanics

* Add additional character attributes
  * Attack, Defense
  * Money
* Add character specific equipment set & inventory
  * Add character equipment slots
    * Armour, Equiment and Decorations
      * Limited set of equipment definitions to support simple encounter
* Add a basic combat encounter
* Add a vendor with associated buy & sell dialog
* Starting City
* Party Management
    * Define basic classes/roles
    * Define basic skills
    * Basic Character Generation
* Basic save and load

### Core Visuals

* Add textures to dungeon tiles in the dungeon mesh library
* Enhance character display in main window
  * Add portrait
  * Show health, stamina and mana points as stack of values beside portrait

## Transitioning to a real game

### Define location generation and management resources

* Define resource types for the following:
  * Layout 
    * Predefined
      * Handcrafted or specified via an input file, possibly JSON
    * Dynamically Generated
      * Algorithm to use for generation
      * Seed for generation, optionally random
    * Associated Tile Set Mesh Library
    * Associated Texture Set
    * Each grid location will have:
      * Basic tile type
      * Optional Texture overrides
      * Directional Collision States
      * Optional annotation message
        * E.g. "You see a sign on the south wall."
      * Optional list of one or more directional annotation messages
        * E.g. When facing south "A sign on the south wall reads: Guards Barracks"
      * Optional list of one or more tile objects
        * Traps
        * Chests
        * Decorations
        * Levers & Switches
      * Optional list of one or more encounters
        * Fixed encounter
        * Chance of random encounter if no fixed encounter
      * Optional list of effect scripts
      * Optional list of breakable walls
  * Layout Overlay
    * Track changes made to a layout
      * Visited/Mapped
      * Predefined encounter defeated/cleared
      * Random encounter chances
      * Doors unlocked or locked
      * Traps disarmed or sprung
      * Chests looted
      * Lever & Switch states
      * Script Effect States
      * Walls broken
      * Rope or Ladder Emplacement

* Define better Tile Set Mesh libraries
  * Provide complex tiles for following location types
    * Open
    * One wall only (N, S, E, W)
    * Two walls (each pair of directions)
    * Three walls (each trio of directions)
    * All four Walls
    * Decorative pillars

* Define tile overlay objects
  * Decorative Objects
    * Signs
    * Torches
    * Pedestals
    * Paintings
  * Doors
  * Traps
    * Pit Traps
      * Simple damage or fall through to lower level (teleport)
    * Teleporters (within level, or to another level)
    * Direction spinner
  * Chests and other lootables
  * Levers and Switches

* Define effects that can be attached to tile objects
  * Hidden unless detected (magically or with skill)
    * Levers & Switches
    * Traps
  * Locked (for doors and chests)
  * Trapped (for doors and chests)
  * Teleport
  * Interactions
    * Lock/Unlock a door
    * Open/Close a door
    * Set a state flag
    * Turn on or off lights
    * Disable a trap

* Create tools to manage generation of location grids
  * Tools to assist in generation & maintenance of fixed layout input files (JSON)
    * Either as @tool extensions/plugins
    * Or as external tools
  * Implement algorithms for dynamic generation of location grids
    * Using an input seed, generate repeatable layouts with the following themes:
      * Caves & Caverns
      * Corridors & Rooms
      * Streets & Houses
      * Paths & Forests
      * Canyons & Mountains
      * Rivers & Lakes
      * Underwater corals, caves & ruins
      * Deep Ocean
    * Potentially be able to export a fixed layout input file from dynamically generated layout

### Generate Libraries of Visual Elements

* Define libraries of textures for the following themes:
  * Caves & Caverns
  * Corridors & Rooms
  * Streets & Houses
  * Paths & Forests
  * Canyons & Mountains
  * Rivers & Lakes
  * Underwater corals, caves & ruins
  * Deep Ocean

* Define libraries of icons for Items
  * Icons should be recognisable at various scale levels
    * Small, medium and large
  * Variations of equipment icons for:
    * Materials
    * Quality
    * Special Versions

* Define libraries of icons/portraits for characters and monsters
  * Portraits should be recognisable at various scale levels
    * Small, medium and large
  * Generate portraits for various combinations of
    * Classes or Roles
      * Archer, Warrior, Thief, Mage, Healer
    * Races
      * Humans, Dwarves, Elves, Reptilian, Feline, Canine, Ursine, Insectoid, Undead, Aquatic
    * Beasts
      * Various real world and fantasy/mythical creatures
    * Skin/Scale/Hide Colours
    * Hair, Facial Hair
    * Sex

### Game Concepts

* Define the Mercenary Company
  * Has roster of members
    * Characters
    * NPCs
  * Camp roles
    * Can be filled with Characters or NPCs
    * Possible roles:
      * Cook
      * Armsmaster (weapons & armour trainer)
      * Smith (armourer, weaponsmith)
      * Fletcher (arrows, bolts, darts)
      * Healer (magic scrolls, charges, cleric trainer)
      * Scribe (magic scrolls, charges, magic trainer)
      * Alchemist (Potions, Grenades)
      * Quartermaster
      * Forager
  * Funds
  * Reputation

* Define the Adventuring Party
  * Party Members
    * Characters
    * Pets, Summons & NPCs
  * Combat Formation
    * Front, Middle & Back lines
    * Left & Right flanks

* Define the Character
  * Stats
    * Classes/Roles
      * Primary
      * Secondary
    * Level
    * Experience
    * Fame
    * Core Attributes
    * Core Skills
      * Weapon & Armour Skills
      * Magic Skills (Cleric & Mage)
      * Adventuring Skills
      * Camp Skills
    * Derived Stats
      * Health, Stamina, Mana
      * Attack & Defence
      * Attacks Per Round
      * Resistances
      * Damage Reductions
    * Combat Metrics
      * Attacks with Hit (glancing, solid & critical) & Miss %ages
      * Total, Max & Average Damage
      * Toughest Kill
  * Equipment
    * Fixed Slots for basic equipment
      * Head (under and outer)
      * Neck
      * Body (under and outer)
      * Back
      * Shoulders
      * Forearms
      * Hands
      * Rings (2 per hand)
      * Waist (belt and underwear)
      * Ammo Quiver/Pouch
      * Spell book
      * Shinguards
      * Feet (under and outer)
      * Light Source
    * Variable Slots
      * Weapon Slots (belt or shoulders)
      * Ready Slots (belt)
      * Ammo Slots (quiver/pouch)
      * Quick Spells (spell book, rings, neck)
  * Spells
  * Inventory

* Define spells and associated effects
  * Define leveled collected of spells for Cleric and Mages
  * Define spell effects associated with spells

* Combat Encounters
  * Attack vs Defence Rating
    * Miss, Glancing vs Solid vs Critical Hits
  * Impact of Weapon Type
  * Impact of Weapon Damage Type
  * Impact of Weapon skill (attack)
  * Impact of Armour & Equipment (defence)
  * Impact of Luck (attack & defence)
  * Impact of Resistances
  * Impact of Damage reducions (defence)

### Game State Management

* Define a game save format that encompasses dynamic game state
  * Company Roster (Characters and supporting NPCs)
  * Adventuring Company (Characters and Pets/Summons/NPCs)
  * Company Inventory (shared)
    * Content & Expansions
  * Characters
    * Stats
    * Equipment
    * Personal Inventory
  * Location Overlay States
  * Journal
  * Quest log

### Item Definitions

* Add support for item stacking to core ItemData
* Add support for additional ItemData properties
  * Slot Type
    * Armour with various slot locations
    * Weapon or Shield
    * Quiver or Pouch
    * Readied
  * Weight
  * Weapon
    * Damage
      * Type, Min & Max
    * Range
      * Melee
      * Extended Melee
      * Ammo Range
        * Min, Effective, Accurate
    * Thrown
      * Grenades
      * Surfaces
      * Entanglers
      * Barriers
  * Armour
    * Protection
      * Damage Type Reduction
      * Effects
* Add new item types that inherit ItemData
  * Weapons & Shields
    * Melee Weapons
      * One-handed
        * Small & Light weight
        * Standard & Medium weight
        * Large & Heavy weight
      * Two-handed
        * Standard & Medium weight
        * Large & Heavy weight
        * Extra Large & Very heavy weight 
    * Ranged Weapons
      * One-handed
        * Darts & Throwing Knives
        * Javelins & Axes
        * Very light crossbows
        * Magic Wands
      * Two-Handed
        * Crossbows
          * Light, medium & heavy
        * Bows
          * Compact, Short, Long & Composite
        * Magic Staves
    * Shields
  * Armour & Equipment
    * Slot Specific
      * Head (under and outer)
      * Neck
      * Body (under and outer)
      * Back
      * Shoulders
      * Forearms
      * Hands
      * Rings (2 per hand)
      * Waist (belt and underwear)
      * Quiver/Pouch
      * Spell book
      * Shinguards
      * Feet (under and outer)
      * Light Source
  * Consumables
    * Ammunition
      * Darts & Throwing Knives
      * Javelins & Axes
      * Arrows & Bolts
      * Wand & Stave Charges
    * Potions
    * Scrolls
    * Fuel
    * Torches
  * Storage
    * Scroll Case
    * Potion Case
    * Gem Pouch
    * Belt Pouch (ready items)
    * Quivers, Bullet & Charge Pouches (ammo)
    * Bags of holding/sharing (access company shared inventory)
  * Tools
    * Compass
    * Ropes
    * Ladders
    * Arcane Tools
    * Armourers Tools
    * Blacksmith Tools
    * Cooks Tools
    * Fletchers Tools
    * Scribes Tools
    * Thieves Tools

Implement tooling that can be used to generate ItemData resources from pre-generated input (JSON?) files

Define libraries of ItemData resources by type or aggregations of multiple types.

<!--
# vim:shiftwidth=2:tabstop=2:expandtab:autoindent
-->
