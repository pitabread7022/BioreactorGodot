extends Control
@onready var resume: Button = $CenterContainer/PanelContainer/VBoxContainer/resume
@onready var mainmenu: Button = $CenterContainer/PanelContainer/VBoxContainer/mainmenu
@onready var quit: Button = $CenterContainer/PanelContainer/VBoxContainer/quit
@onready var enterRecipe: Button = $CenterContainer/PanelContainer/VBoxContainer/recipe

const set_initial_state = "res://Scenes/set_initial_state.tscn"
const lab_scene = "res://Scenes/labEnvironment.tscn"
const setting_scene = "res://Scenes/setting_window.tscn"
const about_scene = "res://Scenes/about_scene.tscn"
const main_menu = "res://main.tscn"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	resume.pressed.connect(self._resume)
	mainmenu.pressed.connect(self._mainMenu)
	quit.pressed.connect(self._quit)
	enterRecipe.pressed.connect(self.showRecipe)

func make_visible():
	self.visible = true
	$recipe.hide()
func make_invisible():
	self.visible = false

func showRecipe():
	$recipe.visible = true
	$CenterContainer.visible = false


func pause() -> void:
	make_visible()
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func unpause() -> void:
	make_invisible()
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) 

func _resume() -> void:
	unpause()

func _mainMenu() -> void:
	get_tree().change_scene_to_file(main_menu)

func _quit() -> void:
	get_tree().quit()


func _on_chat_bot_chat_bot_started():
	pass
