extends Control

@export_file("*.tscn") var random_number_game_scene

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file(random_number_game_scene)
