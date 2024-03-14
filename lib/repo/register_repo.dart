import 'dart:convert';
import 'dart:developer';

import 'package:gym_app/utils/apis.dart';
import 'package:gym_app/utils/storage_keys.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class RegisterRepo {
  static Future<void> register({
    required String email,
    required String password,
    required String dob,
    required String gender,
    required String name,
    required Function(User user) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      log("pending subscription 3");
      var headers = {
        "Accept": "application/json",
      };
      var body = {
        "name": name,
        "password": password,
        "email": email,
        "gender": gender,
        "dob": dob,
        "user_role": "3",
        "password_confirmation": password,
      };
      log("pending subscription 4");

      http.Response response = await http.post(
        Uri.parse(Api.registerUrl),
        headers: headers,
        body: body,
      );

      log("pending subscription 5");
      dynamic data = jsonDecode(response.body);
      log("pending subscription 6$data");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // log(User.fromJson(data["data"].toString() as Map<String, dynamic>)
        //     as String);
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

  static Future<void> subscribe({
    required String dateTill,
    required String dateFrom,
    required String totalPayment,
    required Function() onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var token = StorageHelper.getUser()!.token;
      var id = StorageHelper.getUser()!.id;

      log("pending subscription 3$token");

      log("pending subscription 3$id");
      var headers = {
        "Accept": "application/json",
        "Content-type": "application/json",
        "Authorization": "Bearer ${token.toString()}",
      };
      var body = {
        "user_id": id.toString(),
        "valid_from": dateFrom,
        "payment_method": "khalti",
        "valid_till": dateTill,
        "total_paid_amount": totalPayment.toString(),
      };

      log("boddyyyy---------${body.toString()}");
      log("API---------${Uri.parse(Api.subscription)}");

      http.Response response = await http.post(Uri.parse(Api.subscription),
          headers: headers, body: jsonEncode(body));

      log("pending subscription 5");
      dynamic data = jsonDecode(response.body);
      log(data.toString());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // SuscriptionDetails subscription =
        //     SuscriptionDetails.fromJson(data["data"]["suscription_details"]);
        
        onSuccess();
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

// subDetail