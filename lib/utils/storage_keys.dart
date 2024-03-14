import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import '../models/user.dart';

class StorageKeys {
  static const String USER = "user";
}

class StorageHelper {
  static User? getUser() {
    log("Fetching user");
    try {
      final box = GetStorage();

      User user = User.fromJson(json.decode(box.read(StorageKeys.USER)));

      return user;
    } catch (e) {
      return null;
    }
  }
}
