import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandi_admin/views/profile/update_personal_profile.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/profile_controller.dart';
import '../../models/personal_info_model.dart';
import '../../utils/constants/assets_manager.dart';
import '../../utils/constants/color_manager.dart';
import '../../utils/constants/values_manager.dart';
import '../../utils/helpers/helper.dart';
import '../../utils/helpers/text_helper.dart';

class PersonalProfileScreen extends StatefulWidget {
  const PersonalProfileScreen({Key? key}) : super(key: key);

  @override
  State<PersonalProfileScreen> createState() => _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends State<PersonalProfileScreen> {
  final ProfileController _profileController = Get.put(ProfileController());
  PersonalInfoModel? personalInfoModel;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    personalInfoModel = await _profileController.getPersonalData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _profileController.isLoading.isTrue
          ? const Center(child: CircularProgressIndicator())
          : personalInfoModel != null
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      buildSpaceVertical(3.h),
                      personalInfoModel!.profileImage != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildSpaceHorizontal(20.w),
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: ColorManager.grayColor,
                                  backgroundImage: NetworkImage(
                                      personalInfoModel!.profileImage ?? ''),
                                ),
                                buildSpaceHorizontal(20.w),
                                IconButton(
                                  onPressed: () {
                                    Get.to(UpdatePersonalProfile(
                                        personalInfoModel: personalInfoModel!));
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
                                    Get.to(UpdatePersonalProfile(
                                        personalInfoModel: personalInfoModel!));
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
                            textStyle3("Personal Name:", TextAlign.center,
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
                            textStyle3("Personal No:", TextAlign.center,
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
                            textStyle3("Personal Email : ", TextAlign.center,
                                ColorManager.primaryColor),
                            Expanded(
                              child: textStyle2("${personalInfoModel!.email}",
                                  TextAlign.center, ColorManager.primaryColor),
                            ),
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
                            textStyle3("Personal CNIC", TextAlign.center,
                                ColorManager.primaryColor),
                            textStyle2("${personalInfoModel!.cnicNo}",
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
                            textStyle3("Personal City:", TextAlign.center,
                                ColorManager.primaryColor),
                            textStyle2("${personalInfoModel!.city}",
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
                            textStyle3("Personal Address:", TextAlign.center,
                                ColorManager.primaryColor),
                            textStyle2("${personalInfoModel!.address}",
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
                            textStyle3("Personal Province:", TextAlign.center,
                                ColorManager.primaryColor),
                            textStyle2("${personalInfoModel!.province}",
                                TextAlign.center, ColorManager.primaryColor),
                          ],
                        ),
                      ),

                      // buildSpaceVertical(10.h),
                    ],
                  ),
                )
              : Center(
                  child: textStyle3("No Personal Info Available",
                      TextAlign.center, ColorManager.primaryColor)),
    );
  }
}
