import 'package:apni_mandi/controllers/auth_controller.dart';
import 'package:apni_mandi/utils/constants/color_manager.dart';
import 'package:apni_mandi/utils/constants/values_manager.dart';
import 'package:apni_mandi/utils/helpers/helper.dart';
import 'package:apni_mandi/views/profile/business_profile_screen.dart';
import 'package:apni_mandi/views/profile/personal_profile_screen.dart';
import 'package:apni_mandi/views/profile/upgrade_user_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/profile_controller.dart';
import '../../models/business_info_model.dart';
import '../../utils/helpers/text_helper.dart';
import '../../widgets/large_button.dart';
import 'package:get/get.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  BusinessInfoModel? businessInfoModel;

  @override
  void initState() {
    super.initState();
    getData();
    _controller = TabController(length: 2, vsync: this);
  }

  final ProfileController _profileController = Get.put(ProfileController());
  final AuthController _authController = Get.put(AuthController());
  getData() async {
    businessInfoModel = await _profileController.getBusinessData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.whiteColor,
        // appBar: buildAppBar(),
        body: Column(
          children: [
            // buildSpaceVertical(3.h),
            Container(
              height: 50,
              width: Get.width,
              child: Row(
                children: [
                  Container(
                    height: 5.h,
                    width: 20.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSize.s20),
                      color: businessInfoModel!.membershipStatus!
                          ? ColorManager.primaryColor
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
                  const Spacer(),
                  textStyle3(
                      "Profile", TextAlign.center, ColorManager.primaryColor),
                  const Spacer(),
                  businessInfoModel != null
                      ? businessInfoModel!.membershipStatus != false
                          ? IconButton(
                              onPressed: () async {
                                Get.toNamed('/allUsers');
                              },
                              icon: const Icon(
                                Icons.search,
                                color: ColorManager.primaryColor,
                              ),
                            )
                          : const SizedBox()
                      : const SizedBox()
                ],
              ),
            ),
            buildSpaceVertical(3.h),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p6, horizontal: AppPadding.p12),
              child: TabBar(
                isScrollable: true,
                indicator: BoxDecoration(
                    color: ColorManager.primaryColor,
                    borderRadius: BorderRadius.circular(AppSize.s22)),
                controller: _controller,
                unselectedLabelColor: ColorManager.blackColor,
                unselectedLabelStyle:
                    const TextStyle(color: ColorManager.blackColor),
                tabs: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      height: 5.h,
                      child: Tab(
                        child: Text(
                          "Personal Profile",
                          style: GoogleFonts.openSans(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                      height: 5.h,
                      child: Tab(
                        child: Text(
                          "Business Profile",
                          style: GoogleFonts.openSans(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            buildSpaceVertical(2.h),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.62,
              width: MediaQuery.of(context).size.width,
              child: TabBarView(
                controller: _controller,
                children: const [
                  PersonalProfileScreen(),
                  BusinessProfileScreen()
                ],
              ),
            ),
            buildSpaceVertical(1.h),
            businessInfoModel != null
                ? businessInfoModel!.membershipStatus != true
                    ? SizedBox(
                        height: 8.h,
                        width: double.infinity,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              barrierColor: Colors.black26,
                              context: context,
                              builder: (context) {
                                return UpgradeUserDialog();
                              },
                            );
                          },
                          child: const LargeButton(
                              title: "Upgrade to Premium",
                              color: ColorManager.primaryColor),
                        ),
                      )
                    : const SizedBox()
                : const SizedBox(),
          ],
        ),
        // bottomSheet: SizedBox(
        //   height: 8.h,
        //   width: double.infinity,
        //   child: InkWell(
        //     onTap: () {
        //       showDialog(
        //         barrierColor: Colors.black26,
        //         context: context,
        //         builder: (context) {
        //           return UpgradeUserDialog();
        //         },
        //       );
        //     },
        //     child: const LargeButton(
        //         title: "Upgrade to Premium", color: ColorManager.primaryColor),
        //   ),
        // ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle3("Profile", TextAlign.center, ColorManager.primaryColor),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
      actions: [
        businessInfoModel != null
            ? businessInfoModel!.membershipStatus != false
                ? IconButton(
                    onPressed: () async {
                      Get.toNamed('/allUsers');
                    },
                    icon: const Icon(
                      Icons.search,
                      color: ColorManager.primaryColor,
                    ),
                  )
                : SizedBox()
            : SizedBox()
      ],
    );
  }
}
