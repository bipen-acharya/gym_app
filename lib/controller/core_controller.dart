import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gym_app/utils/storage_keys.dart';
import 'package:gym_app/views/auth/login_screen.dart';

import '../models/user.dart';

class CoreController extends GetxController {
  Rx<User?> currentUser = Rxn<User>();

  @override
  void onInit() async {
    await loadCurrentUser();
    super.onInit();
  }

  Future<void> loadCurrentUser() async {
    currentUser.value = StorageHelper.getUser();
  }

  bool isUserLoggedIn() {
    return currentUser.value != null;
  }

  void logOut() async {
    final box = GetStorage();
    await box.write(StorageKeys.USER, null);
    loadCurrentUser();
    Get.offAll(() => LogInScreen());
  }
}
