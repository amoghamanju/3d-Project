extends Node3D  # Attach this to your coin node

@export var rotation_speed: float = 180.0  # Rotation speed in degrees per second

func _process(delta):
	# Rotate the coin around its Y-axis (upwards axis) to make it spin
	rotate_y(deg_to_rad(rotation_speed * delta))


func _on_static_body_3d_coin_collected() -> void:
	$Collection.play()
	pass # Replace with function body.


func _on_area_3d_area_entered(area: Area3D) -> void:
	# increase score
	
	# delete object
	
	pass # Replace with function body.
