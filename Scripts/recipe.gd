extends Control

const PenSimURL = "http://ec2-54-90-147-247.compute-1.amazonaws.com"

@onready var FS : TextEdit = $CenterContainer/VBoxContainer/HBoxContainer/TextEdit
@onready var FOIL : TextEdit = $CenterContainer/VBoxContainer/HBoxContainer2/TextEdit 
@onready var FG : TextEdit = $CenterContainer/VBoxContainer/HBoxContainer3/TextEdit 
@onready var PRES : TextEdit = $CenterContainer/VBoxContainer/HBoxContainer4/TextEdit 
@onready var DISCHARGE : TextEdit = $CenterContainer/VBoxContainer/HBoxContainer5/TextEdit 
@onready var WATER : TextEdit = $CenterContainer/VBoxContainer/HBoxContainer6/TextEdit 
@onready var PAA : TextEdit = $CenterContainer/VBoxContainer/HBoxContainer7/TextEdit

@onready var calculate : Button = $CenterContainer/VBoxContainer/HBoxContainer8/Button 
@onready var showInSim : Button = $CenterContainer/VBoxContainer/HBoxContainer8/Button2 
@onready var cancel : Button = $CenterContainer/VBoxContainer/HBoxContainer8/Button3

@onready var http_request: HTTPRequest = $HTTPRequest
# Called when the node enters the scene tree for the first time.
const set_initial_state = "res://Scenes/set_initial_state.tscn"
const lab_scene = "res://Scenes/labEnvironment.tscn"
const setting_scene = "res://Scenes/setting_window.tscn"
const about_scene = "res://Scenes/about_scene.tscn"
const main_menu = "res://main.tscn"
const pause = "res://Scenes/pause.tscn"

signal recipeReceived(recipeDict)

func _ready():
	http_request.request_completed.connect(self._on_HTTPRequest_request_completed)
	calculate.pressed.connect(self._calculate)
	showInSim.pressed.connect(self._showInSim)
	cancel.pressed.connect(self._cancel)

func _process(delta):
	pass

func _calculate():
	var recipeDict: Dictionary = {
		"FS": parse_text_input(FS.text),
		"FOIL": parse_text_input(FOIL.text),
		"FG": parse_text_input(FG.text),
		"PRES": parse_text_input(PRES.text),
		"DISCHARGE": parse_text_input(DISCHARGE.text),
		"WATER": parse_text_input(WATER.text),
		"PAA": parse_text_input(PAA.text)
	}
	var jsonRecipeDict = JSON.stringify(recipeDict)
	var headers = ["Content-Type: application/json"]
	
	var error = http_request.request(PenSimURL+ "/runsim", headers, HTTPClient.METHOD_POST, jsonRecipeDict)
	if error != OK:
		push_error("An error occurred in the HTTP request.[1]")
		print_debug(error)
	else:
		emit_signal("recipeReceived", recipeDict)

#func parse_text_input(text):
	#var parsed = []
	#var lines = text.split("\n")
	#for line in lines:
		#var parts = line.split(",")
		#if parts.size() == 2:
			#parsed.append({parts[0]: int(parts[1])})
	#return parsed

func parse_text_input(text: String) -> Array:
	var parsed = []
	var lines = text.strip_edges().split("\n")
	
	for line in lines:
		var parts = line.strip_edges().split(":")
		
		if parts.size() == 2:
			var key = parts[0].strip_edges().replace("\"", "")
			var value = parts[1].strip_edges().replace(",", "").to_int()
			parsed.append({key: value})
	return parsed

#____________________________________________________________________________________
#LAST WORKED ON 05/06/2024 @mubashshirUddin 7394966651
#____________________________________________________________________________________
#
func _showInSim(delta):
	#var animator: AnimationPlayer = animator.new()
	#http_request.disconnect()
	#var time: float = 0.0
	#http_request.request_completed.connect(self._on_Request_HTTP_Timestamp)
	#var headers = ["Content-Type: application/json"]
	#var error = http_request.request(PenSimURL+ "/timestamp", headers, HTTPClient.METHOD_POST, jsonRecipeDict)
	#pass
	pass


func _cancel():
	$"../CenterContainer".visible = true
	self.visible = false

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	if response_code != 200:
		push_error("HTTP request failed with response code: " + str(response_code))
		return
	
	var json = JSON.new()
	var parse_error = json.parse(body.get_string_from_utf8())
	if parse_error != OK:
		push_error("Failed to parse JSON response.")
		return
	
	var response = json.get_data()
	if response.has("message"):
		print("Simulation completed: " + response["message"])
	else:
		push_error("Response does not contain 'message' key.")

func _on_Request_HTTP_Timestamp(result, response_code, headers, body):
	pass


func _on_recipeReceived(recipeDict):
	pass # Handle the received recipe dictionary if needed.







#___________________________________________________________________
#extends Control
#
#const PenSimURL = "http://ec2-54-90-147-247.compute-1.amazonaws.com:8000/docs"
#
#@onready var FS : TextEdit = $CenterContainer/VBoxContainer/HBoxContainer/TextEdit
#@onready var FOIL : TextEdit = $CenterContainer/VBoxContainer/HBoxContainer2/TextEdit 
#@onready var FG : TextEdit = $CenterContainer/VBoxContainer/HBoxContainer3/TextEdit 
#@onready var PRES : TextEdit = $CenterContainer/VBoxContainer/HBoxContainer4/TextEdit 
#@onready var DISCHARGE : TextEdit = $CenterContainer/VBoxContainer/HBoxContainer5/TextEdit 
#@onready var WATER : TextEdit = $CenterContainer/VBoxContainer/HBoxContainer6/TextEdit 
#@onready var PAA : TextEdit = $CenterContainer/VBoxContainer/HBoxContainer7/TextEdit
#
#@onready var calculate : Button = $CenterContainer/VBoxContainer/HBoxContainer8/Button 
#@onready var showInSim : Button = $CenterContainer/VBoxContainer/HBoxContainer8/Button2 
#@onready var cancel : Button = $CenterContainer/VBoxContainer/HBoxContainer8/Button3
#
#@onready var http_request: HTTPRequest = $HTTPRequest
## Called when the node enters the scene tree for the first time.
#const set_initial_state = "res://Scenes/set_initial_state.tscn"
#const lab_scene = "res://Scenes/labEnvironment.tscn"
#const setting_scene = "res://Scenes/setting_window.tscn"
#const about_scene = "res://Scenes/about_scene.tscn"
#const main_menu = "res://main.tscn"
#const pause = "res://Scenes/pause.tscn"
#
#signal recipeRecieved(recipeDict)
#
#func _ready():
	#http_request.request_completed.connect(_on_HTTPRequest_request_completed)
	#calculate.pressed.connect(self._calculate)
	#showInSim.pressed.connect(self._showInSim)
	#cancel.pressed.connect(self._cancel)
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
#
#func _calculate():
	#var FS = JSON.new().FS.text
	#var FOIL = JSON.new().FOIL.text
	#var FG = JSON.new().FG.text
	#var PRES = JSON.new().PRES.text
	#var DISCHARGE = JSON.new().DISCHARGE.text
	#var WATER = JSON.new().WATER.text
	#var PAA = JSON.new().PAA.text
	#
	#var recipeDict: Dictionary = {
		#"FS": FS,
		#"FOIL": FOIL,
		#"FG": FG,
		#"PRES": PRES,
		#"DISCHARGE": DISCHARGE,
		#"WATER": WATER,
		#"PAA": PAA
		#}
	#var stringRecipeDict = JSON.stringify(recipeDict)
	#var error = http_request.request(PenSimURL, recipeDict.headers, HTTPClient.METHOD_POST, stringRecipeDict)
	#if error != OK:
		#push_error("An error occurred in the HTTP request.")
	#emit_signal("recipeRecieved", recipeDict)
	#
	#
#func _showInSim():
	#get_tree().change_scene_to_file(lab_scene)
	#$Pause.unpasue()
#
#func _cancel():
	#get_tree().change_scene_to_file(pause)
#
#func _on_recipe_recieved(recipeDict):
	#pass # Replace with function body.
#
#
#func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	#if result != HTTPRequest.RESULT_SUCCESS:
		#push_error("HTTPRequest result unsuccessful")
		#return
	#var json = JSON.new()
	#var parse_error = json.parse(body.get_string_from_utf8())
	#if parse_error != OK:
		#push_error("Failed to parse JSON response.")
		#return
	#var response = json.get_data()
	#if response.has("message"):
		#print_debug(response)
		#
	#else:
		#push_error("Response does not contain 'message' key.")
	#
