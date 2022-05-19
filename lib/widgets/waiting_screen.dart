import 'package:apni_mandi/controllers/profile_controller.dart';
import 'package:apni_mandi/models/business_info_model.dart';
import 'package:apni_mandi/models/personal_info_model.dart';
import 'package:apni_mandi/utils/constants/assets_manager.dart';
import 'package:apni_mandi/utils/constants/color_manager.dart';
import 'package:apni_mandi/utils/constants/strings_manager.dart';
import 'package:apni_mandi/utils/constants/values_manager.dart';
import 'package:apni_mandi/utils/helpers/helper.dart';
import 'package:apni_mandi/utils/helpers/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'large_button.dart';
import 'package:get/get.dart';

class WaitingScreen extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  WaitingScreen({Key? key}) : super(key: key);

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  final ProfileController _profileController = Get.put(ProfileController());

  PersonalInfoModel? personalInfoModel;
  BusinessInfoModel? businessInfoModel;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    personalInfoModel = await _profileController.getPersonalData();
    businessInfoModel = await _profileController.getBusinessData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _profileController.isLoading.isTrue
          ? const Center(child: CircularProgressIndicator())
          : personalInfoModel != null && businessInfoModel != null
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      buildSpaceVertical(10.h),
                      personalInfoModel!.profileImage != null
                          ? CircleAvatar(
                              radius: 60,
                              backgroundColor: ColorManager.grayColor,
                              backgroundImage: NetworkImage(
                                  personalInfoModel!.profileImage ?? ''),
                            )
                          : const CircleAvatar(
                              radius: 60,
                              backgroundColor: ColorManager.grayColor,
                              backgroundImage: AssetImage(AssetImages.avatar),
                            ),
                      // buildSpaceVertical(1.h),
                      // ElevatedButton(
                      //   style: ElevatedButton.styleFrom(
                      //     textStyle: const TextStyle(fontSize: 20, color: ColorManager.secondaryColor),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(20.0),
                      //     ),
                      //     fixedSize: Size(42.w, 5.h),
                      //     primary: ColorManager.primaryColor,
                      //   ),
                      //   onPressed: (){},
                      //   child: textStyle2(StringsManager.changePic, TextAlign.center, ColorManager.whiteColor)
                      // ),

                      buildSpaceVertical(8.h),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textStyle3(StringsManager.name, TextAlign.center,
                                ColorManager.primaryColor),
                            textStyle2(
                                "${personalInfoModel!.firstName}  ${personalInfoModel!.lastName} ",
                                TextAlign.center,
                                ColorManager.primaryColor),
                          ],
                        ),
                      ),

                      buildSpaceVertical(2.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textStyle3(StringsManager.number, TextAlign.center,
                                ColorManager.primaryColor),
                            textStyle2("${personalInfoModel!.phoneNo}",
                                TextAlign.center, ColorManager.primaryColor),
                          ],
                        ),
                      ),

                      buildSpaceVertical(2.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textStyle3(StringsManager.eEmail, TextAlign.center,
                                ColorManager.primaryColor),
                            textStyle2("${personalInfoModel!.email}",
                                TextAlign.center, ColorManager.primaryColor),
                          ],
                        ),
                      ),

                      buildSpaceVertical(2.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textStyle3(StringsManager.businessName,
                                TextAlign.center, ColorManager.primaryColor),
                            textStyle2("${businessInfoModel!.businessName}",
                                TextAlign.center, ColorManager.primaryColor),
                          ],
                        ),
                      ),

                      buildSpaceVertical(2.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textStyle3(StringsManager.memberSince,
                                TextAlign.center, ColorManager.primaryColor),
                            textStyle2("${businessInfoModel!.memberSince}",
                                TextAlign.center, ColorManager.primaryColor),
                          ],
                        ),
                      ),

                      buildSpaceVertical(2.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textStyle3(StringsManager.membershipStatus,
                                TextAlign.center, ColorManager.primaryColor),
                            textStyle2(
                                businessInfoModel!.membershipStatus != false
                                    ? "Active"
                                    : "In-Active",
                                TextAlign.center,
                                ColorManager.primaryColor),
                          ],
                        ),
                      ),

                      buildSpaceVertical(10.h),
                      InkWell(
                        onTap: () => Get.toNamed('/searchView'),
                        child: const LargeButton(
                            title: StringsManager.searchMember,
                            color: ColorManager.primaryColor),
                      )
                    ],
                  ),
                )
              : Center(
                  child: textStyle3(StringsManager.noData, TextAlign.center,
                      ColorManager.primaryColor)),
    );
  }
}
