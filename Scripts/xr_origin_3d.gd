extends XROrigin3D

@export var left_hand_node_path: NodePath
@export var right_hand_node_path: NodePath
@export var main_camera_path: NodePath
@export var forward_direction_node_path: NodePath

@export var speed: float = 60.0  # Movement speed multiplier
@export var movement_start_delay: float = 1.0  # Delay before movement starts (in seconds)

var left_hand_prev_pos: Vector3
var right_hand_prev_pos: Vector3
var player_prev_pos: Vector3
var start_time: float = 0.0

@onready var left_hand_node: Node3D = get_node(left_hand_node_path)
@onready var right_hand_node: Node3D = get_node(right_hand_node_path)
@onready var main_camera: Node3D = get_node(main_camera_path)
@onready var forward_direction_node: Node3D = get_node(forward_direction_node_path)

func _ready():
	# Initialize previous positions at start
	player_prev_pos = global_transform.origin
	left_hand_prev_pos = left_hand_node.global_transform.origin
	right_hand_prev_pos = right_hand_node.global_transform.origin
	start_time = Time.get_ticks_msec() / 1000.0  # Record the start time in seconds

func _process(delta: float):
	# Ensure movement starts after a delay
	if (Time.get_ticks_msec() / 1000.0) - start_time < movement_start_delay:
		return

	# Set forward direction based on main camera's Y rotation
	var y_rotation = main_camera.global_transform.basis.get_euler().y
	forward_direction_node.global_transform.basis = Basis().rotated(Vector3.UP, y_rotation)

	# Get current positions of hands and player
	var player_current_pos = global_transform.origin
	var left_hand_current_pos = left_hand_node.global_transform.origin
	var right_hand_current_pos = right_hand_node.global_transform.origin

	# Calculate distances moved since the last frame
	var player_distance_moved = player_current_pos.distance_to(player_prev_pos)
	var left_hand_distance_moved = left_hand_prev_pos.distance_to(left_hand_current_pos)
	var right_hand_distance_moved = right_hand_prev_pos.distance_to(right_hand_current_pos)

	# Calculate aggregate hand speed
	var hand_speed = ((left_hand_distance_moved - player_distance_moved) + (right_hand_distance_moved - player_distance_moved))

	# Move the player forward based on hand speed
	global_translate(-forward_direction_node.global_transform.basis.z * hand_speed * speed * delta)

	# Update previous positions for the next frame
	left_hand_prev_pos = left_hand_current_pos
	right_hand_prev_pos = right_hand_current_pos
	player_prev_pos = player_current_pos
