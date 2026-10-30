class_name AutoKeybinds
extends VBoxContainer

# This script makes it easy to add custom keybinds to your game.

# How to use:
# 1: Add your game's actions to the Input Map
#  - This script will get any action that does not have the "ui_" prefix used by built-in actions
# 2: Add this script to a VBoxContainer
# 3: Setup the variables below in the Inspector
# 4: Call AutoKeybinds.load_settings() at the start of your game

# Changing a keybind in game:
# 1: Click on the button for the action
# 2: Press any key or mouse button to assign a new input
#  - Press ui_cancel (Escape) to stop editing
#  - Press ui_text_delete or ui_backspace (Delete or Backspace) to remove the binding
# 3: The script will automatically save after every edit


@export var editing_text: String = "..."
@export var minimum_button_width: int = 0
@export var capitalize_action_labels: bool = false
@export_range (1, 3) var bindings_per_action: int = 1

var bind_buttons: Dictionary[StringName, Array] = {} # Array[Button]
var action_currently_editing: StringName = &""
var event_index_currently_editing: int = -1

const config_file_path: String = "user://user_keybinds.cfg"
const events_key: String = "events"


func _ready() -> void:
	spawn_controls()


func spawn_controls() -> void:
	self.set_anchors_and_offsets_preset(LayoutPreset.PRESET_FULL_RECT)
	var actions: Array[StringName] = get_user_actions()
	
	for action: StringName in actions:
		var hbox := HBoxContainer.new()
		self.add_child(hbox)
		
		var label := Label.new()
		label.text = action.capitalize() if capitalize_action_labels else String(action)
		label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		hbox.add_child(label)
		
		bind_buttons[action] = []
		for event_index: int in bindings_per_action:
			var button := Button.new()
			button.custom_minimum_size = Vector2(minimum_button_width, 0)
			button.text = get_event_text_from_input_map(action, event_index)
			button.pressed.connect(handle_button_pressed.bind(action, event_index))
			hbox.add_child(button)
			bind_buttons[action].append(button)


func handle_button_pressed(action: StringName, event_index: int) -> void:
	bind_buttons[action][event_index].text = editing_text
	action_currently_editing = action
	event_index_currently_editing = event_index


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		cancel_binding(action_currently_editing, event_index_currently_editing)
	elif event.is_action_pressed("ui_text_delete") or event.is_action_pressed("ui_text_backspace"):
		erase_binding(action_currently_editing, event_index_currently_editing)
	elif is_bindable(event):
		update_binding(action_currently_editing, event_index_currently_editing, event)


func cancel_binding(action: StringName, event_index: int) -> void:
	if action == &"" || event_index == -1: return
	
	bind_buttons[action][event_index].text = get_event_text_from_input_map(action, event_index)
	finish_editing()


func erase_binding(action: StringName, event_index: int) -> void:
	if action == &"" || event_index == -1: return
	
	var events: Array[InputEvent] = InputMap.action_get_events(action)
	InputMap.action_erase_event(action, events[event_index])
	update_action_buttons_text(action)
	save_input_map_to_config()
	finish_editing()


func update_binding(action: StringName, event_index: int, new_event: InputEvent) -> void:
	if action == &"" || event_index == -1: return
	
	var events: Array[InputEvent] = InputMap.action_get_events(action)
	if event_index >= events.size():
		InputMap.action_add_event(action, new_event)
	else:
		events[event_index] = new_event
		InputMap.action_erase_events(action)
		for event: InputEvent in events:
			InputMap.action_add_event(action, event)
	
	get_viewport().set_input_as_handled()
	update_action_buttons_text(action)
	save_input_map_to_config()
	finish_editing()


func finish_editing() -> void:
	action_currently_editing = &""
	event_index_currently_editing = -1


func update_action_buttons_text(action: StringName) -> void:
	for event_index: int in bind_buttons[action].size():
		bind_buttons[action][event_index].text = get_event_text_from_input_map(action, event_index)


func is_bindable(event: InputEvent) -> bool:
	if event.is_action("ui_text_backspace") or event.is_action("ui_text_delete"):
		return false
	
	if (event is InputEventKey or event is InputEventMouseButton):
		return true
	else:
		return false


func get_event_text_from_input_map(action: StringName, event_index: int) -> String:
	var events: Array[InputEvent] = InputMap.action_get_events(action)
	if event_index < events.size():
		return events[event_index].as_text()
	else:
		return ""


func reset_keybinds() -> void:
	InputMap.load_from_project_settings()
	var actions: Array[StringName] = get_user_actions()
	for action: StringName in actions:
		update_action_buttons_text(action)
	
	save_input_map_to_config()


static func load_settings() -> void:
	var config := ConfigFile.new()
	var load_user_settings: Error = config.load(config_file_path)
	if load_user_settings == OK: load_config_to_input_map(config)


static func load_config_to_input_map(config: ConfigFile) -> void:
	var actions: PackedStringArray = config.get_sections()
	
	for action: String in actions:
		var events: Array[InputEvent] = config.get_value(action, events_key)
		InputMap.action_erase_events(action)
		
		for event: InputEvent in events:
			InputMap.action_add_event(action, event)


static func save_input_map_to_config() -> void:
	var config := ConfigFile.new()
	var actions: Array[StringName] = get_user_actions()
	
	for action: StringName in actions:
		var events: Array[InputEvent] = InputMap.action_get_events(action)
		config.set_value(action, events_key, events)
	
	config.save(config_file_path)


static func get_user_actions() -> Array[StringName]:
	return InputMap.get_actions().filter(not_begins_with_ui_)


static func not_begins_with_ui_(value: StringName) -> bool:
	return !value.begins_with("ui_")
