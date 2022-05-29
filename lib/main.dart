import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/user.dart';
import 'pages/home.dart';
import 'preference.dart';

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
  Widget build(BuildContext context) => MaterialApp(
        title: 'Meuua Dashboard',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: scheme,
          brightness: Brightness.dark,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(128, 52)),
              backgroundColor: MaterialStateProperty.all(scheme.secondary),
              foregroundColor: MaterialStateProperty.all(scheme.onSecondary),
              elevation: MaterialStateProperty.all(8),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                  side: BorderSide(
                    color: scheme.inversePrimary,
                  ),
                ),
              ),
            ),
          ),
          switchTheme: SwitchThemeData(
            thumbColor: MaterialStateProperty.all(scheme.primary),
            trackColor: MaterialStateProperty.all(scheme.secondary),
          ),
          iconTheme: IconThemeData(
            color: scheme.primary,
          ),
          checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.all(scheme.inversePrimary),
            shape: const StadiumBorder(),
          ),
          typography: Typography.material2021(),
          appBarTheme: AppBarTheme(
            foregroundColor: scheme.onBackground,
            centerTitle: true,
            // elevation: 0,
            // surfaceTintColor: scheme.sure,
            // surfaceTintColor: Colors.transparent,
            scrolledUnderElevation: 12,
            shadowColor: Colors.black,
            elevation: 12,
          ),
        ),
        home: const HomePage(),
      );
}
