extends Node
#class_name chatbot
@onready var httpRequestChatGPT : HTTPRequest = $HTTPRequest
@onready var inactiveContainer: Panel = $inactivePanel#$CenterContainer/inactivePanel
@onready var activePanel: Control = $activePanel
@onready var inputText: TextEdit = $activePanel/MarginContainer/VBoxContainer/inputText
@onready var outputText: TextEdit = $activePanel/MarginContainer/VBoxContainer/outputText
@onready var run: Button = $activePanel/MarginContainer/VBoxContainer/run
@onready var reset: Button = $activePanel/MarginContainer/VBoxContainer/reset
@onready var hide: Button = $activePanel/MarginContainer/VBoxContainer/hide

signal takePlayerTo(objectName)
signal chatBotStarted
const chatURL = "http://ec2-54-90-147-247.compute-1.amazonaws.com:8000"
var thread_id = ""

func _ready():
	activePanel.hide()
	#$activePanel/MarginContainer/VBoxContainer.focus_mode = Control.FOCUS_ALL
	run.pressed.connect(self._on_run_pressed)
	reset.pressed.connect(self._on_reset_pressed)
	hide.pressed.connect(self._on_hide_pressed)
	inputText.text = "What is bioreactor"

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		enableChatbot()
	if Input.is_action_just_pressed("passGPT"):
		_on_run_pressed()

#func wait(duration: float):
	#var timer = Timer.new()
	#add_child(timer)
	#timer.wait_time = duration
	#timer.one_shot = true
	#timer.start()
	#await timer.timeout
	#remove_child(timer)
	#timer.queue_free()

func enableChatbot():
	#get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	inactiveContainer.hide()
	activePanel.show()
	inputText.grab_focus()
	print_debug("chatstart")
	emit_signal("chatBotStarted")
	httpRequestChatGPT.request_completed.connect(_on_start_chat_completed)
	httpRequestChatGPT.request(chatURL + "/start_chat", [], HTTPClient.METHOD_GET)
	await get_tree().create_timer(10).timeout
	_on_run_pressed()

func _on_run_pressed():
	if thread_id == "":
		outputText.text = "Error: No thread ID. Start chat first."
		return
	var message = inputText.text
	#message = "bioreactor digital twin in Godot4"
	var query = { "thread_id": thread_id, "message": message }
	var headers = ["Content-Type: application/json"]
	httpRequestChatGPT.request_completed.connect(_on_chat_completed)
	query = JSON.new().stringify(query)
	httpRequestChatGPT.request(chatURL + "/chat", headers, HTTPClient.METHOD_POST, query)

func _on_reset_pressed():
	inputText.text = ""
	outputText.text = ""
	enableChatbot()

func _on_hide_pressed():
	activePanel.hide()
	inactiveContainer.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#get_tree().paused = false

func _on_start_chat_completed(result, response_code, headers, body):
	httpRequestChatGPT.request_completed.disconnect(_on_start_chat_completed)
	var json = JSON.new()
	var parse_result = json.parse(body.get_string_from_utf8())

	if parse_result == OK:
		var response = json.get_data()
		if response_code == 200:
			if "thread_id" in response:
				thread_id = response["thread_id"]
				outputText.text = "Chat started. Thread ID: " + thread_id
				print_debug(thread_id)
			else:
				outputText.text = "Error: thread_id not found in response."
		else:
			outputText.text = "Request failed with response code " + str(response_code)
	else:
		outputText.text = "Error parsing response: " + str(parse_result)

func _on_chat_completed(result, response_code, headers, body):
	#httpRequestChatGPT.request_completed.disconnect(_on_chat_completed)
	var json = JSON.new()
	var parse_result = json.parse(body.get_string_from_utf8())
	if parse_result == OK:
		var response = json.get_data()
		#print_debug("chatResponded: " + response)
		if response_code == 200:
			if "response" in response:
				outputText.text = str(response["response"])
			else:
				outputText.text = "Error: response not found in response."
		else:
			outputText.text = "Request failed with response code " + str(response_code)
	else:
		outputText.text = "Error parsing response: " + str(parse_result)


func _on_take_player_takeplayer(objectName):
	emit_signal("takePlayerTo", objectName)





#_____________________________________________________________
#extends Node
#
#@onready var httpRequestChatGPT : HTTPRequest = $HTTPRequest
#@onready var inactiveContainer: Panel = $CenterContainer/inactivePanel
#@onready var activePanel: Control = $activePanel
#@onready var inputText: TextEdit = $activePanel/MarginContainer/VBoxContainer/inputText
#@onready var outputText: TextEdit = $activePanel/MarginContainer/VBoxContainer/outputText
#@onready var run: Button = $activePanel/MarginContainer/VBoxContainer/run
#@onready var reset: Button = $activePanel/MarginContainer/VBoxContainer/reset
#@onready var hide: Button = $activePanel/MarginContainer/VBoxContainer/hide
#
#signal chatBotStarted
#const chatURL = "http://ec2-54-90-147-247.compute-1.amazonaws.com:8000"
#var thread_id = ""
### GET methods are: /start_chat(No parameters)Responses CodeDescription200 SuccessfulResponse "string" value 
### GET response- {"thread_id":"string"}
### POST methods are: /chat{"thread_id":"string", "message":"string"}
### POST method response - code200 successfullResponse "String" - returns reply of chatGPT save in outputText
### POST error code 422{"detail": [{"loc": ["string",0],"msg": "string","type": "string"}]}
#
#func _ready():
	#activePanel.hide()
	#run.pressed.connect(_on_run_pressed)
	#reset.pressed.connect(_on_reset_pressed)
	#hide.pressed.connect(_on_hide_pressed)
	##defaultInputText
	#inputText.text = "What is Godot4"
#
#func _process(delta):
	#if Input.is_action_just_pressed("interact"):
		#enableChatbot()
#
#func wait(duration: float):
	#var timer = Timer.new()
	#add_child(timer)
	#timer.wait_time = duration
	#timer.one_shot = true
	#timer.start()
	#await timer.timeout
	#remove_child(timer)
	#timer.queue_free()
#
#
#func enableChatbot():
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#inactiveContainer.hide()
	#activePanel.show()
	##get_node("activePanel").grab_focus()
	#print_debug("chatstart")
	#emit_signal("chatBotStarted")
	## Make GET request to start chat and get thread_id
	#httpRequestChatGPT.request_completed.connect(_on_start_chat_completed)
	#httpRequestChatGPT.request(chatURL + "/start_chat", [], HTTPClient.METHOD_GET)
	#await wait(1.0)
	#_on_run_pressed()
	#
#
#func _on_run_pressed():
	#var message = inputText.text
	#var query = { "thread_id": thread_id, "message": message }
	#var headers = ["Content-Type: application/json"]
	#httpRequestChatGPT.request_completed.connect(_on_chat_completed)
	#query = JSON.new().stringify(query)
	#httpRequestChatGPT.request(chatURL + "/chat", headers, HTTPClient.METHOD_POST, query)
#
#func _on_reset_pressed():
	#inputText.text = ""
	#outputText.text = ""
#
#func _on_hide_pressed():
	#activePanel.hide()
	#inactiveContainer.show()
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
#
#func _on_start_chat_completed(result, response_code, headers, body):
	#httpRequestChatGPT.request_completed.disconnect(_on_start_chat_completed)
	#var json = JSON.new()
	#var parse_result = json.parse(body.get_string_from_utf8())
	#
	#if parse_result == OK:
		#var response = json.get_data()
		#if response_code == 200:
			#if "thread_id" in response:
				#thread_id = response["thread_id"] 
				#outputText.text = "Chat started. Thread ID: " + thread_id
			#else:
				#outputText.text = "Error: thread_id not found in response."
		#else:
			#outputText.text = "Request failed with response code " + str(response_code)
	#else:
		#outputText.text = "Error parsing response: " + str(parse_result)
#
#func _on_chat_completed(result, response_code, headers, body):
	#httpRequestChatGPT.request_completed.disconnect(_on_chat_completed)
	#var json = JSON.new()
	#var parse_result = json.parse(body.get_string_from_utf8())
	#
	#if parse_result == OK:
		#var response = json.get_data()
		#if response_code == 200:
			#if "response" in response:
				#outputText.text = response["response"]
			#else:
				#outputText.text = "Error: response not found in response."
		#else:
			#outputText.text = "Request failed with response code " + str(response_code)
	#else:
		#outputText.text = "Error parsing response: " + str(parse_result)







#________________________________________________________________________________
#extends Node
#
#@onready var httpRequestChatGPT : HTTPRequest = $HTTPRequest
#@onready var inactiveContainer: Panel = $CenterContainer/inactivePanel
#@onready var activePanel: Control = $activePanel
#@onready var inputText: TextEdit = $activePanel/MarginContainer/VBoxContainer/inputText
#@onready var outputText: TextEdit = $activePanel/MarginContainer/VBoxContainer/outputText
#@onready var run: Button = $activePanel/MarginContainer/VBoxContainer/run
#@onready var reset: Button = $activePanel/MarginContainer/VBoxContainer/reset
#@onready var hide: Button = $activePanel/MarginContainer/VBoxContainer/hide
#
#const chatURL = "http://ec2-54-90-147-247.compute-1.amazonaws.com:8000"
## GET methods are: /start_chat(No parameters)Responses CodeDescription200 SuccessfulResponse "string" value 
## GET response- {"thread_id":"string"}
## POST methods are: /chat{"thread_id":"string", "message":"string"}
## POST method response - code200 successfullResponse "String" - returns reply of chatGPT save in outputText
## POST error code 422{"detail": [{"loc": ["string",0],"msg": "string","type": "string"}]}
#func _ready():
	#activePanel.hide()
	#httpRequestChatGPT.request_completed.connect(_on_HTTPRequest_request_completed)
	#run.pressed.connect(self._on_run_pressed)
	#reset.pressed.connect(self._on_reset_pressed)
	#hide.pressed.connect(self._on_hide_pressed)
#
#func _process(delta):
	#if Input.is_action_just_pressed("interact"):
		#enableChatbot()
#
#func enableChatbot():
	#inactiveContainer.hide()
	#activePanel.show()
	## get the threadID from the GET method
	#print_debug("chatstart")
#
#func _on_run_pressed():
	#var message = inputText.text
	#var query = { "query": message }
	#var headers = ["Content-Type: application/json"]
	#httpRequestChatGPT.request(chatURL, headers, HTTPClient.METHOD_POST, query.to_json())
#
#func _on_reset_pressed():
	#inputText.text = ""
	#outputText.text = ""
#
#func _on_hide_pressed():
	#activePanel.hide()
	#inactiveContainer.show()
#
#func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	#if response_code == 200:
		#var json = JSON.new()
		#var response = json.parse(body.get_string_from_utf8()) #json.parse(body.get_string_from_utf8())
		#if response.error == OK:
			#outputText.text = response.result["response"]
		#else:
			#outputText.text = "Error: " + str(response.error)
	#else:
		#outputText.text = "Request failed with response code " + str(response_code)


#__________________________________________________________
#extends Node
#@onready var httpRequestChatGPT : HTTPRequest = $HTTPRequest
#@onready var inactiveContainer: Panel = $CenterContainer/inactivePanel
#@onready var activePanel: Control = $activePanel
#@onready var inputText: TextEdit = $activePanel/MarginContainer/VBoxContainer/inputText
#@onready var outputText: TextEdit = $activePanel/MarginContainer/VBoxContainer/inputText
#@onready var run: Button = $activePanel/MarginContainer/VBoxContainer/run
#@onready var reset: Button = $activePanel/MarginContainer/VBoxContainer/reset
#@onready var hide: Button = $activePanel/MarginContainer/VBoxContainer/hide
#
#const chatURL = "http://ec2-54-90-147-247.compute-1.amazonaws.com:8000/docs"
#
#func _ready():
	#activePanel.hide()
	#httpRequestChatGPT.request_completed.connect(_on_HTTPRequest_request_completed)
#
#func _process(delta):
	#if Input.is_action_just_pressed("interact"):
		#enableChatbot()
#
#func enableChatbot():
	##write this function
#
#func _on_HTTPRequest_request_completed():
	##write this function 
#




#var client = WebSocketPeer.new()
#var URL = "ws://localhost:5000"
## Called when the node enters the scene tree for the first time.
#
#func _ready():
	##client.connect("data_received", self, "data_received")
	#var err = client.connect_to_url(URL)
	#if err != OK:
		#set_process(false)
		#print("Unable to Connect!!")
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#client.poll()
	#var state = client.get_ready_state()
	#if state == WebSocketPeer.STATE_OPEN:
		#while client.get_available_packet_count():
			#print("Packet: ", client.get_packet())
	#elif state == WebSocketPeer.STATE_CLOSING:
		#pass
	#elif state == WebSocketPeer.STATE_CLOSED:
		#var code = client.get_close_code()
		#var reason = client.get_close_reason()
		#print("WebSocket closed with code: %d, reason %s. Clean: %s" % [code, reason, code != -1])
		#set_process(false) # Stop processing.
#
#
#func data_received():
	#var payload = client.get_peeer()

