import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/controller/core_controller.dart';
import 'package:gym_app/utils/colors.dart';
import 'package:gym_app/utils/custom_text_style.dart';
import 'package:gym_app/utils/storage_keys.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile_screen';
  ProfileScreen({super.key});

  final corController = Get.put(CoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        backgroundColor: AppColors.primaryColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("My Profile",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              children: [
                Row(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/common/logo.png"))),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(StorageHelper.getUser()!.name.toString(),
                            style:
                                CustomTextStyles.f16W400(color: Colors.white)),
                        const SizedBox(height: 7),
                        Text(StorageHelper.getUser()!.gender.toString(),
                            style:
                                CustomTextStyles.f16W400(color: Colors.white)),
                        const SizedBox(height: 7),
                        Text(StorageHelper.getUser()!.email.toString(),
                            style:
                                CustomTextStyles.f16W400(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 15),
                // SizedBox(
                //   height: 45,
                //   width: 113,
                //   child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //           backgroundColor:
                //               const Color.fromARGB(255, 239, 235, 235)
                //                   .withOpacity(0.35)),
                //       onPressed: () {},
                //       child: const Text("Edit Profile",
                //           style: TextStyle(color: Colors.white, fontSize: 12))),
                // ),
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 30, right: 16),
            child: InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // const Icon(Icons.info),
                        const SizedBox(width: 20),
                        Text(
                          "Version",
                          style: CustomTextStyles.f16W400(
                              color: AppColors.textColor),
                        )
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ),
                onTap: () {
                  // Get.to(() => EditProfileScreen());
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 30, right: 16),
            child: InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // const Icon(Icons.info),
                        const SizedBox(width: 20),
                        Text(
                          "About",
                          style: CustomTextStyles.f16W400(
                              color: AppColors.textColor),
                        )
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ),
                onTap: () {
                  // Get.to(() => EditProfileScreen());
                }),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 30, left: 30, right: 16, bottom: 30),
            child: InkWell(
              onTap: () {
                // Get.to(() => const BookingHistoryScreen());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // const Icon(Icons.list),
                      const SizedBox(width: 20),
                      Text(
                        "FAQ",
                        style: CustomTextStyles.f16W400(
                            color: AppColors.textColor),
                      )
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
            ),
          ),
          const Divider(thickness: 1.5),
          Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 40),
            child: TextButton(
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Are you sure you want to logout?",
                          style: CustomTextStyles.f10W400(),
                        ),
                      ],
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: Get.width / 3.5,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: AppColors.lGrey),
                                  borderRadius: BorderRadius.circular(5)),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.extraWhite,
                                  elevation: 0.0,
                                ),
                                child: Text('No',
                                    style: CustomTextStyles.f12W400(
                                        color: AppColors.textColor)),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              width: Get.width / 3.5,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  elevation: 0.0,
                                ),
                                child: Text('Yes',
                                    style: CustomTextStyles.f12W400(
                                        color: AppColors.extraWhite)),
                                onPressed: () {
                                  corController.logOut();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Row(
                children: [
                  Text("Log out",
                      style:
                          CustomTextStyles.f16W400(color: AppColors.textColor)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.title,
    required this.content,
    required this.iconData,
  });

  final String title;
  final String content;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF828282).withOpacity(0.2),
            blurRadius: 9,
            offset: const Offset(4, 4),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(iconData),
              const SizedBox(
                width: 15,
              ),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor),
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          )
        ],
      ),
    );
  }
}
