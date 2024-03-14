import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/controller/dashboard/home_screen_controller.dart';
import 'package:gym_app/utils/colors.dart';
import 'package:gym_app/utils/custom_text_style.dart';

class SubscriptionDetailScreen extends StatelessWidget {
  SubscriptionDetailScreen({super.key});
  final c = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          elevation: 5,
          shadowColor: const Color(0xFF494949).withOpacity(0.06),
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
        ),
        body: Obx(() => (c.loading.value)
            ? const Center(child: CircularProgressIndicator())
            : (c.sub?.suscriptionDetails == null
                ? const Center(
                    child: Text("No Subscription Detail"),
                  )
                : Column(
                    children: [
                      Container(
                        height: Get.height / 3.5,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 23),
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(4, 4),
                              blurRadius: 9,
                              color: const Color(0xFF494949).withOpacity(0.1),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Subscription details",
                              style: CustomTextStyles.f14W400(),
                            ),
                            const SizedBox(
                              height: 9,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 14,
                                ),
                                CalculationRow(
                                  title: 'Total Days ',
                                  calculation: c
                                          .sub!.suscriptionDetails!.endDate
                                          .toString() ??
                                      "",
                                ),
                                CalculationRow(
                                  title: 'Remaining Days',
                                  calculation: c
                                          .sub!.suscriptionDetails!.endDate
                                          .toString() ??
                                      "",
                                ),
                                CalculationRow(
                                  title: 'Start Date',
                                  calculation: c
                                          .sub!.suscriptionDetails!.endDate
                                          .toString() ??
                                      "",
                                ),
                                CalculationRow(
                                  title: 'End Date',
                                  calculation: c
                                          .sub!.suscriptionDetails!.endDate
                                          .toString() ??
                                      "",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ))));
  }
}

class CalculationRow extends StatelessWidget {
  const CalculationRow({
    super.key,
    required this.title,
    required this.calculation,
  });

  final String title;
  final String calculation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: CustomTextStyles.f14W400(),
          ),
          Text(
            calculation,
            style: CustomTextStyles.f14W400(),
          ),
        ],
      ),
    );
  }
}
