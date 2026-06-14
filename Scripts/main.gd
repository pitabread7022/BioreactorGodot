extends Control
class_name main_menu
@onready var start: Button = $CenterContainer/PanelContainer/VBoxContainer/start
@onready var set_init: Button = $CenterContainer/PanelContainer/VBoxContainer/set_initState
@onready var setting: Button = $CenterContainer/PanelContainer/VBoxContainer/setting
@onready var quit: Button = $CenterContainer/PanelContainer/VBoxContainer/quit
@onready var about: Button = $CenterContainer/PanelContainer/VBoxContainer/about

signal simulationStarted(initialConditions)
signal settings
signal setInitialConditions

const set_initial_state = "res://Scenes/set_initial_state.tscn"
const lab_scene = "res://Scenes/labEnvironment.tscn"
const setting_scene = "res://Scenes/setting_window.tscn"
const about_scene = "res://Scenes/about_scene.tscn"

var initial_conditions = {
"x0_S": 0,
"x0_DO2": 0,
"x0_O2": 0,
"x0_P": 0,
"x0_V": 0,
"x0_WT": 0,
"x0_pH": 6.5,
"x0_T": 238,
"x0_a0": 0,
"x0_a1": 0,
"x0_a2": 0,
"x0_a3": 0
}

# Called when the node enters the scene tree for the first time.
func _ready():
	start.pressed.connect(self._on_startbutton_pressed)
	set_init.pressed.connect(self._set_initial_conditions)
	setting.pressed.connect(self._change_settings)
	quit.pressed.connect(self._quit_simulation)
	about.pressed.connect(self._show_about_menu)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_startbutton_pressed():
	emit_signal("simulationStarted", initial_conditions)
	get_tree().change_scene_to_file(lab_scene)

func _set_initial_conditions():
	emit_signal("setInitialConditions")
	get_tree().change_scene_to_file(set_initial_state)

func _change_settings():
	emit_signal("settings")
	get_tree().change_scene_to_file(setting_scene)

func _quit_simulation():
	get_tree().quit()

func _show_about_menu():
	get_tree().change_scene_to_file(about_scene)


func _on_simulation_started(initialConditions):
	pass # Replace with function body.
