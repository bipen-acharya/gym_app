import 'dart:async';

import 'package:get/get.dart';
import 'package:gym_app/controller/core_controller.dart';
import 'package:gym_app/views/dash_screen.dart';
import '../views/auth/login_screen.dart';

class SplashScreenController extends GetxController {
  final c = Get.put(CoreController());
  @override
  void onInit() {
    Timer(const Duration(seconds: 2), () async {
      if (c.isUserLoggedIn()) {
        Get.offAll(() => DashScreen());
      } else {
        Get.offAll(() => LogInScreen());
      }
      // Get.offAll(() => SubscriptionScreen());
    });
    super.onInit();
  }
}
