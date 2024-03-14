import 'dart:convert';
import 'dart:developer';

import 'package:gym_app/models/subscription.dart';
import 'package:gym_app/utils/apis.dart';
import 'package:gym_app/utils/storage_keys.dart';
import 'package:http/http.dart' as http;

class SubRepo {
  static Future<void> subDetail({
    required Function(SuscriptionDetailUser user) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var token = StorageHelper.getUser()!.token;
      log(token.toString());
      var headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${token.toString()}",
        "Content-Type": "application/json"
      };

      log(Api.user);

      http.Response response = await http.get(
        Uri.parse(Api.user),
        headers: headers,
      );

      dynamic data = jsonDecode(response.body);
      log(data.toString());
      if (response.statusCode >= 200 && response.statusCode < 300) {
        log("-------=>>>>>sdasd>>>>${SuscriptionDetailUser.fromJson(data["data"]).name}");

        SuscriptionDetailUser user =
            SuscriptionDetailUser.fromJson(data["data"]);
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
