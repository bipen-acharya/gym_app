import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/controller/dashboard/home_screen_controller.dart';
import 'package:gym_app/models/trainers.dart';
import 'package:gym_app/utils/colors.dart';
import 'package:gym_app/utils/custom_text_style.dart';
import 'package:gym_app/utils/image_path.dart';
import 'package:gym_app/utils/validatior.dart';
import 'package:gym_app/widgets/custom/custom_textfield.dart';
import 'package:gym_app/widgets/custom/elevated_button.dart';

class TrainerBookingScreen extends StatelessWidget {
  TrainerBookingScreen({super.key, required this.trainer});

  final Trainers trainer;
  final c = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
        shadowColor: const Color(0xFF494949).withOpacity(0.06),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: c.formKey,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "LifeTime Fitness Trainer Subscription details ",
                  style: CustomTextStyles.f16W400(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Start Date",
                  style: CustomTextStyles.f16W600(),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  readOnly: true,
                  validator: Validators.checkFieldEmpty,
                  preIconPath: Icons.calendar_month,
                  hint: "Start Date",
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.none,
                  controller: c.startDateController,
                  onTap: () {
                    c.starTrainingDate(context);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("Start Time", style: CustomTextStyles.f16W600()),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: c.startTimeController,
                  readOnly: true,
                  preIconPath: Icons.lock_clock,
                  hint: "Start Time",
                  validator: Validators.checkFieldEmpty,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.none,
                  onTap: () {
                    c.startTrainingTime(context);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("Duration", style: CustomTextStyles.f16W600()),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      PaymentButton(
                        name: '1 months',
                        isSelected: c.selectedDuration.value == '1months',
                        image: ImagePath.trainer,
                        onTap: () => c.updatedDuration('1months'),
                      ),
                      PaymentButton(
                        name: '2 months',
                        isSelected: c.selectedDuration.value == '2months',
                        image: ImagePath.trainer,
                        onTap: () => c.updatedDuration('2months'),
                      ),
                      PaymentButton(
                        name: '3 months',
                        image: ImagePath.trainer,
                        isSelected: c.selectedDuration.value == '3months',
                        onTap: () => c.updatedDuration('3months'),
                      ),
                      PaymentButton(
                        name: '6 months',
                        image: ImagePath.trainer,
                        isSelected: c.selectedDuration.value == '6months',
                        onTap: () => c.updatedDuration('6months'),
                      ),
                      PaymentButton(
                        name: '1 yr ',
                        image: ImagePath.trainer,
                        isSelected: c.selectedDuration.value == '1yr',
                        onTap: () => c.updateSelectedSize('1yr'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
          height: 90,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: CustomElevatedButton(
              onTap: () {
                // Get.offAll(() => DashScreen());
                if (c.formKey.currentState!.validate()) {
                  c.onDuration(context, trainer.id!.toString());
                }
              },
              title: "Book Trainer",
            ),
          )),
    );
  }
}

class PaymentButton extends StatelessWidget {
  const PaymentButton({
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
        width: double.infinity,
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
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            isSelected ? AppColors.primaryColor : Colors.grey,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor
                              : Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    name,
                    style: CustomTextStyles.f16W600(),
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                ],
              ),
              Image.asset(
                image,
                height: 40,
                width: 40,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
