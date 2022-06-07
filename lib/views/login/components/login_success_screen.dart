import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../controllers/profile_controller.dart';
import '../../../models/business_info_model.dart';
import '../../../models/personal_info_model.dart';
import '../../../utils/constants/assets_manager.dart';
import '../../../utils/constants/color_manager.dart';
import '../../../utils/constants/strings_manager.dart';
import '../../../utils/constants/values_manager.dart';
import '../../../utils/helpers/helper.dart';
import '../../../utils/helpers/text_helper.dart';

class LoginSuccessScreen extends StatefulWidget {
  const LoginSuccessScreen({Key? key}) : super(key: key);

  @override
  State<LoginSuccessScreen> createState() => _LoginSuccessScreenState();
}

class _LoginSuccessScreenState extends State<LoginSuccessScreen> {
  late Timer timer;
  final ProfileController _profileController = Get.put(ProfileController());
  PersonalInfoModel? personalInfoModel;
  BusinessInfoModel? businessInfoModel;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    personalInfoModel = await _profileController.getPersonalData();
    businessInfoModel = await _profileController.getBusinessData();

    if (personalInfoModel != null && businessInfoModel != null) {
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        Get.offNamed('/waitingView');
      });
    } else if (personalInfoModel == null) {
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        Get.offNamed('/personalPC');
      });
    } else if (businessInfoModel == null) {
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        Get.offNamed('/businessPC');
      });
    } else {
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        Get.offNamed('/personalPC');
      });
    }
    setState(() {});
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildSpaceVertical(10.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
            child: Image.asset(AssetImages.success, height: 50.h),
          ),
          buildSpaceVertical(10.h),
          textStyle5(StringsManager.loginSuccess, TextAlign.center,
              ColorManager.primaryColor),
        ],
      ),
    );
  }
}
