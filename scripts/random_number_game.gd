extends Control

const MIN_NUMBER := 1
const MAX_NUMBER := 100

@export var max_tries := 3
@export_file("*.tscn") var main_menu_scene
@export_file("*.ogg", "*.wav") var sfx_right_answer
@export_file("*.ogg", "*.wav") var sfx_wrong_answer
@export_file("*.ogg", "*.wav") var sfx_round_lost

var random_number: int:
	set(value):
		random_number = min(MAX_NUMBER, max(MIN_NUMBER, value))
		number_label.text = "?"
		print("Random number is %d" % random_number)
var score := 0:
	set(value):
		score = value
		score_label.text = str(score)
var tries: int:
	set(value):
		tries = min(max_tries, max(0, value))
		tries_label.text = str(tries)

@onready var number_label: Label = %RandomNumber
@onready var score_label: Label = %Score
@onready var tries_label: Label = %Tries
@onready var spin_box: SpinBox = %SpinBox
@onready var hints_v_box_container := %HintsVBoxContainer
@onready var next_round_timer: Timer = %NextRoundTimer
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var submit_button: Button = %SubmitButton
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = 0

	# Change the max values of the spin box here to make sure it still works if either the variables OR the spinbox min/max were changed in the editor
	spin_box.min_value = MIN_NUMBER - 1
	spin_box.max_value = MAX_NUMBER
	start_next_round()

func _process(delta: float) -> void:
	progress_bar.value = 100 - (next_round_timer.wait_time - next_round_timer.time_left) / next_round_timer.wait_time * 100

# This function wait for a timer to end before starting the next round. It allows the user to view the answer before we clear it.
func queue_next_round() -> void:
	number_label.text = str(random_number)
	next_round_timer.start()
	progress_bar.visible = true
	submit_button.disabled = true
	spin_box.editable = false

func start_next_round() -> void:
	progress_bar.visible = false
	submit_button.disabled = false
	spin_box.editable = true
	hints_v_box_container.clear_nodes()
	spin_box.value = 0
	tries = max_tries
	random_number = randi_range(MIN_NUMBER, MAX_NUMBER)

func handle_right_answer() -> void:
	score += 1
	hints_v_box_container.add_hint("The answer was %d\nGood job!" % random_number)
	audio_stream_player.stream = load(sfx_right_answer)
	audio_stream_player.play()
	queue_next_round()

func handle_wrong_answer(given_answer: int) -> void:
	hints_v_box_container.add_hint("%s than %d" % ["Lower" if random_number - given_answer < 0 else "Higher", given_answer])
	audio_stream_player.stream = load(sfx_wrong_answer)
	audio_stream_player.play()

func handle_round_lost() -> void:
	hints_v_box_container.add_hint("The answer was %d" % random_number)
	audio_stream_player.stream = load(sfx_round_lost)
	audio_stream_player.play()
	queue_next_round()

func _on_submit_button_pressed() -> void:
	var input = int(spin_box.value)
	spin_box.value = 0

	if input == 0:
		return
	
	if input == random_number:
		handle_right_answer()
		return

	tries -= 1
	if tries <= 0:
		handle_round_lost()
		return

	handle_wrong_answer(input)


func _on_next_round_timer_timeout() -> void:
	start_next_round()

func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file(main_menu_scene)
