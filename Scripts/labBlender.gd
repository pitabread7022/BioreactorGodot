extends Node3D

@onready var bioReactor: MeshInstance3D = $tank
@onready var CoolingCoils: MeshInstance3D = $cooling
@onready var Sparger: MeshInstance3D = $sparger
@onready var Agitator: MeshInstance3D = $impller
@onready var FilterationTank: MeshInstance3D = $filter_unit
@onready var SpectraMachine: MeshInstance3D = $spectramachine
@onready var ProductContainer: MeshInstance3D = $product_1
@onready var SubstrateStorage: MeshInstance3D = $sugar_feed

@onready var player: CharacterBody3D = $"../Basic FPS Player"

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
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_chat_bot_take_player_to(objectName):
	# Get the corresponding node name from the dictionary
	#var node_name = corellationDict.get(objectName, "")
	var node_name = objectName
	if node_name != "":
		# Find the node in the scene
		var target_node = get_node(node_name)
		if target_node:
			# Move the player to the target node's position
			player.global_transform.origin = target_node.global_transform.origin
