import 'dart:convert';
import 'dart:developer';

import 'package:gym_app/utils/apis.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class LoginRepo {
  static Future<void> login({
    required String email,
    required String password,
    required Function(User user) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var headers = {
        "Accept": "application/json",
      };
      var body = {
        "email": email,
        "password": password,
        "user_role": "3",
      };
      http.Response response = await http.post(
        Uri.parse(Api.loginUrl),
        headers: headers,
        body: body,
      );
      dynamic data = jsonDecode(response.body);
      if (data["status"] == "success") {
        User user = User.fromJson(data["data"]);
        onSuccess(user);
      } else {
        onError(data["message"]);
      }
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      onError("Sorry something went wrong");
    }
  }
}
