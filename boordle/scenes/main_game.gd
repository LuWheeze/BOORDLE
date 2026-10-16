class_name MainGame
extends Control


@onready var attempt_boxes: VBoxContainer = %AttemptBoxes

var guess_array: Array[int]
var ans_array: Array[int]
var date_dict := Time.get_date_dict_from_system()
var attempts_made := 0

static var attempt_entry := preload("res://scenes/attempt_entry.tscn")


func _ready() -> void:
	set_answer()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and guess_array.size() == 6:
		var matches := check_attempt()
		
		if matches == 6: success(matches)
		else: fail(matches)
		
	elif event.is_action_pressed("input_bin"):
		if not set_guess(event):
			print(guess_array)
	# DEBUG TEST
	elif event.is_action_pressed("debug"):
		for time_unit in date_dict:
			print("[Key, Value] : %s, %d" % [time_unit, date_dict[time_unit]])

func set_answer() -> void:
	var deci_ans := 0
	# creates large number based on current date
	for time_unit in date_dict: deci_ans += (date_dict[time_unit] * 7919)
	
	# limits number to 0-63 (allowing only 6 binary digits)
	deci_ans %= 64
	#print(deci_ans)
	
	while deci_ans > 0: # translates decimal to binary digit array
		ans_array.push_front(deci_ans % 2)
		deci_ans /= 2
	# push remaining 0s to front (if any)
	while ans_array.size() < 6: ans_array.push_front(0)
	#print(ans_array)

func set_guess(key: InputEventKey) -> bool:
	if guess_array.size() < 6: 
		var append_bin = key.as_text()
		
		guess_array.append(int(append_bin))
		return true
		
	else: return false

func check_attempt() -> int:
	print("checking...") 
	var matches := 0
	for i in range(guess_array.size()):
		if guess_array[i] == ans_array[i]: matches += 1
	
	return matches

func display_attempt(matches: int) -> void:
	var attempt = attempt_entry.instantiate().with_data(guess_array, matches)
	attempt_boxes.add_child(attempt)

func fail(matches: int) -> void:
	attempts_made += 1
	display_attempt(matches)
	
	if attempts_made == 6: 
		print("YOU SUCKK!")
		# add more end game stuff
	
	guess_array.clear()

func success(matches: int) -> void:
	attempts_made += 1
	print("success!")
	display_attempt(matches)
	
	# add more end game stuff
	guess_array.clear()
