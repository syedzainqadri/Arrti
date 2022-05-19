import 'package:apni_mandi/controllers/onboarding_controller.dart';
import 'package:apni_mandi/utils/constants/color_manager.dart';
import 'package:apni_mandi/utils/constants/strings_manager.dart';
import 'package:apni_mandi/utils/constants/values_manager.dart';
import 'package:apni_mandi/utils/helpers/helper.dart';
import 'package:apni_mandi/views/onBoarding/components/build_dot.dart';
import 'package:apni_mandi/views/onBoarding/components/splash_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = OnboardingController();
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 6,
                  child: PageView.builder(
                      controller: _controller.pageController,
                      onPageChanged: _controller.selectedPageIndex,
                      itemCount: _controller.onboardingPages.length,
                      itemBuilder: (context, index) {
                        return SplashContent(
                          image: _controller.onboardingPages[index].imageAsset,
                          text: _controller.onboardingPages[index].title,
                        );
                      }),
              ),

              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                  child: Column(
                    children: <Widget>[
                      buildSpaceVertical(5.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _controller.onboardingPages.length, (index) => Obx(() {
                            return buildDot(index: index, current: _controller.selectedPageIndex.value);
                          }),
                        ),
                      ),
                      buildSpaceVertical(5.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 20, color: ColorManager.secondaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          minimumSize: Size(50.w, 6.h),
                          primary: ColorManager.primaryColor,
                        ),
                        onPressed: _controller.forwardAction,
                        child: Obx(() {
                          return Text(_controller.isLastPage ? StringsManager.start : StringsManager.next);
                        }),
                      ),
                      buildSpaceVertical(5.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
