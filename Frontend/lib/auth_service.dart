import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {

  static const String baseUrl = "http://localhost:8000";

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  })
  async {

    try {

      final response = await http.post(

        Uri.parse("$baseUrl/login"),

        headers: {
          "Content-Type": "application/json",
        },

        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          "success": true,
          "data": data,
        };

      } else {

        return {
          "success": false,
          "message": data["message"],
        };

      }

    } catch (e) {

      return {
        "success": false,
        "message": "Server connection failed",
      };

    }
  }

  static Future<Map<String, dynamic>> signUp({
    required String name,
    required String email,
    required String password,
  })
  async {

    try {

      final response = await http.post(

        Uri.parse("$baseUrl/signUp"),

        headers: {
          "Content-Type": "application/json",
        },

        body: jsonEncode({
          "name" : name,
          "email": email,
          "password": password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {
          "success": true,
          "data": data,
        };

      } else {

        return {
          "success": false,
          "message": data["message"],
        };

      }

    } catch (e) {

      return {
        "success": false,
        "message": "Server connection failed",
      };

    }
  }

  static Future<Map<String, dynamic>> verifyCode({
    required String email,
    required String code,
  })
  async {

    try {

      final response = await http.post(

        Uri.parse("$baseUrl/verifycode"),

        headers: {
          "Content-Type": "application/json",
        },

        body: jsonEncode({
          "email": email,
          "code": code,
        }),
      );

      print(response.statusCode);
      print(response.body);

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {

        return {
          "success": true,
          "data": data,
        };

      } else {

        return {
          "success": false,
          "message": data["message"],
        };

      }

    } catch (e) {

      return {
        "success": false,
        "message": "Server Connection Failed",
      };

    }
  }

  static Future<Map<String, dynamic>> resendCode({
    required String email,
  })
  async {

    try {

      final response = await http.post(

        Uri.parse("$baseUrl/resend-code"),

        headers: {
          "Content-Type": "application/json",
        },

        body: jsonEncode({
          "email": email,
        }),
      );

      print(response.statusCode);
      print(response.body);

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {

        return {
          "success": true,
          "data": data,
        };

      } else {

        return {
          "success": false,
          "message": data["message"],
        };

      }

    } catch (e) {

      return {
        "success": false,
        "message": "Server Connection Failed",
      };

    }
  }

  static Future<Map<String, dynamic>> forgetPassword({
    required String email,
  })
  async {

    try {

      final response = await http.post(

        Uri.parse("$baseUrl/forget-password"),

        headers: {
          "Content-Type": "application/json",
        },

        body: jsonEncode({
          "email": email,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {

        return {
          "success": true,
          "data": data,
        };

      } else {

        return {
          "success": false,
          "message": data["message"],
        };

      }

    } catch (e) {

      return {
        "success": false,
        "message": "Server Connection Failed",
      };

    }
  }

  static Future<Map<String, dynamic>> newpassword({
    required String email,
    required String password
  })
  async {

    try {

      final response = await http.patch(

        Uri.parse("$baseUrl/resetpassword"),

        headers: {
          "Content-Type": "application/json",
        },

        body: jsonEncode({
          "email": email,
          "password" : password
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {

        return {
          "success": true,
          "data": data,
        };

      } else {

        return {
          "success": false,
          "message": data["message"],
        };

      }

    } catch (e) {

      return {
        "success": false,
        "message": "Server Connection Failed",
      };

    }
  }
}