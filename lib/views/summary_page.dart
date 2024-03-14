import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/controller/dashboard/home_screen_controller.dart';
import 'package:gym_app/models/products.dart';
import 'package:gym_app/utils/colors.dart';
import 'package:gym_app/utils/custom_snackbar.dart';
import 'package:gym_app/utils/custom_text_style.dart';
import 'package:gym_app/utils/storage_keys.dart';
import 'package:gym_app/widgets/custom/elevated_button.dart';
import 'package:intl/intl.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class SummaryPage extends StatelessWidget {
  SummaryPage({super.key, required this.pro});

  final Products pro;
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
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 23),
            width: double.infinity,
            padding: const EdgeInsets.all(20),
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
                  "Summary",
                  style: CustomTextStyles.f14W400(),
                ),
                const SizedBox(
                  height: 9,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: (BorderRadius.circular(10)),
                      child: Image.network(
                        pro.image!,
                        fit: BoxFit.fill,
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pro.name!,
                          style: CustomTextStyles.f14W400(),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        SizedBox(
                          width: Get.width / 2,
                          child: Text(
                            pro.description!,
                            style: CustomTextStyles.f14W400(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 14,
                    ),
                    CalculationRow(
                      title: 'Name',
                      calculation: StorageHelper.getUser()!.name.toString(),
                    ),
                    CalculationRow(
                      title: 'Email',
                      calculation: StorageHelper.getUser()!.email.toString(),
                    ),

                    CalculationRow(
                      title: 'Size',
                      calculation: c.selectedSize.value.toString(),
                    ),
                    CalculationRow(
                      title: 'Cost',
                      calculation: pro.price.toString(),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: List.generate(
                        150 ~/ 2,
                        (index) => Expanded(
                          child: Container(
                            color: index % 2 == 0
                                ? Colors.transparent
                                : Colors.grey,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: CustomTextStyles.f14W400(),
                        ),
                        Text(
                          "1000",
                          style: CustomTextStyles.f14W400(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    // ElevatedButton(
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
      bottomNavigationBar: Container(
          height: 90,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: CustomElevatedButton(
              onTap: () {
                PostItems postItems =
                    PostItems(productId: pro.id, quantity: "1");
                // print(postItems.toJson());

                Map<String, dynamic> orderData = {
                  "payment_method": "khalti",
                  "products": [postItems.toJson()],
                  "total": pro.price,
                  "date": DateFormat('yyyy-M-d').format(DateTime.now())
                };
                KhaltiScope.of(context).pay(
                  config: PaymentConfig(
                    amount: 1000,
                    productIdentity: "productIdentity",
                    productName: "productName",
                  ),
                  preferences: [
                    PaymentPreference.khalti,
                  ],
                  onSuccess: (success) {
                    c.postOrders(orderData);
                    CustomSnackBar.success(
                        title: "Payment", message: "Payment Successful");
                  },
                  onFailure: (fa) {
                    CustomSnackBar.error(
                        title: "Payment", message: "Payment Failure");
                  },
                  onCancel: () {
                    CustomSnackBar.info(
                        title: "Payment", message: "Payment Cancel");
                  },
                );
                print(jsonEncode(orderData));
                // c.postOrders(orderData);

                // Get.offAll(() => DashScreen());
              },
              title: "Make Payment",
            ),
          )),
    );
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

class PostItems {
  int? productId;
  String? quantity;

  PostItems({this.productId, this.quantity});

  PostItems.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['quantity'] = quantity;
    return data;
  }
}
