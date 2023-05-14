extends Node;


var active := false;
var linked_sounds := {};

var sounds: Array[AudioStream] = [
	load("res://assets/audio/secret/arrow.wav") as AudioStream,
	load("res://assets/audio/secret/button.wav") as AudioStream,
	load("res://assets/audio/secret/death.wav") as AudioStream,
	load("res://assets/audio/secret/glass_explosion.wav") as AudioStream,
	load("res://assets/audio/secret/hit.wav") as AudioStream,
	load("res://assets/audio/secret/nerf.wav") as AudioStream,
	load("res://assets/audio/secret/pigeon.wav") as AudioStream,
	load("res://assets/audio/secret/player_hit.wav") as AudioStream,
	load("res://assets/audio/secret/power.wav") as AudioStream,
	load("res://assets/audio/secret/sell_tower.wav") as AudioStream,
	load("res://assets/audio/secret/upgrade.wav") as AudioStream,
];


func _process(_delta: float) -> void:
	if active: apply();


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
		var current_sound: AudioStream = node.stream;
		if !current_sound: continue;

		var current_sound_name := current_sound.get_path() as String;
		if current_sound_name.contains("secret"): continue;

		var secret_sound := get_secret_sound_from_sound(current_sound_name);
		if !secret_sound: continue;

		linked_sounds[secret_sound] = current_sound;
		node.stream = secret_sound;


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


func get_secret_sound_from_sound(sound: String) -> AudioStream:
	var sound_name: String = Array(sound.split("/")).pop_back();
	var found_sounds := sounds.filter(func(sound: AudioStream) -> bool:
		return sound.get_path().ends_with(sound_name);
	);

	return found_sounds[0] if found_sounds else null;


func get_sound_from_secret_sound(secret_sound: AudioStream) -> AudioStream:
	return linked_sounds[secret_sound];


func unapply():
	var nodes := get_audio_nodes(get_tree().get_root());
	for node in nodes:
		var current_sound: AudioStream = node.stream;
		if !current_sound: continue;

		var current_sound_name := current_sound.get_path() as String;
		if !current_sound_name.contains("secret"): continue;

		var normal_sound := get_sound_from_secret_sound(current_sound);
		if !normal_sound: continue;

		node.stream = normal_sound;
