extends PanelContainer

@onready var bioReactor : Button = $MarginContainer/VBoxContainer/BioReactor
@onready var CoolingCoils : Button = $MarginContainer/VBoxContainer/CoolingCoils
@onready var Sparger : Button = $MarginContainer/VBoxContainer/Sparger
@onready var Agitator : Button = $MarginContainer/VBoxContainer/Agitator
@onready var FilterationTank : Button = $MarginContainer/VBoxContainer/FilterationTank
@onready var SpectraMachine : Button = $MarginContainer/VBoxContainer/SpectraMachine
@onready var ProductContainer : Button = $MarginContainer/VBoxContainer/ProductContainer
@onready var SubstrateStorage : Button = $MarginContainer/VBoxContainer/SubstrateStorage

signal takeplayer(objectName)

var corellationDict = {
	"bioReactor":"tank",
	"CoolingCoils":"cooling",
	"Sparger":"sparger",
	"Agitator":"impeller",
	"FilterationTank":"filter_unit",
	"SpectraMachine":"spectramachine",
	"ProductContainer":"product_1",
	"SubstrateStorage":"sugar_feed",
}

# Called when the node enters the scene tree for the first time.
func _ready():
	bioReactor.pressed.connect(self._on_Button_pressed, 1)
	CoolingCoils.pressed.connect(self._on_Button_pressed, 2)
	Sparger.pressed.connect(self._on_Button_pressed, 3)
	Agitator.pressed.connect(self._on_Button_pressed, 4)
	FilterationTank.pressed.connect(self._on_Button_pressed, 5)
	SpectraMachine.pressed.connect(self._on_Button_pressed, 6)
	ProductContainer.pressed.connect(self._on_Button_pressed, 7)
	SubstrateStorage.pressed.connect(self._on_Button_pressed, 8)

func _on_Button_pressed(flag):
	var object_name = corellationDict.keys()[flag-1]
	print_debug(object_name)
	#takePlayer(object_name)
	emit_signal("takeplayer", object_name)

func takePlayer(object_name):
	#var chatbot = get_parent()
	#var labEnv = chatbot.get_parent()
	#var player = labEnv.get_node("Basic FPS Player")
	#var labBlender = labEnv.get_node("lab_blender")
	#var object = corellationDict[object_name]
	#var object_node = labEnv.get_node(object)
	#print_debug("objectFound: "+ object_node.name)
	## find the position coordinates of the object and take the player in an orbit motion around that object
	## Assuming the object node has a position property and you want to move the player around it
	#var object_position : Vector3 = object_node.global_transform.origin
	## Implement the orbit motion logic here. For simplicity, let's just move the player to the object's position
	##player.global_transform.origin = object_position + Vector3(1,1,1)
	##player.move_and_slide() use this fucntion to cause the motion in player
	#player.Node3D.transform.position = object_position + Vector3(1,1,1)
	pass
