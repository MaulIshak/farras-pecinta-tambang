class_name PendantItem
extends CollectibleData

@export var pendant_name: String

@export_group("Passive Stats")
@export var health_bonus: int = 0
@export var basic_attack_bonus: int = 0
@export var magic_power_bonus: float = 0.0
@export var mana_bonus: float = 0.0

@export_group("Special Effect")
@export var special_effect_scene: PackedScene
@export var special_effect_description: String

func apply_effect(target: Node) -> bool:
    if target.has_method("equip_pendant"):
        return target.equip_pendant(self)
    
    return false
