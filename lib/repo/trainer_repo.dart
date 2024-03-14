import 'dart:convert';
import 'dart:developer';

import 'package:gym_app/models/trainers.dart';
import 'package:gym_app/utils/apis.dart';
import 'package:gym_app/utils/storage_keys.dart';

import 'package:http/http.dart' as http;

class TrainerRepo {
  static Future<void> getTrainers({
    required Function(List<Trainers> trainers) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var token = StorageHelper.getUser()!.token;

      var headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${token.toString()}",
      };

      http.Response response = await http.get(
        Uri.parse(Api.trainers),
        headers: headers,
      );
      dynamic data = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        List<Trainers> trainer = trainerFromJson(data["data"]);
        onSuccess(trainer);
      } else {
        onError(data['message']);
      }
    } catch (e) {
      log(e.toString());
      onError("Sorry! something went wrong");
    }
  }

  static Future<void> bookTrainers({
    required String trainerid,
    required String from,
    required String to,
    required Function() onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      var token = StorageHelper.getUser()!.token;
      var id = StorageHelper.getUser()!.id;

      var headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${token.toString()}",
      };
      var body = {
        "client_id": id.toString(),
        "trainer_id": trainerid,
        "from": from,
        "to": to,
      };
      log(body.toString());
      http.Response response = await http.post(Uri.parse(Api.bookings),
          headers: headers, body: body);
      dynamic data = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        onSuccess();
      } else {
        onError(data['message']);
      }
    } catch (e) {
      log(e.toString());
      onError("Sorry! something went wrong");
    }
  }
}
