import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/models/product_history.dart';
import 'package:gym_app/models/products.dart';
import 'package:gym_app/models/subscription.dart';
import 'package:gym_app/models/trainers.dart';
import 'package:gym_app/repo/product_repo.dart';
import 'package:gym_app/repo/sub_repo.dart';
import 'package:gym_app/repo/trainer_repo.dart';
import 'package:gym_app/utils/custom_snackbar.dart';
import 'package:gym_app/views/dash_screen.dart';
import 'package:intl/intl.dart';

class HomeScreenController extends GetxController {
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    getAllTrainersDetails();
    getAllProductDetails();
    getAllOrderDetails();
    super.onInit();
  }

  RxInt selectedIndex = 1.obs;

  RxBool isLoadingIncomes = RxBool(false);
  RxDouble online = RxDouble(10);
  RxDouble offline = RxDouble(10);

  RxInt current = RxInt(0);

  final CarouselController controller = CarouselController();

  final selectedSize = ''.obs;
  void updateSelectedSize(String chooseSize) {
    selectedSize.value = chooseSize;
  }

  TextEditingController startTimeController = TextEditingController();
  var startSelectedTime = TimeOfDay.now().obs;
  late String startTime;

  TextEditingController startDateController = TextEditingController();
  var endSelectedDate = DateTime.now().obs;
  late String endTime;

  startTrainingTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().hour),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(),
          child: child ?? Container(),
        );
      },
    );
    if (pickedTime != null) {
      startSelectedTime.value = pickedTime;
      // ignore: use_build_context_synchronously
      startTime = pickedTime.format(context).toString();
      startTimeController.text =
          "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}:00";
    }
  }

  starTrainingDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(),
          child: child ?? Container(),
        );
      },
    );

    if (pickedDate != null) {
      endSelectedDate.value = pickedDate;
      startDateController.text = endSelectedDate.value.toString().split(" ")[0];
    }
  }

  RxBool loading = RxBool(false);

  RxList<Products> allProductsDetails = <Products>[].obs;
  RxList<ProductHistory> allOrders = <ProductHistory>[].obs;
  RxList<Trainers> allTrainers = <Trainers>[].obs;

  getAllTrainersDetails() async {
    loading.value = true;
    await TrainerRepo.getTrainers(
      onSuccess: (trainer) {
        loading.value = false;
        allTrainers.addAll(trainer);
      },
      onError: ((message) {
        loading.value = false;
        CustomSnackBar.error(title: "Trainers", message: message);
      }),
    );
  }

  getAllProductDetails() async {
    loading.value = true;
    await ProductRepo.getProducts(
      onSuccess: (allProducts) {
        loading.value = false;
        allProductsDetails.addAll(allProducts);
      },
      onError: ((message) {
        loading.value = false;
        CustomSnackBar.error(title: "Products", message: message);
      }),
    );
  }

  getAllOrderDetails() async {
    loading.value = true;
    await ProductRepo.getOrderHistory(
      onSuccess: (allOrdersHistory) {
        loading.value = false;
        allOrders.addAll(allOrdersHistory);
      },
      onError: ((message) {
        loading.value = false;
        CustomSnackBar.error(title: "Orders", message: message);
      }),
    );
  }

  postOrders(var product) async {
    loading.value = true;
    await ProductRepo.postOrder(
      items: product,
      onSuccess: () {
        Get.offAll(() => DashScreen());
      },
      onError: ((message) {
        loading.value = false;
        CustomSnackBar.error(title: "Products", message: message);
      }),
    );
  }

  final selectedDuration = ''.obs;
  // final selectedPrice = '100'.obs;
  final durationEndDate = DateTime.now().obs;

  void updatedDuration(String payment) {
    selectedDuration.value = payment;
  }

  onDuration(context, id) async {
    if (selectedDuration.value == "") {
      return CustomSnackBar.error(
        title: "Payment",
        message: "Choose a Duration",
      );
    }

    int monthsToAdd = 0;

    switch (selectedDuration.value) {
      case "1months":
        monthsToAdd = 1;
        break;
      case "2months":
        monthsToAdd = 2;
        break;
      case "3months":
        monthsToAdd = 3;
        break;
      case "6months":
        monthsToAdd = 6;
        break;
      default:
        monthsToAdd = 12;
    }

    DateTime startDate = DateTime.parse(
        "${startDateController.text} ${startTimeController.text}");

    // Add months to the current date
    durationEndDate.value = startDate.add(Duration(days: 30 * monthsToAdd));

    String formattedStartDate =
        DateFormat('yyyy-MM-dd HH:mm').format(startDate);
    String formattedEndDate =
        DateFormat('yyyy-MM-dd HH:mm').format(durationEndDate.value);

    log("Subscription Start Date: $formattedStartDate");
    log("Subscription End Date: $formattedEndDate");
    onGymSubscribe(id);
  }

  void onGymSubscribe(id) async {
    loading.value = true;
    await TrainerRepo.bookTrainers(
      to: DateFormat('yyyy-MM-dd HH:mm').format(durationEndDate.value),
      from: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(
          "${startDateController.text} ${startTimeController.text}")),
      trainerid: id,
      onSuccess: () async {
        loading.value = false;
        Get.offAll(() => DashScreen());
        CustomSnackBar.success(
            title: "Booking", message: "Booking Successfull");
      },
      onError: (message) {
        loading.value = false;
        CustomSnackBar.error(title: "Booking", message: message);
      },
    );
  }

  SuscriptionDetailUser? sub;
  getSubDetail() async {
    loading.value = true;
    await SubRepo.subDetail(
      onSuccess: (user) {
        loading.value = false;
        sub = user;
        log(sub!.suscriptionDetails!.endDate.toString());
      },
      onError: ((message) {
        loading.value = false;
        CustomSnackBar.error(title: "Orders", message: message);
      }),
    );
  }
}
