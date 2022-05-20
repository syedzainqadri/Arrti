
import 'package:apni_mandi/models/onboarding_info_model.dart';
import 'package:apni_mandi/utils/constants/assets_manager.dart';
import 'package:apni_mandi/utils/constants/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var selectedPageIndex = 0.obs;
  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;
  var pageController = PageController();

  forwardAction() {
    if (isLastPage) {
      Get.toNamed('/authView');
    } else {
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    }
  }

  List<OnboardingInfoModel> onboardingPages = [
    OnboardingInfoModel(AssetImages.splash1, StringsManager.splash1Title),
    OnboardingInfoModel(AssetImages.splash2, StringsManager.splash2Title),
    OnboardingInfoModel(AssetImages.splash3, StringsManager.splash3Title)
  ];

}