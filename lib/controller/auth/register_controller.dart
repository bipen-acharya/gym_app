import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gym_app/controller/core_controller.dart';
import 'package:gym_app/controller/dashboard/home_screen_controller.dart';
import 'package:gym_app/repo/register_repo.dart';
import 'package:gym_app/utils/custom_snackbar.dart';
import 'package:gym_app/utils/storage_keys.dart';
import 'package:gym_app/views/auth/sub_planning_screen.dart';
import 'package:gym_app/views/dash_screen.dart';
import 'package:intl/intl.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class RegisterController extends GetxController {
  RxBool passwordObscure = true.obs;

  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final nameController = TextEditingController();

  void onEyeCLick() {
    passwordObscure.value = !passwordObscure.value;
  }

  final formKey = GlobalKey<FormState>();

  var selectedGender = "Male".obs;

  final selectedSubscription = ''.obs;
  // final selectedPrice = '100'.obs;
  final subscriptionEndDate = DateTime.now().obs;

  void updateSubscription(String payment) {
    selectedSubscription.value = payment;
  }

  RxInt selectedPrice = 10.obs;
  onSubscribe(context) async {
    if (selectedSubscription.value == "") {
      return CustomSnackBar.error(
          title: "Payment", message: "Choose a payment method");
    }
    int monthsToAdd = 0;

    switch (selectedSubscription.value) {
      case "1months":
        monthsToAdd = 1;
        selectedPrice.value = 10;
        break;
      case "2months":
        monthsToAdd = 2;
        selectedPrice.value = 20;

        break;
      case "3months":
        monthsToAdd = 3;
        selectedPrice.value = 30;

        break;
      case "6months":
        monthsToAdd = 6;
        selectedPrice.value = 60;

        break;
      default:
        monthsToAdd = 12;
        selectedPrice.value = 10;
    }
    print(selectedPrice.value);
    // Add months to the current date
    subscriptionEndDate.value =
        DateTime.now().add(Duration(days: 30 * monthsToAdd));
    String formattedDate =
        "${subscriptionEndDate.value.year}-${subscriptionEndDate.value.month}-${subscriptionEndDate.value.day}";
    print("Subscription End Date: $formattedDate");
    String formattedStartDate = DateFormat('yyyy-M-d').format(DateTime.now());
    print("Subscription Start Date: $formattedStartDate");

    // payWithKhalti(context, selectedPrice.value.toDouble());
    onGymSubscribe();
  }

  payWithKhalti(context, double amount) {
    KhaltiScope.of(context).pay(
      config: PaymentConfig(
        amount: amount.toInt() * 100,
        productIdentity: "productIdentity",
        productName: "productName",
      ),
      preferences: [
        PaymentPreference.khalti,
      ],
      onSuccess: (success) {
        onGymSubscribe();
        CustomSnackBar.success(title: "Payment", message: "Payment Successful");
      },
      onFailure: (fa) {
        CustomSnackBar.error(title: "Payment", message: "Payment Failure");
      },
      onCancel: () {
        CustomSnackBar.info(title: "Payment", message: "Payment Cancel");
      },
    );
  }

  final loading = SimpleFontelicoProgressDialog(
      context: Get.context!, barrierDimisable: false);

  void onSubmit() async {
    log("pending subscription 1");
    if (formKey.currentState!.validate()) {
      log("pending subscription 2");
      loading.show(message: "Please wait ..");
      await RegisterRepo.register(
        dob: dobController.text,
        name: nameController.text,
        gender: "Male",
        email: emailController.text,
        password: passwordController.text,
        onSuccess: (user) async {
          loading.hide();
          final box = GetStorage();
          await box.write(StorageKeys.USER, json.encode(user.toJson()));
          Get.find<CoreController>().loadCurrentUser();
          Get.offAll(() => const SubscriptionPlanningScreen());
          CustomSnackBar.success(
              title: "Register", message: "Register Successfull");
        },
        onError: (message) {
          loading.hide();
          CustomSnackBar.error(title: "Register", message: message);
        },
      );
    }
  }

  void onGymSubscribe() async {
    loading.show(message: "Please wait ..");
    await RegisterRepo.subscribe(
      totalPayment: selectedPrice.value.toString(),
      dateFrom: DateFormat('yyyy-M-d').format(DateTime.now()),
      dateTill:
          "${subscriptionEndDate.value.year}-${subscriptionEndDate.value.month}-${subscriptionEndDate.value.day}",
      onSuccess: () async {
        loading.hide();

        Get.offAll(() => DashScreen());
        CustomSnackBar.success(
            title: "Subscription", message: "Subscription Successfull");
      },
      onError: (message) {
        loading.hide();
        CustomSnackBar.error(title: "Register", message: message);
      },
    );
  }

  var selectedDate = DateTime.now().obs;
  dobDate(BuildContext context) async {
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
      selectedDate.value = pickedDate;
      dobController.text = selectedDate.value.toString().split(" ")[0];
    }
  }
}
