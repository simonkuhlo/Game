extends Label3D


@onready var parent:Player = $"../.."


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = "Current Spell: %s\nSelf.HP: %s" %[parent.current_spell.name, parent.health]
