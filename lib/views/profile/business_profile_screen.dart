import 'package:apni_mandi/views/profile/update_business_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/profile_controller.dart';
import '../../models/business_info_model.dart';
import '../../models/personal_info_model.dart';
import '../../utils/constants/assets_manager.dart';
import '../../utils/constants/color_manager.dart';
import '../../utils/constants/values_manager.dart';
import '../../utils/helpers/helper.dart';
import '../../utils/helpers/text_helper.dart';

class BusinessProfileScreen extends StatefulWidget {
  const BusinessProfileScreen({Key? key}) : super(key: key);

  @override
  State<BusinessProfileScreen> createState() => _BusinessProfileScreenState();
}

class _BusinessProfileScreenState extends State<BusinessProfileScreen> {
  final ProfileController _profileController = Get.put(ProfileController());
  BusinessInfoModel? businessInfoModel;
  PersonalInfoModel? personalInfoModel;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    businessInfoModel = await _profileController.getBusinessData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _profileController.isLoading.isTrue
          ? const Center(child: CircularProgressIndicator())
          : businessInfoModel != null
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      buildSpaceVertical(3.h),
                      businessInfoModel!.profileImage != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildSpaceHorizontal(20.w),
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: ColorManager.grayColor,
                                  backgroundImage: NetworkImage(
                                      businessInfoModel!.profileImage ?? ''),
                                ),
                                buildSpaceHorizontal(20.w),
                                IconButton(
                                  onPressed: () {
                                    Get.to(UpdateBusinessProfile(
                                        businessInfoModel: businessInfoModel!));
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: ColorManager.primaryColor,
                                    size: 30,
                                  ),
                                )
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildSpaceHorizontal(20.w),
                                const CircleAvatar(
                                  radius: 60,
                                  backgroundColor: ColorManager.grayColor,
                                  backgroundImage:
                                      AssetImage(AssetImages.avatar),
                                ),
                                buildSpaceHorizontal(20.w),
                                IconButton(
                                  onPressed: () {
                                    Get.to(UpdateBusinessProfile(
                                        businessInfoModel: businessInfoModel!));
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: ColorManager.primaryColor,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),

                      buildSpaceVertical(3.h),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            textStyle3("Business Name:", TextAlign.center,
                                ColorManager.primaryColor),
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
                            textStyle3("Business No:", TextAlign.center,
                                ColorManager.primaryColor),
                            textStyle2("${businessInfoModel!.phoneNo}",
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
                            textStyle3("Business Email", TextAlign.center,
                                ColorManager.primaryColor),
                            textStyle2("${businessInfoModel!.email}",
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
                            textStyle3("Member Since", TextAlign.center,
                                ColorManager.primaryColor),
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
                            textStyle3("Business City:", TextAlign.center,
                                ColorManager.primaryColor),
                            textStyle2("${businessInfoModel!.city}",
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
                            textStyle3("Business Address:", TextAlign.center,
                                ColorManager.primaryColor),
                            Expanded(
                                child: textStyle2(
                                    "${businessInfoModel!.address}",
                                    TextAlign.center,
                                    ColorManager.primaryColor)),
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
                            textStyle3("Business Province:", TextAlign.center,
                                ColorManager.primaryColor),
                            textStyle2("${businessInfoModel!.province}",
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
                            textStyle3("Membership Status:", TextAlign.center,
                                ColorManager.primaryColor),
                            Container(
                              height: 6.h,
                              width: 20.w,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s20),
                                color: businessInfoModel!.membershipStatus!
                                    ? ColorManager.greenColor
                                    : ColorManager.redColor,
                              ),
                              child: Center(
                                  child: textStyle2(
                                      businessInfoModel!.membershipStatus!
                                          ? "Active"
                                          : "Inactive",
                                      TextAlign.center,
                                      ColorManager.whiteColor)),
                            ),
                          ],
                        ),
                      ),

                      // buildSpaceVertical(10.h),
                      // InkWell(
                      //   onTap: () => Get.toNamed('/searchView'),
                      //   child: const LargeButton(
                      //       title:  StringsManager.searchMember,
                      //       color: ColorManager.primaryColor),
                      // )
                    ],
                  ),
                )
              : Center(
                  child: textStyle3("No Personal Info Available",
                      TextAlign.center, ColorManager.primaryColor)),
    );
  }
}
