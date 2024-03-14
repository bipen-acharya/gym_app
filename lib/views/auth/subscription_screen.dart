import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/controller/auth/register_controller.dart';
import 'package:gym_app/utils/colors.dart';
import 'package:gym_app/utils/custom_text_style.dart';
import 'package:gym_app/utils/image_path.dart';
import 'package:gym_app/widgets/custom/elevated_button.dart';

class SubscriptionScreen extends StatelessWidget {
  SubscriptionScreen({super.key});

  final c = Get.put(RegisterController());
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
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: Get.height / 7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(ImagePath.logoOnly),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "LifeTime",
                      style: CustomTextStyles.f24W600(),
                    ),
                    Text(
                      "Fitness",
                      style: CustomTextStyles.f16W400(),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 11,
          ),
          Text(
            "LifeTime Fitness Subscription details ",
            style: CustomTextStyles.f16W400(),
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.all(13.0),
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  PaymentButton(
                    name: '1 months',
                    isSelected: c.selectedSubscription.value == '1months',
                    image: ImagePath.khalti,
                    onTap: () => c.updateSubscription('1months'),
                  ),
                  PaymentButton(
                    name: '2 months',
                    isSelected: c.selectedSubscription.value == '2months',
                    image: ImagePath.khalti,
                    onTap: () => c.updateSubscription('2months'),
                  ),
                  PaymentButton(
                    name: '3 months',
                    image: ImagePath.khalti,
                    isSelected: c.selectedSubscription.value == '3months',
                    onTap: () => c.updateSubscription('3months'),
                  ),
                  PaymentButton(
                    name: '6 months',
                    image: ImagePath.khalti,
                    isSelected: c.selectedSubscription.value == '6months',
                    onTap: () => c.updateSubscription('6months'),
                  ),
                  PaymentButton(
                    name: '1 yr ',
                    image: ImagePath.khalti,
                    isSelected: c.selectedSubscription.value == '1yr',
                    onTap: () => c.updateSubscription('1yr'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
          height: 90,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: CustomElevatedButton(
              onTap: () {
                c.onSubscribe(context);
              },
              title: "Make Payment",
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
