extends Control

var random_number: int:
	set(value):
		random_number = value
		number_label.text = str(random_number)
var score: int = 0:
	set(value):
		score = value
		score_label.text = str(score)

var min_number: int = 1
var max_number: int = 100

@onready var number_label: Label = %RandomNumber
@onready var spin_box: SpinBox = %SpinBox
@onready var score_label: Label = %Score

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 0
	start_next_round()


func start_next_round() -> void:
	spin_box.value = 0
	random_number = randi_range(min_number, max_number)


func _on_submit_button_pressed() -> void:
	var input = int(spin_box.value)

	if input == 0:
		return
	
	if input == random_number:
		score += 1

	start_next_round()
