

import 'package:apni_mandi/utils/constants/color_manager.dart';
import 'package:apni_mandi/utils/constants/strings_manager.dart';
import 'package:apni_mandi/utils/constants/values_manager.dart';
import 'package:apni_mandi/utils/helpers/helper.dart';
import 'package:apni_mandi/views/profile/business_profile_screen.dart';
import 'package:apni_mandi/views/profile/personal_profile_screen.dart';
import 'package:apni_mandi/views/profile/upgrade_user_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../utils/helpers/text_helper.dart';
import '../../widgets/large_button.dart';

class WaitingScreen extends StatefulWidget {
   const WaitingScreen({Key? key}) : super(key: key);

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorManager.whiteColor,
      appBar: buildAppBar(),
      body: Column(
        children: [
          buildSpaceVertical(3.h),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p6, horizontal: AppPadding.p12),
            child: TabBar(
              isScrollable: true,
              indicator: BoxDecoration(color: ColorManager.primaryColor, borderRadius: BorderRadius.circular(AppSize.s22)),
              controller: _controller,
              unselectedLabelColor: ColorManager.blackColor,
              unselectedLabelStyle: const TextStyle(color: ColorManager.blackColor),
              tabs: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: 5.h,
                    child: Tab(
                      child: Text("Personal Profile", style: GoogleFonts.openSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),),
                    )
                ),

                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: 5.h,
                    child: Tab(
                      child: Text("Business Profile", style: GoogleFonts.openSans(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),),
                    )
                ),
              ],
            ),
          ),
          buildSpaceVertical(2.h),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.73,
            width: MediaQuery.of(context).size.width,
            child: TabBarView(
              controller: _controller,
              children: const [
                PersonalProfileScreen(),
                BusinessProfileScreen()
              ],
            ),
          ),
          buildSpaceVertical(4.h),
        ],
      ),
      bottomSheet: SizedBox(
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
              title:  "Upgrade to Premium",
              color: ColorManager.primaryColor),
        ),
      ),

    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: textStyle3("Profile", TextAlign.center, ColorManager.primaryColor),
      centerTitle: true,
      backgroundColor: ColorManager.whiteColor,
      elevation: 0.5,
    );
  }
}
