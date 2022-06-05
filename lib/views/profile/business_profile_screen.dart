import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandi_admin/views/profile/update_business_profile.dart';
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
                      businessInfoModel!.phoneNo != null
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textStyle3("Phone Number ", TextAlign.center,
                                      ColorManager.primaryColor),
                                  textStyle2(
                                      "${businessInfoModel!.phoneNo}",
                                      TextAlign.center,
                                      ColorManager.primaryColor),
                                ],
                              ),
                            )
                          : SizedBox(),
                      businessInfoModel!.phoneNo != ""
                          ? buildSpaceVertical(2.h)
                          : SizedBox(),
                      businessInfoModel!.phoneNo01 != null
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textStyle3("Phone Number ", TextAlign.center,
                                      ColorManager.primaryColor),
                                  textStyle2(
                                      "${businessInfoModel!.phoneNo01}",
                                      TextAlign.center,
                                      ColorManager.primaryColor),
                                ],
                              ),
                            )
                          : SizedBox(),
                      businessInfoModel!.phoneNo01 != null
                          ? buildSpaceVertical(2.h)
                          : SizedBox(),
                      businessInfoModel!.phoneNo02 != null
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: AppPadding.p20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textStyle3("Phone Number", TextAlign.center,
                                      ColorManager.primaryColor),
                                  textStyle2(
                                      "${businessInfoModel!.phoneNo02}",
                                      TextAlign.center,
                                      ColorManager.primaryColor),
                                ],
                              ),
                            )
                          : SizedBox(),
                      businessInfoModel!.phoneNo02 != null
                          ? buildSpaceVertical(2.h)
                          : SizedBox(),
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
                            textStyle3("Business Country:", TextAlign.center,
                                ColorManager.primaryColor),
                            Expanded(
                                child: textStyle2(
                                    "${businessInfoModel!.district}",
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
                            textStyle3("Business State:", TextAlign.center,
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
                            textStyle3("Business City:", TextAlign.center,
                                ColorManager.primaryColor),
                            Expanded(
                                child: textStyle2(
                                    "${businessInfoModel!.city}",
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
                            textStyle3("Business Mandi:", TextAlign.center,
                                ColorManager.primaryColor),
                            textStyle2("${businessInfoModel!.mandiName}",
                                TextAlign.center, ColorManager.primaryColor),
                          ],
                        ),
                      ),
                      buildSpaceVertical(4.h),
                      buildSpaceVertical(2.h),
                    ],
                  ),
                )
              : Center(
                  child: textStyle3("No Personal Info Available",
                      TextAlign.center, ColorManager.primaryColor)),
    );
  }
}
