extends Area3D  # Attach this to your coin node

signal coin_collected  # Define the signal at the top level, not inside any function

func _ready():
	# Connect the "body_entered" signal to handle collection
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	# Check if the colliding body is the right controller
	if body.name == "$XROrigin3D/RightController":  # Replace with your right controller's node name
		emit_signal("coin_collected")  # Emit signal for further actions
		queue_free()  # Remove the coin from the scene
