import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/controller/dashboard/home_screen_controller.dart';
import 'package:gym_app/models/trainers.dart';
import 'package:gym_app/utils/colors.dart';
import 'package:gym_app/utils/custom_text_style.dart';
import 'package:gym_app/views/trainer_booking_screen.dart';
import 'package:gym_app/widgets/custom/elevated_button.dart';

class SingleTrainerScreen extends StatelessWidget {
  SingleTrainerScreen({
    super.key,
    required this.trainers,
  });
  final c = Get.put(HomeScreenController());
  final Trainers trainers;
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 17,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 37,
              ),
              child: Text(
                trainers.name!,
                style: CustomTextStyles.f18W600(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25, left: 25, top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  fit: BoxFit.fill,
                  height: Get.height / 2.5,
                  imageUrl: trainers.image ?? "",
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/common/logo.png',
                    height: MediaQuery.of(context).size.height / 2.7,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            Container(
              // height: Get.height / 2.5,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(4, 4),
                    blurRadius: 9,
                    color: const Color(0xFF494949).withOpacity(0.2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Trainer Details",
                      style: CustomTextStyles.f16W600(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Name :",
                          style: CustomTextStyles.f16W400(
                              color: AppColors.blueColor),
                        ),
                        Text(
                          trainers.name!,
                          style: CustomTextStyles.f14W400(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Email :",
                          style: CustomTextStyles.f16W400(
                              color: AppColors.blueColor),
                        ),
                        Text(
                          trainers.email!,
                          style: CustomTextStyles.f14W400(),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Contact :",
                          style: CustomTextStyles.f16W400(
                              color: AppColors.blueColor),
                        ),
                        Text(
                          trainers.dob!,
                          style: CustomTextStyles.f14W400(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Fee Per month",
                      style: CustomTextStyles.f16W600(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      trainers.email!,
                      style: CustomTextStyles.f16W400(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "About Trainer",
                      style: CustomTextStyles.f16W600(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "INCREASED CORE STABILITY: One of the primary benefits of a weightlifting belt is increased core INCREASED CORE STABILITY: One of the primary benefits of a weightlifting belt is increased core ",
                      style: CustomTextStyles.f14W400(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 235, 235, 235),
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 4),
                blurRadius: 9,
                color: const Color(0xFF494949).withOpacity(0.4),
              ),
            ],
          ),
          height: 90,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: CustomElevatedButton(
              onTap: () {
                Get.to(() => TrainerBookingScreen(
                      trainer: trainers,
                    ));
              },
              title: "Book Trainer",
            ),
          )),
    );
  }
}

class SizeButton extends StatelessWidget {
  const SizeButton({
    Key? key,
    required this.name,
    required this.image,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  final bool isSelected;
  final String name;
  final String image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(name),
        ),
      ),
    );
  }
}
