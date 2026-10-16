class_name AttemptEntry
extends HBoxContainer


@onready var bin_attempt: HBoxContainer = %BinAttempt
@onready var match_num: Label = %MatchNum

var _guess_data: Array[int]
var _matches: int

func with_data(guess_data: Array[int], matches: int) -> AttemptEntry:
	_guess_data = guess_data
	_matches = matches
	
	return self

func _ready() -> void:
	var bin_children = bin_attempt.get_children()
	
	for i in range(bin_children.size()):
		bin_children[i].binary.text = str(_guess_data[i])
	
	match_num.text = str(_matches)
