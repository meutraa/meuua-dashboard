import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meuua/pages/home.dart';
import 'package:meuua/preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/user.dart';

late Preference<String> accessToken;
const clientId = 'v2ij52gemo7qxsyoqatw7vk883sk2k';

late Preference<User> profile;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  accessToken = Preference<String>(
    prefs,
    key: 'accessToken',
    serialize: (value) => value,
    deserialize: (value) => value,
  );
  profile = Preference<User>(
    prefs,
    key: 'profile',
    serialize: (value) => jsonEncode(value.toJson()),
    deserialize: (value) =>
        User.fromJson(jsonDecode(value) as Map<String, dynamic>),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final scheme = ColorScheme.fromSeed(
    seedColor: Colors.deepOrange,
    brightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meuua Dashboard',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: scheme,
        brightness: Brightness.dark,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(const Size(140, 52)),
            backgroundColor: MaterialStateProperty.all(scheme.secondary),
            foregroundColor: MaterialStateProperty.all(scheme.onSecondary),
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(scheme.primary),
          trackColor: MaterialStateProperty.all(scheme.secondary),
        ),
        iconTheme: IconThemeData(
          color: scheme.primary,
        ),
        typography: Typography.material2021(),
        appBarTheme: AppBarTheme(color: Theme.of(context).canvasColor),
      ),
      home: const HomePage(),
    );
  }
}
