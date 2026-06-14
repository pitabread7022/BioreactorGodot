extends RayCast3D

@onready var prompt = $promt  # Ensure this matches the actual node name in the scene tree

# Signal to manage interactions
signal object_detected(interactable)

# Called when the node enters the scene tree for the first time.
func _ready():
	#add_exception(owner)  # Prevents the RayCast from detecting the object it's attached to
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if is_colliding():
		handle_collision()
	else:
		prompt.text = ""

# Handles collision detection and interactions

func handle_collision():
	var detected = get_collider()#get_collider()
	if detected:
		# Always display the name of the detected object
		prompt.text = "Detected: " + detected.name
		# Emit signal for all detected objects
		emit_signal("object_detected", detected)
	else:
		prompt.text = ""  # Clear prompt text when no object is detected
#
#
#func handle_collision():
	#var detected = get_collider()
	#if detected:
		#if detected.has_method("interactable"):
			#prompt.text = detected.name  # Display the name of the interactable object
			#emit_signal("object_detected", detected)
		#else:
			#prompt.text = "Detected: " + detected.name  # Generic message for detected objects
	#else:
		#prompt.text = ""  # Clear prompt text when no object is detected
