extends Node3D

var score = 0;
@export var max_score: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_area_entered(area: Area3D) -> void:
	score += 1
	$Collection.play()
	#if $ColorRect/MarginContainer/VBoxContainer/ProgressBar:
	#	$ColorRect/MarginContainer/VBoxContainer/ProgressBar.value=float(score) / float(max_score) * 100.0 
	area.get_parent().get_parent().queue_free()
	$Sprite3D/SubViewport/ProgressBar.value+=5
	#$Sprite3D/SubViewport/TextureProgressBar.value+=5
	pass # Replace with function body.
