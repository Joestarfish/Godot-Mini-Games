extends VBoxContainer

@export var label_scene: PackedScene

func add_hint(hint: String) -> void:
	var label = label_scene.instantiate() as Label
	label.text = hint
	self.add_child(label)

func clear_nodes() -> void:
	for child in self.get_children():
		child.queue_free()
