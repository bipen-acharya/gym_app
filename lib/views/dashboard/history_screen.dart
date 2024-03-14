import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/controller/dashboard/home_screen_controller.dart';
import 'package:gym_app/models/product_history.dart';
import 'package:gym_app/utils/colors.dart';
import 'package:gym_app/utils/custom_text_style.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});

  final c = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        centerTitle: false,
        title: Text(
          "History",
          style: CustomTextStyles.f16W600(color: Colors.white),
        ),
      ),
      body: Obx(
        () => (c.loading.value)
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                shrinkWrap: true,
                itemCount: c.allOrders.length,
                itemBuilder: (context, index) {
                  ProductHistory orders = c.allOrders[index];
                  return HistoryListCard(
                    colors:
                        index % 2 == 0 ? AppColors.primaryColor : Colors.amber,
                    product: orders,
                  );
                }),
      ),

      // ListView.builder(
      //   itemCount: 10,
      //   itemBuilder: (context, index) {
      //     return HistoryListCard(
      //       colors: index % 2 == 0 ? AppColors.primaryColor : Colors.amber,
      //     );
      //   },
      // ),
    );
  }
}

class HistoryListCard extends StatelessWidget {
  const HistoryListCard({
    key,
    required this.colors,
    required this.product,
  }) : super(key: key);

  final Color colors;
  final ProductHistory product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 19, right: 19, top: 20),
      child: InkWell(
        onTap: () {},
        child: Container(
          // height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(4, 4),
                blurRadius: 9,
                color: const Color(0xFF494949).withOpacity(0.06),
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  color: colors,
                ),
                width: 10,
                height: 100,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Item id: ${product.id}",
                    style: CustomTextStyles.f14W400(),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Text(
                    "Payment Method ${product.paymentMethod}",
                    style: CustomTextStyles.f14W400(),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Text(
                    "Date:${product.date}",
                    style: CustomTextStyles.f14W400(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
