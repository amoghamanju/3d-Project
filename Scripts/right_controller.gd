extends XRController3D

@export var is_left_hand: bool = true  # Set this to `false` for the right-hand controller
@export var movement_speed: float = 4.0  # Speed of movement when walking
@export var swing_threshold: float = 0.05  # Sensitivity for detecting hand swings
@export var button_action: String = "ui_accept"  # Input action to hold for movement

var prev_y_position: float = 0.0
var is_moving: bool = false

signal hand_swing_detected  # Signal to communicate with the main player script



func _ready():
	# Initialize the previous Y-position for swing detection
	prev_y_position = transform.origin.y

		
		
func _on_body_entered(body):
	if body.name == "Coin":  # Adjust the name if needed
		if body.has_signal("coin_collected"):
			body.emit_signal("coin_collected")
			print("Coin collected by right controller!")

func _process(delta):
	# Check for vertical swing detection
	if detect_hand_swing() or Input.is_action_pressed(button_action):
		emit_signal("hand_swing_detected")
		is_moving = true
	else:
		is_moving = false

	# Optional: Visual or sound feedback when moving
	if is_moving:
		# You can add vibration or feedback logic here if needed
		pass

func detect_hand_swing() -> bool:
	var current_y_position = transform.origin.y
	var swing_detected = abs(current_y_position - prev_y_position) > swing_threshold

	# Update the previous Y-position for the next check
	prev_y_position = current_y_position

	return swing_detected
