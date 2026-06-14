extends Control
@onready var main_menu: Button = $CenterContainer/PanelContainer/VBoxContainer/Button

const set_initial_state = "res://Scenes/set_initial_state.tscn"
const lab_scene = "res://Scenes/labEnvironment.tscn"
const setting_scene = "res://Scenes/setting_window.tscn"
const about_scene = "res://Scenes/about_scene.tscn"
const main_scene = "res://main.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	main_menu.pressed.connect(self._main_menu_triggered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _main_menu_triggered():
	get_tree().change_scene_to_file(main_scene)
