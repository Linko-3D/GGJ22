extends Control

func _ready():
	$Hide.show()
	$Tween.interpolate_property($Hide, "color", Color(0, 0, 0, 1), Color(0, 0, 0, 0), 0.5)
	$Tween.interpolate_property($Hide, "color", Color(0, 0, 0, 0), Color(0, 0, 0, 1), 0.5, 0, 2, 1)
	$Tween.start()

func _on_Timer_timeout():
	get_tree().change_scene("res://Main.tscn")
