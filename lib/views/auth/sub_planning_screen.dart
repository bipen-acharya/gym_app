import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/views/auth/subscription_screen.dart';
import 'package:gym_app/views/dash_screen.dart';
import 'package:gym_app/widgets/custom/elevated_button.dart';

class SubscriptionPlanningScreen extends StatelessWidget {
  const SubscriptionPlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10, left: 20),
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: Get.height / 5,
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://t4.ftcdn.net/jpg/03/17/72/47/360_F_317724775_qHtWjnT8YbRdFNIuq5PWsSYypRhOmalS.jpg"),
                    fit: BoxFit.fill,
                    opacity: 0.4),
                borderRadius: BorderRadius.circular(9),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(4, 4),
                    blurRadius: 9,
                    color: const Color(0xFF494949).withOpacity(0.1),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  CustomElevatedButton(
                      title: "Run with-out subscription",
                      onTap: () {
                        Get.offAll(() => DashScreen());
                      }),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10, left: 20),
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: Get.height / 5,
              decoration: BoxDecoration(
                color: const Color.fromARGB(61, 173, 28, 47),
                borderRadius: BorderRadius.circular(9),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://t4.ftcdn.net/jpg/03/17/72/47/360_F_317724775_qHtWjnT8YbRdFNIuq5PWsSYypRhOmalS.jpg"),
                    fit: BoxFit.fill,
                    opacity: 0.4),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(4, 4),
                    blurRadius: 9,
                    color: const Color(0xFF494949).withOpacity(0.1),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  CustomElevatedButton(
                      title: "Run with subscription",
                      onTap: () {
                        Get.to(() => SubscriptionScreen());
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
