extends Control


var nimbus_state = 0.5




func _ready():
	pass

func _process(delta):
	$Nimbus2000/Light2D.scale.x = nimbus_state