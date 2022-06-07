import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/profile_controller.dart';
import '../../models/Users_info_model.dart';
import '../../utils/constants/assets_manager.dart';
import '../../utils/constants/color_manager.dart';
import '../../utils/constants/values_manager.dart';
import '../../utils/helpers/helper.dart';
import '../../utils/helpers/text_helper.dart';

class PersonalProfileofOtherusers extends StatefulWidget {
  String uid;
  PersonalProfileofOtherusers(this.uid, {Key? key}) : super(key: key);

  @override
  State<PersonalProfileofOtherusers> createState() =>
      _PersonalProfileofOtherusersState();
}

class _PersonalProfileofOtherusersState
    extends State<PersonalProfileofOtherusers> {
  final ProfileController _profileController = Get.put(ProfileController());
  //PersonalInfoModel? personalInfoModel;
  UsersInfoModel? usersInfoModel;

  @override
  void initState() {
    super.initState();
    getData(widget.uid);
  }

  getData(id) async {
    usersInfoModel = await _profileController.userPersonalData(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _profileController.isLoading.isTrue
          ? const Center(child: CircularProgressIndicator())
          : usersInfoModel != null
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      buildSpaceVertical(3.h),
                      usersInfoModel!.profileImage != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildSpaceHorizontal(20.w),
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: ColorManager.grayColor,
                                  backgroundImage: NetworkImage(
                                      usersInfoModel!.profileImage ?? ''),
                                ),
                                buildSpaceHorizontal(20.w),
                                // IconButton(
                                //   onPressed: () {
                                //     Get.to(UpdatePersonalProfile(
                                //         personalInfoModel: personalInfoModel!));
                                //   },
                                //   icon: const Icon(
                                //     Icons.edit,
                                //     color: ColorManager.primaryColor,
                                //     size: 30,
                                //   ),
                                // )
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
                                // IconButton(
                                //   onPressed: () {
                                //     Get.to(UpdatePersonalProfile(
                                //         personalInfoModel: personalInfoModel!));
                                //   },
                                //   icon: const Icon(
                                //     Icons.edit,
                                //     color: ColorManager.primaryColor,
                                //     size: 30,
                                //   ),
                                // )
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
                                "${usersInfoModel!.firstName}  ${usersInfoModel!.lastName} ",
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
                            textStyle2("${usersInfoModel!.phoneNo}",
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
                              child: textStyle2("${usersInfoModel!.email}",
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
                            textStyle2("${usersInfoModel!.cnicNo}",
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
                            textStyle2("${usersInfoModel!.city}",
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
                            textStyle2("${usersInfoModel!.address}",
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
                            textStyle2("${usersInfoModel!.province}",
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
