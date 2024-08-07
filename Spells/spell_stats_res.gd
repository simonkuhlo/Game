extends Resource
class_name SpellStats


@export var damage:int = 100
@export var element:Element

@export var projectile_speed:float = 10
@export var seconds_to_live:float = 10

@export var onhit_effects:Array[StatusEffect] = []
