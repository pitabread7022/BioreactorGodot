extends CenterContainer


@onready var volume: TextEdit = $PanelContainer/VBoxContainer/HBoxContainer/TextEdit
@onready var penciConc: TextEdit =$PanelContainer/VBoxContainer/HBoxContainer2/TextEdit
@onready var dischargeRate: TextEdit =$PanelContainer/VBoxContainer/HBoxContainer3/TextEdit
@onready var sugarFeedRate: TextEdit =$PanelContainer/VBoxContainer/HBoxContainer4/TextEdit
@onready var oilFeedRate: TextEdit =$PanelContainer/VBoxContainer/HBoxContainer5/TextEdit
@onready var aerationRate: TextEdit =$PanelContainer/VBoxContainer/HBoxContainer6/TextEdit
@onready var backPressure: TextEdit =$PanelContainer/VBoxContainer/HBoxContainer7/TextEdit
@onready var waterDilution: TextEdit =$PanelContainer/VBoxContainer/HBoxContainer8/TextEdit
@onready var paaFlowRate: TextEdit =$PanelContainer/VBoxContainer/HBoxContainer9/TextEdit
@onready var pH: TextEdit =$PanelContainer/VBoxContainer/HBoxContainer10/TextEdit
@onready var Temp: TextEdit =$PanelContainer/VBoxContainer/HBoxContainer11/TextEdit
@onready var acidFlowRate: TextEdit =$PanelContainer/VBoxContainer/HBoxContainer12/TextEdit
@onready var baseFlowRate: TextEdit =$PanelContainer/VBoxContainer/HBoxContainer13/TextEdit
@onready var coolingWater: TextEdit =$PanelContainer/VBoxContainer/HBoxContainer14/TextEdit
@onready var heatingWater: TextEdit =$PanelContainer/VBoxContainer/HBoxContainer15/TextEdit
@onready var vesselWeight: TextEdit =$PanelContainer/VBoxContainer/HBoxContainer16/TextEdit
@onready var dissolvedOxygen: TextEdit =$PanelContainer/VBoxContainer/HBoxContainer17/TextEdit
@onready var oxygenOffGas: TextEdit =$PanelContainer/VBoxContainer/HBoxContainer18/TextEdit
var time_passed: float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_passed += delta
	volume.text = str(2000 + 20.2 * sin(time_passed))
	penciConc.text = str(300 + 10.111 * time_passed - 4.32 * pow(time_passed, 2))
	dischargeRate.text = str(23 + 5.5 * cos(time_passed))
	sugarFeedRate.text = str(50 + 3.5 * sin(time_passed))
	oilFeedRate.text = str(10 + 0.8 * sin(time_passed))
	aerationRate.text = str(30 + 0.3 * time_passed)
	backPressure.text = str(5 + 0.1 * time_passed)
	waterDilution.text = str(100 + 2.0 * cos(time_passed))
	paaFlowRate.text = str(15 + 0.5 * time_passed)
	pH.text = str(7.0 + 0.01 * sin(time_passed))
	Temp.text = str(37.0 + 0.2 * cos(time_passed))
	acidFlowRate.text = str(1.0 + 0.05 * time_passed)
	baseFlowRate.text = str(1.0 + 0.05 * time_passed)
	coolingWater.text = str(200 + 3.0 * sin(time_passed))
	heatingWater.text = str(150 + 2.5 * cos(time_passed))
	vesselWeight.text = str(5000 + 10.0 * sin(time_passed))
	dissolvedOxygen.text = str(8.0 + 0.05 * sin(time_passed))
	oxygenOffGas.text = str(2.0 + 0.02 * time_passed)
	#pass
