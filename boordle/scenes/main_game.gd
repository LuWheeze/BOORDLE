extends Control

var guess_array: Array[int]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and guess_array.size() == 6:
		var attempt := check_attempt()
		if attempt: success()
		else: display_attempt()
	elif event.is_action_pressed("input_bin"):
		set_guess(event)

func set_guess(key: InputEventKey) -> void:
	if guess_array.size() < 6: guess_array.append(key.as_text())

func check_attempt() -> bool:
	print("checking...")
	# if attempt is good:
	return true
	
	# if attempt is bad: 
	return false

func display_attempt() -> void:
	pass

func fail() -> void:
	pass

func success() -> void:
	pass
