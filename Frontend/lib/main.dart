import 'package:flutter/material.dart';
import 'package:practice/screens/home_page.dart';
import 'package:practice/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_service.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  final token = prefs.getString("token");

  runApp(
    MyApp(token: token),
  );

}

class MyApp extends StatefulWidget {

  final String? token;

  const MyApp({
    super.key,
    required this.token,
  });

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  late String name;
  late String email;
  late String role;
  late String picture;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    if (widget.token != null) {
      loadProfile();
    } else {

      setState(() {
        isLoading = false;
      });

    }

  }

  Future<void> loadProfile() async {

    final response = await AuthService.getProfile();

    if (response["success"] == true) {

      final user = response["data"]["user"];

      setState(() {
        name = user["name"] ?? "Default";
        email = user["email"] ?? "Default";
        role = user["role"] ?? "user";
        picture = user["picture"] ?? "";

        isLoading = false;

      });

    } else {

      setState(() {
        isLoading = false;
      });

    }

  }

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

      home: isLoading

          ? const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      )

          : widget.token != null

          ? HomePage(
        name: name,
        email: email,
        role: role,
        picture: picture,
      )

          : const LoginPage(),

    );

  }

}