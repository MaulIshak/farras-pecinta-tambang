class_name PendantManager
extends Node

# var active_pendant_special_effect: Array
var active_pendants: Array[PendantItem]
var player: Player
@export var pendant_slot: int = 3

func _ready() -> void:
    await owner.ready
    player = owner as Player
    assert(player != null, "The PendantManager must be used only in the player scene. It needs the owner to be a Player node.")

func equip_pendant(pendant: PendantItem) -> bool:
    if pendant != null and active_pendants.size() < pendant_slot:
        active_pendants.append(pendant)
        player.health += pendant.health_bonus
        player.base_damage += pendant.basic_attack_bonus
        print("pendant equipped: " + str(active_pendants.size()))
        return true
    else:
        print("Slot Full")
        return false
        
func unequip_pendant(pendant: PendantItem) -> void:
    if pendant != null and pendant in active_pendants:
        active_pendants.erase(pendant)
        player.health -= pendant.health_bonus
        player.base_damage -= pendant.damage_bonus