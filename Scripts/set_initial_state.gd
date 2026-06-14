extends Control
@onready var changeState: Button = $CenterContainer/PanelContainer/VBoxContainer2/HBoxContainer/changeState
@onready var mainMenu: Button = $CenterContainer/PanelContainer/VBoxContainer2/HBoxContainer/mainMenu

@onready var x0_mux: TextEdit = $CenterContainer/PanelContainer/ScrollContainer/VBoxContainer/Label/x0_mux
@onready var x0_mup: TextEdit = $CenterContainer/PanelContainer/ScrollContainer/VBoxContainer/Label2/x0_mup 
@onready var h: TextEdit = $CenterContainer/PanelContainer/ScrollContainer/VBoxContainer/Label3/h
@onready var x0_S: TextEdit = $CenterContainer/PanelContainer/ScrollContainer/VBoxContainer/Label4/x0_S 
@onready var x0_DO2: TextEdit = $CenterContainer/PanelContainer/ScrollContainer/VBoxContainer/Label5/x0_DO2 
@onready var x0_X: TextEdit = $CenterContainer/PanelContainer/ScrollContainer/VBoxContainer/Label6/x0_X 
@onready var x0_P: TextEdit = $CenterContainer/PanelContainer/ScrollContainer/VBoxContainer/Label7/x0_P 
@onready var x0_V: TextEdit = $CenterContainer/PanelContainer/ScrollContainer/VBoxContainer/Label8/x0_V 
@onready var x0_Wt: TextEdit = $CenterContainer/PanelContainer/ScrollContainer/VBoxContainer/Label9/x0_Wt 
@onready var x0_CO2outgas: TextEdit = $CenterContainer/PanelContainer/ScrollContainer/VBoxContainer/Label10/x0_CO2outgas 
@onready var x0_O2: TextEdit = $CenterContainer/PanelContainer/ScrollContainer/VBoxContainer/Label11/x0_O2 
@onready var x0_pH: TextEdit = $CenterContainer/PanelContainer/ScrollContainer/VBoxContainer/Label12/x0_pH 
@onready var x0_T: TextEdit = $CenterContainer/PanelContainer/ScrollContainer/VBoxContainer/Label13/x0_T 
@onready var x0_Culture_age: TextEdit = $CenterContainer/PanelContainer/ScrollContainer/VBoxContainer/Label14/x0_Culture_age 
@onready var x0_PAA: TextEdit = $CenterContainer/PanelContainer/ScrollContainer/VBoxContainer/Label15/x0_PAA 
@onready var x0_NH3: TextEdit = $CenterContainer/PanelContainer/ScrollContainer/VBoxContainer/Label16/x0_NH3 
@onready var Ctrl_flags_T_sp: TextEdit = $CenterContainer/PanelContainer/ScrollContainer/VBoxContainer/Label17/Ctrl_flags_T_sp 
@onready var Ctrl_flags_pH_sp: TextEdit = $CenterContainer/PanelContainer/ScrollContainer/VBoxContainer/Label18/Ctrl_flags_pH_sp 
@onready var x0_a0: TextEdit = $CenterContainer/PanelContainer/ScrollContainer/VBoxContainer/Label19/x0_a0



signal customInitialStateisSet(initStateVector)


const set_initial_state = "res://Scenes/set_initial_state.tscn"
const lab_scene = "res://Scenes/labEnvironment.tscn"
const setting_scene = "res://Scenes/setting_window.tscn"
const about_scene = "res://Scenes/about_scene.tscn"
const main_menu = "res://main.tscn"

func _ready():
	changeState.pressed.connect(self._change_initial_state)
	mainMenu.pressed.connect(self._change_scene_mainMenu)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _change_initial_state():
	var initial_state = {
		"x0_mux": float(x0_mux.text),
		"x0_mup": float(x0_mup.text),
		"h": float(h.text),
		"x0_S": float(x0_S.text),
		"x0_DO2": float(x0_DO2.text),
		"x0_X": float(x0_X.text),
		"x0_P": float(x0_P.text),
		"x0_V": float(x0_V.text),
		"x0_Wt": float(x0_Wt.text),
		"x0_CO2outgas": float(x0_CO2outgas.text),
		"x0_O2": float(x0_O2.text),
		"x0_pH": float(x0_pH.text),
		"x0_T": float(x0_T.text),
		"x0_Culture_age": float(x0_Culture_age.text),
		"x0_PAA": float(x0_PAA.text),
		"x0_NH3": float(x0_NH3.text),
		"Ctrl_flags_T_sp": float(Ctrl_flags_T_sp.text),
		"Ctrl_flags_pH_sp": float(Ctrl_flags_pH_sp.text),
		"x0_a0": float(x0_a0.text),
	}
	emit_signal("customInitialStateisSet", initial_state)

func _change_scene_mainMenu():
	get_tree().change_scene_to_file(main_menu)
