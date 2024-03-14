import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/controller/auth/login_controller.dart';
import 'package:gym_app/utils/colors.dart';
import 'package:gym_app/utils/validatior.dart';
import 'package:gym_app/views/auth/register_screen.dart';
import 'package:gym_app/widgets/custom/custom_textfield.dart';
import 'package:gym_app/widgets/custom/elevated_button.dart';
import '../../utils/custom_text_style.dart';
import '../../widgets/custom/custom_password_fields.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final c = Get.put(LogInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: Get.height / 3,
                  width: Get.width / 1.3,
                  child: const Image(
                    image: AssetImage("assets/common/logo.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Form(
                key: c.formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Log In",
                        style: CustomTextStyles.f24W600(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Please sign in to continue",
                        style: CustomTextStyles.f14W400(
                          color: AppColors.secondaryTextColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Email Address",
                        style: CustomTextStyles.f14W400(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextField(
                        preIconPath: Icons.person_outline_sharp,
                        hint: "Email",
                        validator: Validators.checkEmailField,
                        controller: c.emailController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Password",
                        style: CustomTextStyles.f14W400(),
                      ),
                      Obx(
                        () => CustomPasswordField(
                          hint: "Password",
                          eye: c.passwordObscure.value,
                          onEyeClick: c.onEyeCLick,
                          controller: c.passwordController,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomElevatedButton(
                        title: "Login",
                        onTap: () {
                          c.onSubmit();
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have a account ? ",
                            style: CustomTextStyles.f14W400(),
                          ),
                          InkWell(
                            onTap: () {
                              Get.off(() => LogInScreen());
                            },
                            child: InkWell(
                              onTap: () {
                                Get.to(() => RegisterScreen());
                              },
                              child: Text(
                                "Create one",
                                style: CustomTextStyles.f14W400(
                                    color: AppColors.primaryColor),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
