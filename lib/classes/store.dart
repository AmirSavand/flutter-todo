import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Store<T> {
  /// Preference instance for lazy initialization.
  SharedPreferences? _preference;

  /// List of in-memory items for lazy initialization.
  List<T>? _items;

  /// List of initial items in case storage is setup first time.
  List<T>? initialItems;

  /// Lazy get the preference instance.
  Future<SharedPreferences> get preference async {
    return _preference ??= await SharedPreferences.getInstance();
  }

  /// Lazy get the items.
  Future<List<T>> get items async {
    return _items ??= await _load();
  }

  /// Load items from storage and return them.
  Future<List<T>> _load() async {
    final prefs = await preference;
    List<String> list;
    try {
      List<String>? listRaw = prefs.getStringList(key);
      if (listRaw == null) {
        return Future.value(initialItems);
      }
      list = prefs.getStringList(key) ?? [];
    } catch (error) {
      if (initialItems != null) {
        return Future.value(initialItems);
      }
      list = [];
    }
    return list.map((String item) => fromJson(jsonDecode(item))).toList();
  }

  /// Save a list of items to shared preferences.
  Future<void> save() async {
    final prefs = await preference;
    final list = await items;
    await prefs.setStringList(
      key,
      list.map((T item) => jsonEncode(toJson(item))).toList(),
    );
  }

  /// Add a task to the list.
  Future<void> add(T task) async {
    if (_items == null) {
      return Future.value();
    }
    _items!.insert(0, task);
    await save();
  }

  /// Remove an item from the list.
  /// Returns true if item was successfully found and removed.
  Future<bool> remove(T item) async {
    List<T> list = await items;
    int index = list.indexOf(item);
    if (index != -1) {
      list.removeAt(index);
      await save();
      return Future.value(true);
    }
    return Future.value(false);
  }

  /// Clear all stored data.
  Future<void> clear() async {
    final prefs = await preference;
    await prefs.remove(key);
  }

  /// Storage key to save items.
  final String key;

  /// Method to convert item to json for saving.
  final Map<String, dynamic> Function(T item) toJson;

  /// Method to convert json to item for loading.
  final T Function(Map<String, dynamic> item) fromJson;

  Store({
    required this.key,
    required this.toJson,
    required this.fromJson,
    this.initialItems,
  });
}
