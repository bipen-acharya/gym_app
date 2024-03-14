import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/controller/dashboard/dash_screen_controller.dart';
import 'package:gym_app/utils/colors.dart';

class DashScreen extends StatelessWidget {
  static const String routeName = "/dash-screen";
  final c = Get.put(DashScreenController());
  DashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: c.key,
      body: Obx(
        () => c.pages[c.currentIndex.value],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavyBar(
          selectedIndex: c.currentIndex.value,
          onItemSelected: c.onItemTapped,
          items: [
            BottomNavyBarItem(
                icon: const Icon(Icons.home),
                title: const Text("Home"),
                textAlign: TextAlign.center,
                activeColor: AppColors.primaryColor,
                inactiveColor: Colors.grey),
            BottomNavyBarItem(
                icon: const Icon(Icons.history),
                title: const Text("Orders"),
                textAlign: TextAlign.center,
                activeColor: AppColors.primaryColor,
                inactiveColor: Colors.grey),
            BottomNavyBarItem(
              icon: const Icon(Icons.person),
              title: const Text("Profile"),
              textAlign: TextAlign.center,
              activeColor: AppColors.primaryColor,
              inactiveColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
