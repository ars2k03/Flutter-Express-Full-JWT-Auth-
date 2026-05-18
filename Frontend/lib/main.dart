import 'package:flutter/material.dart';
import 'package:practice/screens/home_page.dart';
import 'package:practice/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  final token = prefs.getString("token");

  runApp(
    MyApp(
      token: token,
    ),
  );

}

class MyApp extends StatelessWidget {

  final String? token;

  const MyApp({
    super.key,
    required this.token,
  });

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'A R S Auth',

      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),

      ),

      home: token != null
          ? const HomePage()
          : const LoginPage(),

    );

  }

}