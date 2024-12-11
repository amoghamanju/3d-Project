extends Node3D

var score = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_area_entered(area: Area3D) -> void:
	score += 1
	$Collection.play()
	area.get_parent().get_parent().queue_free()
	$Sprite3D/SubViewport/ProgressBar.value+=5
	pass # Repl
