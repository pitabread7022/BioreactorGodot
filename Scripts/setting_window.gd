extends Control
@onready var save: Button = $CenterContainer/PanelContainer/VBoxContainer/HBoxContainer7/save
@onready var menu: Button = $CenterContainer/PanelContainer/VBoxContainer/HBoxContainer7/menu
@onready var cancel: Button = $CenterContainer/PanelContainer/VBoxContainer/HBoxContainer7/cancel

signal settings_updated


const set_initial_state = "res://Scenes/set_initial_state.tscn"
const lab_scene = "res://Scenes/labEnvironment.tscn"
const setting_scene = "res://Scenes/setting_window.tscn"
const about_scene = "res://Scenes/about_scene.tscn"
const main_menu = "res://main.tscn"

func _ready():
	save.pressed.connect(self._save_newSetting)
	menu.pressed.connect(self._change_scene_mainMenu)
	cancel.pressed.connect(self._cancel_without_saving)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _save_newSetting():
	emit_signal("settings_updated")

func _change_scene_mainMenu():
	get_tree().change_scene_to_file(main_menu)

func _cancel_without_saving():
	get_tree().change_scene_to_file(main_menu)
