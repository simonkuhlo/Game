extends CharacterBody3D

class_name Entity

@export var health = 100:
	set(new_value):
			health = new_value
			print(self, "My health changed. New Value: ", self.health)
			if health < 0:
				print("I died!")
