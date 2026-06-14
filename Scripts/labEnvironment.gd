extends CanvasLayer

@onready var player: CharacterBody3D = $"Basic FPS Player"
@onready var crosshair: Control = $"Basic FPS Player/Head/crosshair"
@onready var http_request: HTTPRequest = $HTTPRequest
#@onready var chatBot: Node = $"Basic FPS Player/Head/chatbotControl/chatBot"
#@onready var chatbotControl: Control = $"Basic FPS Player/Head/chatbotControl"
#@onready var HUD: Control = $HUD


const SERVER_URL = "http://127.0.0.1:5000/check_position"
#const PenSimURL = "http://ec2-54-90-147-247.compute-1.amazonaws.com:8000/docs"
var time_passed : float = 0.0
var interval : float = 0.01

func _ready():
	http_request.request_completed.connect(_on_HTTPRequest_request_completed)
	randomize_player_position()
	update_crosshair()

func _process(delta):
	handle_actions()
	time_passed += delta
	if time_passed >= interval:
		update_crosshair()
		time_passed = 0.0

func randomize_player_position():
	var player_position = player.position
	print_debug(player_position)
	player.position.x = player_position.x + randf_range(1.0, 10.0)
	player.position.z = player_position.z + randf_range(1.0, 10.0)

func update_crosshair():
	pass_to_function(player.position.x, player.position.z)
	crosshair.get_node("pythonBackend/PanelContainer/HBoxContainer/position_x").text = str(player.position.x)
	crosshair.get_node("pythonBackend/PanelContainer/HBoxContainer/position_y").text = str(player.position.z)

func pass_to_function(x: float, y: float):
	var body = JSON.new().stringify({"x": x, "y": y})
	var headers = ["Content-Type: application/json"]
	var error = http_request.request(SERVER_URL, headers, HTTPClient.METHOD_POST, body)
	if error != OK:
		push_error("An error occurred in the HTTP request.")

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	print_debug(result)
	print_debug(body)
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("HTTPRequest result unsuccessful")
		return
	var json = JSON.new()
	var parse_error = json.parse(body.get_string_from_utf8())
	if parse_error != OK:
		push_error("Failed to parse JSON response.")
		return
	var response = json.get_data()
	if response.has("result"):
		print_debug(response)
		crosshair.get_node("pythonBackend/PanelContainer/HBoxContainer/outputString").text = str(response["result"])
	else:
		push_error("Response does not contain 'result' key.")

func handle_actions() -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		$Pause.pause()
	if Input.is_action_just_pressed("mouseClickFocus"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		elif Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)



func _on_chat_bot_chat_bot_started():
	#chatBot.get_node("activePanel/MarginContainer/VBoxContainer").grab_focus()
	#HUD.release_focus()
	#chatbotControl.grab_focus()
	#chatBot.get_node("activePanel").grabfocus #this is a node while chatbotcontrol is a control
	#$"Basic FPS Player/Head/chatbotControl".grab_focus()
	pass
