extends Node3D

@onready var subViewPort: SubViewport = $SubViewport
@onready var activePanel: Control = $SubViewport/GUI/MarginContainer/activePanel
@onready var inactivePanel: Control = $SubViewport/GUI/MarginContainer/inactivePanel
@onready var objectNameActive: Label = $SubViewport/GUI/MarginContainer/activePanel/VBoxContainer/objectName
@onready var objectNameInActive: Label = $SubViewport/GUI/MarginContainer/inactivePanel/objectName

@onready var attachedTo: MeshInstance3D = get_parent()
@onready var labBlender: Node3D = attachedTo.get_parent()
@onready var labEnvironment: CanvasLayer = labBlender.get_parent()
@onready var player: Node3D = labEnvironment.get_node("Basic FPS Player/Head")
@onready var raycast: RayCast3D = player.get_node("RayCast3D")

func _ready():
	activePanel.hide()
	inactivePanel.show()
	setProperties("No Object")

func _process(delta):
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider:
			updateProperties(collider.name)
			if Input.is_action_just_pressed("interact"):
				activePanel.show()
				inactivePanel.hide()
		else:
			activePanel.hide()
			inactivePanel.show()
			setProperties("No Object")
	else:
		activePanel.hide()
		inactivePanel.show()
		setProperties("No Object")

func setProperties(objectName: String):
	objectNameInActive.text = "Object Name: " + objectName
	objectNameActive.text = "Object Name: " + objectName

func updateProperties(objectName: String):
	objectNameInActive.text = "Object Name: " + objectName
	objectNameActive.text = "Object Name: " + objectName






#______________________________________
#extends Node3D
#
#@onready var subViewPort: SubViewport = $SubViewport
#@onready var activePanel: Control = $SubViewport/GUI/MarginContainer/activePanel
#@onready var inactivePanel: Control = $SubViewport/GUI/MarginContainer/inactivePanel
#@onready var objectNameActive: Label = $SubViewport/GUI/MarginContainer/activePanel/VBoxContainer/objectName
#@onready var objectNameInActive: Label = $SubViewport/GUI/MarginContainer/inactivePanel/objectName
#
#@onready var labEnvironment: Node = $"."
#@onready var player: Node3D = labEnvironment.get_node("Basic FPS Player/Head")
#@onready var raycast: RayCast3D = labEnvironment.get_node("Basic FPS Player/Head/RayCast3D")
#
#func _ready():
	#activePanel.hide()
	#setProperties("No Object")
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if raycast.is_colliding():
		#var collider = raycast.get_collider()
		#if collider:
			#updateProperties(collider.name)
			#if Input.is_action_just_pressed("interact"):
				#activePanel.show()
				#inactivePanel.hide()
		#else:
			#activePanel.hide()
			#inactivePanel.show()
			#setProperties("No Object")
#
#func setProperties(objectName: String):
	#objectNameInActive.text = "Object Name: " + objectName
	#objectNameActive.text = "Object Name: " + objectName
#
#func updateProperties(objectName: String):
	#objectNameInActive.text = "Object Name: " + objectName
	#objectNameActive.text = "Object Name: " + objectName
