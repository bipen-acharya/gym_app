import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/models/products.dart';
import 'package:gym_app/models/trainers.dart';
import 'package:gym_app/utils/colors.dart';
import 'package:gym_app/utils/custom_text_style.dart';
import 'package:gym_app/views/show_sub.dart';
import 'package:gym_app/views/single_page.dart';
import 'package:gym_app/views/single_trainer_page.dart';
import 'package:gym_app/widgets/custom/elevated_button.dart';
import '../../controller/dashboard/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
  });

  final c = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "LifeTime Fitness",
              style: CustomTextStyles.f16W400(),
            ),
            Text(
              "Explore Your dream with us",
              style: CustomTextStyles.f12W400(),
            ),
          ],
        ),
      ),
      // drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Personal Trainers ",
                style: CustomTextStyles.f18W600(),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() => (c.loading.value)
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      height: 170,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: c.allTrainers.length,
                          itemBuilder: (context, index) {
                            Trainers trainers = c.allTrainers[index];
                            return PersonalTrainerCard(
                              trainer: trainers,
                            );
                          }),
                    )),
              Text(
                "Subscription Detail",
                style: CustomTextStyles.f16W600(),
              ),
              const SizedBox(
                height: 10,
              ),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomElevatedButton(
                        title: "View Subscription details",
                        onTap: () {
                          c.getSubDetail();
                          Get.to(() => SubscriptionDetailScreen());
                        }),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Product Detail",
                style: CustomTextStyles.f16W600(),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => (c.loading.value)
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: c.allProductsDetails.length,
                        itemBuilder: (context, index) {
                          Products product = c.allProductsDetails[index];
                          return GymMaterialsCard(
                            product: product,
                          );
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GymMaterialsCard extends StatelessWidget {
  const GymMaterialsCard({
    super.key,
    required this.product,
  });
  final Products product;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      // height: 128,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
            offset: const Offset(4, 4),
            blurRadius: 9,
            color: const Color(0xFF494949).withOpacity(0.1),
          ),
        ],
      ),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
            child: Image(
              image: NetworkImage(
                product.image ?? "",
              ),
              fit: BoxFit.fill,
              height: Get.height / 7,
              width: Get.width / 3,
            ),
          ),
          SizedBox(
            width: Get.width / 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width / 3,
                  child: Text(
                    product.name!,
                    style: CustomTextStyles.f16W600(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  width: Get.width / 3,
                  child: Text(
                    product.description!,
                    style: CustomTextStyles.f14W400(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: false,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  height: 40,
                  width: Get.width / 2.4,
                  child: CustomElevatedButton(
                      title: "View",
                      onTap: () {
                        Get.to(() => SinglePage(
                              products: product,
                            ));
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PersonalTrainerCard extends StatelessWidget {
  const PersonalTrainerCard({
    Key? key,
    required this.trainer,
  }) : super(key: key);

  final Trainers trainer;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => SingleTrainerScreen(
              trainers: trainer,
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 20),
        width: 175,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(9)),
                width: 175,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(9),
                      topRight: Radius.circular(9)),
                  child: CachedNetworkImage(
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    fit: BoxFit.fill,
                    imageUrl: trainer.photo ?? "",
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/common/logo.png',
                      fit: BoxFit.fill,
                    ),
                    height: 120,
                  ),
                )),
            const SizedBox(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                trainer.name!,
                style: CustomTextStyles.f16W400(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
