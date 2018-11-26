extends Area2D


var value = ""
var speed
var ghost_state = false

func _ready():
	$CollisionShape2D.disabled = true
	$Sprite.visible = false




func _process(delta):
	
	
	match value:
		"right":  self.position.x = self.position.x + speed*delta
		"left": self.position.x = self.position.x - speed*delta
		"down": self.position.y = self.position.y + speed*delta
		"up": self.position.y = self.position.y - speed*delta
	
	
	

func _on_ghost_body_entered(body):
	get_tree().reload_current_scene()
