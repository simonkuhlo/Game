extends Timer

class_name StatusEffectsHandler

@onready var effect:StatusEffect
@onready var entity:Entity

func _ready():
	var ttlTimer = Timer.new()
	add_child(ttlTimer)
	ttlTimer.wait_time = effect.timeToLive
	ttlTimer.one_shot = true
	ttlTimer.connect("timeout", self.endEffect)
	ttlTimer.start()
	
	var tickTimer = Timer.new()
	add_child(tickTimer)
	tickTimer.wait_time = effect.tickrate
	tickTimer.one_shot = false
	tickTimer.connect("timeout", self.applyEffect)
	tickTimer.start()
	
func applyEffect():
	entity.health = entity.health + effect.value

func endEffect():
	queue_free()
