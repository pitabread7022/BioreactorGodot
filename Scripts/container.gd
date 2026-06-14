extends MeshInstance3D

@onready var staticBody: StaticBody3D = $StaticBody3D
@onready var collider: CollisionShape3D = $StaticBody3D/CollisionShape3D
@onready var guiPanel: Node3D = $guiPanel3D

var player
var raycast

func _ready():
	staticBody.name = "WaterContainer"
	collider.name = "Container"
	guiPanel.visible = false
	player = guiPanel.get("player") # Retrieve player variable from guiPanel
	raycast = guiPanel.get("raycast") # Retrieve raycast variable from guiPanel
	alignPanel()

func _process(delta):
	if raycast.is_colliding(): #and raycast.get_collider() == collider:
		guiPanel.visible = true
		alignPanel()
	else:
		guiPanel.visible = false

func alignPanel():
	var ray_origin = player.global_transform.origin
	var ray_direction = raycast.global_transform.basis.z.normalized()
	guiPanel.global_transform.origin = ray_origin + ray_direction * 1.0 # Position the panel 1m in front of the player
	guiPanel.look_at(ray_origin, Vector3.UP) # Align the panel to face the player







#_______________________________________________________
#extends MeshInstance3D
#
#@onready var collider: CollisionShape3D = $StaticBody3D/CollisionShape3D
#@onready var guiPanel: Node3D = $guiPanel3D
#@onready var labEnvironment: Node = $"."
##@onready var player: Node3D = labEnvironment.get_node("Basic FPS Player/Head")
##@onready var raycast: RayCast3D = labEnvironment.get_node("Basic FPS Player/Head/RayCast3D")
#
#var player = guiPanel.getvariable("player") # get the player variable in guiPanel Object
#var raycast = guiPanel.getVariable("raycast") # get the raycast variable in guiPanel Object
#
#func _ready():
	#collider.name = "Container"
	#guiPanel.visible = false
	#alignPanel()
#
#func _process(delta):
	#if raycast.is_colliding() and raycast.get_collider() == collider:
		#guiPanel.visible = true
		#alignPanel()
	#else:
		#guiPanel.visible = false
#
#func alignPanel():
	#var ray_origin = player.global_transform.origin
	#var ray_direction = raycast.global_transform.basis.z.normalized()
	#guiPanel.global_transform.origin = ray_origin + ray_direction * 1.0 # Position the panel 1m in front of the player
	#guiPanel.look_at(ray_origin, Vector3.UP) # Align the panel to face the player
