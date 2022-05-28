import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference<T> {
  final SharedPreferences _prefs;
  final String key;
  final T Function(String value) deserialize;
  final String Function(T value) serialize;
  late final ValueNotifier<T?> notifier;

  Preference(
    this._prefs, {
    required this.key,
    required this.deserialize,
    required this.serialize,
  }) {
    final initial = _prefs.getString(key);
    if (initial == null || initial.isEmpty) {
      notifier = ValueNotifier(null);
    } else {
      notifier = ValueNotifier(deserialize(initial));
    }
  }

  set val(T? value) {
    notifier.value = value;
    _prefs.setString(key, null == value ? '' : serialize(value));
  }

  T? get val => notifier.value;
}
