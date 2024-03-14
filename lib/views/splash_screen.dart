import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final c = Get.put(SplashScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              child: Image(
                image: const AssetImage("assets/common/logo.gif"),
                height: Get.height / 3,
                width: Get.width / 2,
              ),
            ),
          ),
          const Center(
              child: CupertinoActivityIndicator(
            radius: 15,
          )),
        ],
      ),
    );
  }
}
