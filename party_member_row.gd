extends HBoxContainer

@onready var name_lbl: Label = $NameLabel
@onready var hp_lbl: Label = $HPLabel
@onready var sp_lbl: Label = $SPLabel
@onready var mp_lbl: Label = $MPLabel

func setup(chr: CharacterSheet) -> void:
	name_lbl.text = chr.name
	hp_lbl.text = "HP: %d/%d" % [chr.cur_health, chr.max_health]
	sp_lbl.text = "SP: %d/%d" % [chr.cur_stamina, chr.max_stamina]
	mp_lbl.text = "MP: %d/%d" % [chr.cur_mana, chr.max_mana]
