extends Node;


const SECRET_SOUND_DIR := "res://assets/audio/secret";
var active := false;
var sounds: Array[String] = [];


func _ready() -> void:
	var dir := DirAccess.open(SECRET_SOUND_DIR);
	if dir:
		var found_sounds := Array(dir.get_files()).filter(func(x: String) -> bool:
			return x.ends_with(".wav");
		).map(func(x: String) -> String:
			return SECRET_SOUND_DIR + "/" + x;
		);

		sounds.assign(found_sounds);
		print("Found secret sounds !");
	else:
		printerr("Could not open directory " + SECRET_SOUND_DIR);



func _process(_delta: float) -> void:
	if active: apply();

#func _notification(what: int) -> void:
#	if what == NOTIFICATION_SCENE_INSTANTIATED:
#		print("Scene instantiated !");
#		if active:
#			print("Applying secret sounds to all audio nodes")
#			apply();


func _Array(packed_string_array: PackedStringArray) -> Array[String]:
	var array: Array[String] = [];
	array.assign(Array(packed_string_array));
	return array;


func activate():
	active = true;
	apply();


func apply():
	var nodes := get_audio_nodes(get_tree().get_root());
	for node in nodes:
		if !node.stream: continue;
		var current_sound_name := node.stream.get_path() as String;
		if current_sound_name.contains("secret"): continue;

		var secret_sound_name := get_secret_sound_from_sound(current_sound_name);
		if secret_sound_name in sounds:
			node.stream = ResourceLoader.load(secret_sound_name, "AudioStream");
			print("Applied secret sound to " + Array(current_sound_name.split("/")).pop_back());


func deactivate():
	active = false;
	unapply();


func get_audio_nodes(root: Node) -> Array[Node]:
	var nodes: Array[Node] = [];
	var queue: Array[Node] = [root];

	while queue:
		var current := queue.pop_front() as Node;
		for child in current.get_children():
			if child is AudioStreamPlayer || child is AudioStreamPlayer2D:
				nodes.append(child);
			queue.append(child);

	return nodes;


func get_secret_sound_from_sound(sound: String) -> String:
	var path := _Array(sound.split("/"));
	var file_name := path.pop_back() as String;
	path.append("secret");
	path.append(file_name);
	return "/".join(PackedStringArray(path));


func get_sound_from_secret_sound(secret_sound: String) -> String:
	var path := _Array(secret_sound.split("/"));
	var file_name := path.pop_back() as String;
	path.pop_back();
	path.append(file_name);
	return "/".join(PackedStringArray(path));


func unapply():
	var nodes := get_audio_nodes(get_tree().get_root());
	for node in nodes:
		if !node.stream: continue;

		var current_sound_name := node.stream.get_path() as String;
		if !current_sound_name.contains("secret"): continue;

		var sound_name := get_sound_from_secret_sound(current_sound_name);
		if !ResourceLoader.exists(sound_name, "AudioStream"): continue;

		node.stream = ResourceLoader.load(sound_name);
