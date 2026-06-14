extends CenterContainer

@onready var aereationRate: TextEdit = $PanelContainer2/VBoxContainer/HBoxContainer/TextEdit
@onready var aerationPower: TextEdit = $PanelContainer2/VBoxContainer/HBoxContainer2/TextEdit
@onready var agiratorRpm: TextEdit = $PanelContainer2/VBoxContainer/HBoxContainer3/TextEdit
@onready var brothVsicocityInput: TextEdit = $PanelContainer2/VBoxContainer/HBoxContainer4/TextEdit
@onready var a0: TextEdit = $PanelContainer2/VBoxContainer/HBoxContainer5/TextEdit
@onready var a1: TextEdit = $PanelContainer2/VBoxContainer/HBoxContainer6/TextEdit
@onready var a3: TextEdit = $PanelContainer2/VBoxContainer/HBoxContainer7/TextEdit
@onready var meanVacoule: TextEdit = $PanelContainer2/VBoxContainer/HBoxContainer8/TextEdit
@onready var maxVacoule: TextEdit = $PanelContainer2/VBoxContainer/HBoxContainer9/TextEdit

## Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	aereationRate.text = str(45 * sin(35 * delta))
	aerationPower.text = str(23 + 5.5 * cos(delta))
	agiratorRpm.text = str(60 + 20 * sin(25 * delta))
	brothVsicocityInput.text = str(10 + 3 * cos(15 * delta))
	a0.text = str(5 * sin(45 * delta))
	a1.text = str(7 * cos(30 * delta))
	a3.text = str(9 * sin(20 * delta))
	meanVacoule.text = str(11 + 2 * cos(10 * delta))
	maxVacoule.text = str(50 + 25 * sin(40 * delta))
	#pass
