extends Control

var random_number: int
var score: int = 0

var min_number: int = 1
var max_number: int = 100

@onready var number_label: Label = %RandomNumber
@onready var spin_box: SpinBox = %SpinBox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_next_round()


func start_next_round() -> void:
	print("Score: %d" % score)
	spin_box.value = 0
	random_number = randi_range(min_number, max_number)
	number_label.text = str(random_number)


func _on_submit_button_pressed() -> void:
	var input = int(spin_box.value)

	if input == 0:
		return
	
	if input == random_number:
		score += 1

	start_next_round()
