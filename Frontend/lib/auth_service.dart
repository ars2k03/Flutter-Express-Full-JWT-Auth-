import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  static const String baseUrl = "http://172.21.100.59:8000";

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

  static Future<Map<String, dynamic>> getProfile()
  async {
    try {

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");

      final response = await http.get(
        Uri.parse("$baseUrl/profile"),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {

        return {
          "success": true,
          "data": data,
        };

      } else if (response.statusCode == 401) {

        final isRefreshSuccess = await refreshToken();
        if (isRefreshSuccess) {
          return await getProfile();
        }
        return {
          "success": false,
          "message": "Session expired",
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
        "message": e.toString(),
      };

    }
  }

  static Future<bool> refreshToken()
  async {

    try {

      final prefs = await SharedPreferences.getInstance();

      final refreshToken = prefs.getString("refreshToken");

      final response = await http.post(

        Uri.parse("$baseUrl/refresh"),

        headers: {
          "Content-Type": "application/json",
        },

        body: jsonEncode({
          "refreshToken": refreshToken,
        }),

      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {

        final newAccessToken = data["accessToken"];

        await prefs.setString(
          "token",
          newAccessToken,
        );

        return true;

      }

      return false;

    } catch (e) {

      return false;

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

  static Future<Map<String, dynamic>> loginWithGoogle()
  async {
    try {

      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
        serverClientId: '672754214543-0uuonc4nil2vbahj29lgrsq66tl0hifl.apps.googleusercontent.com'
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return {
          "success": false,
          "message": "Google sign in cancelled",
        };
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        return {
          "success": false,
          "message": "Failed to get Google token",
        };
      }


      final response = await http.post(
        Uri.parse("$baseUrl/google-login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "idToken": idToken,
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
        "message": e.toString(),
      };
    }
  }
}