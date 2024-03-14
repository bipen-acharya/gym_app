import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/controller/dashboard/home_screen_controller.dart';
import 'package:gym_app/models/products.dart';
import 'package:gym_app/utils/custom_snackbar.dart';
import 'package:gym_app/utils/custom_text_style.dart';
import 'package:gym_app/utils/image_path.dart';
import 'package:gym_app/views/summary_page.dart';
import 'package:gym_app/widgets/custom/elevated_button.dart';
import '../utils/colors.dart';

class SinglePage extends StatelessWidget {
  static const routeName = "/single_page";
  SinglePage({
    super.key,
    required this.products,
  });
  final c = Get.put(HomeScreenController());
  final Products products;
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
                products.name!,
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
                  imageUrl: products.image!,
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "OverView",
                      style: CustomTextStyles.f16W600(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Weight Lifting Belt (5mm Thick) - Leather Weight Lifting Belt for Women & Men - Functional Workout Belt - Gym Belt for Weightlifting, Powerlifting, Squat & Deadlift - Adjustable Weightlifting Belt",
                      style: CustomTextStyles.f14W400(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Select Size",
                      style: CustomTextStyles.f16W600(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: [
                          SizeButton(
                            name: 'Small',
                            image: ImagePath.khalti,
                            isSelected: c.selectedSize.value == 'Small',
                            onTap: () => c.updateSelectedSize('Small'),
                          ),
                          SizeButton(
                            name: 'Medium',
                            isSelected: c.selectedSize.value == 'Medium',
                            image: ImagePath.khalti,
                            onTap: () => c.updateSelectedSize('Medium'),
                          ),
                          SizeButton(
                            name: 'Large',
                            isSelected: c.selectedSize.value == 'Large',
                            image: ImagePath.khalti,
                            onTap: () => c.updateSelectedSize('Large'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Price",
                      style: CustomTextStyles.f16W600(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      products.price.toString(),
                      style: CustomTextStyles.f14W400(),
                    ),
                    Text(
                      "About this item",
                      style: CustomTextStyles.f16W600(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      products.description!,
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
                print(c.selectedSize.value.toString());
                if (c.selectedSize.value == "") {
                  CustomSnackBar.error(
                      title: "Size",
                      message: "Choose the size before you proceed");
                } else {
                  Get.to(() => SummaryPage(
                        pro: products,
                      ));
                }
              },
              title: "Continue...",
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
