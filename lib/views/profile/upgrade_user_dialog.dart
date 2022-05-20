

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../controllers/add_payment_controller.dart';
import '../../utils/constants/color_manager.dart';
import '../../utils/constants/strings_manager.dart';
import '../../utils/constants/values_manager.dart';
import '../../utils/helpers/helper.dart';
import '../../utils/helpers/text_helper.dart';
import '../../widgets/large_button.dart';
import '../../widgets/text_field.dart';

class UpgradeUserDialog extends StatelessWidget {
   UpgradeUserDialog({Key? key}) : super(key: key);

  final phoneController = TextEditingController();
  final transIDController = TextEditingController();

   final AddPaymentController paymentController = Get.put(AddPaymentController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: ColorManager.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        height: 45.h,
        width: 100.w,
        child: Column(
          children: [
            buildSpaceVertical(2.h),
            textStyle2("To Upgrade to Premium account\nSend Rs.1000 to 03129834567 ", TextAlign.center, ColorManager.grayColor),
            buildSpaceVertical(2.h),
            GetTextField(
              controller: phoneController,
              hintName: StringsManager.phoneNo,
              icon: Icons.call_rounded,
              inputType: TextInputType.phone,
              inputLength: 11,
            ),
            buildSpaceVertical(2.h),
            GetTextField(
              controller: transIDController,
              hintName: "ENTER TRANSACTION ID",
              icon: Icons.attach_money,
              inputType: TextInputType.text,
              inputLength: 10,
            ),
            InkWell(
              onTap: (){
                if(phoneController.text.isNotEmpty && transIDController.text.isNotEmpty){
                  paymentController.addPaymentData(phoneController.text, transIDController.text);
                }
              },
              child: Center(
                child: Container(
                  height: 6.h,
                  width: 53.w,
                  decoration: BoxDecoration(
                    color: ColorManager.primaryColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.primaryColor.withOpacity(0.2),
                        spreadRadius: 4,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Obx(() {
                    return  paymentController.isLoading.isTrue ?
                    Center(
                      child: Container(
                          height: 7.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s26),
                            color: ColorManager.primaryColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(AppSize.s0_5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: const Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: const Center(child: CupertinoActivityIndicator())),
                    )
                        : const LargeButton(
                        title:  "Upgrade",
                        color: ColorManager.primaryColor);
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
