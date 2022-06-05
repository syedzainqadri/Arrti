import 'dart:io';
import '../../../controllers/personal_profile_completion_controller.dart';
import '../../../utils/constants/assets_manager.dart';
import '../../../utils/constants/color_manager.dart';
import '../../../utils/constants/strings_manager.dart';
import '../../../utils/constants/values_manager.dart';
import '../../../utils/helpers/citeis_ProvincesList.dart';
import '../../../utils/helpers/helper.dart';
import '../../../utils/helpers/text_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../widgets/large_button.dart';
import '../../../widgets/text_field.dart';

class PersonalProfileCompletion extends StatefulWidget {
  const PersonalProfileCompletion({Key? key}) : super(key: key);

  @override
  State<PersonalProfileCompletion> createState() =>
      _PersonalProfileCompletionState();
}

class _PersonalProfileCompletionState extends State<PersonalProfileCompletion> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final cnicController = TextEditingController();
  final addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? selectedCity;
  String? selectedPro;

  File? galleryImage;
  File? cameraImage;
  final picker = ImagePicker();

  final PersonalProfileCompletionController _profileCompletionController =
      Get.put(PersonalProfileCompletionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildSpaceVertical(8.h),
              Center(
                child: textStyle7(StringsManager.personalPC, TextAlign.center,
                    ColorManager.primaryColor),
              ),
              buildSpaceVertical(1.5.h),
              Center(
                child: textStyle2(StringsManager.personalPCText,
                    TextAlign.center, ColorManager.grayColor),
              ),
              buildSpaceVertical(2.h),

              SizedBox(
                height: 18.h,
                width: 36.w,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    cameraImage != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundColor: ColorManager.grayColor,
                            backgroundImage: FileImage(cameraImage!),
                          )
                        : galleryImage != null
                            ? CircleAvatar(
                                radius: 50,
                                backgroundColor: ColorManager.grayColor,
                                backgroundImage: FileImage(galleryImage!),
                              )
                            : const CircleAvatar(
                                radius: 50,
                                backgroundColor: ColorManager.grayColor,
                                backgroundImage: AssetImage(AssetImages.avatar),
                              ),
                    Positioned(
                      right: -2,
                      bottom: 2,
                      child: SizedBox(
                        height: 36,
                        width: 36,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                              side: const BorderSide(color: Colors.white),
                            ),
                            primary: ColorManager.whiteColor,
                            backgroundColor: ColorManager.grayColor,
                          ),
                          onPressed: () => imagePickerDialog(),
                          child: const Icon(Icons.camera_alt),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              buildSpaceVertical(3.h),

              GetTextField(
                controller: firstNameController,
                hintName: StringsManager.fName,
                icon: Icons.person,
              ),
              // buildSpaceVertical(2.h),

              GetTextField(
                controller: lastNameController,
                hintName: StringsManager.lName,
                icon: Icons.person,
              ),
              // buildSpaceVertical(2.h),

              GetTextField(
                controller: emailController,
                hintName: StringsManager.email,
                icon: Icons.email,
                inputType: TextInputType.emailAddress,
              ),
              // buildSpaceVertical(2.h),

              GetTextField(
                controller: phoneController,
                hintName: StringsManager.phoneNo,
                icon: Icons.call_rounded,
                inputType: TextInputType.phone,
                inputLength: 11,
              ),
              // buildSpaceVertical(2.h),

              GetTextField(
                controller: cnicController,
                hintName: StringsManager.cnicNo,
                icon: Icons.credit_card,
                inputType: TextInputType.number,
                inputLength: 13,
              ),
              // buildSpaceVertical(2.h),
              Container(
                margin: const EdgeInsets.all(20),
                width: Get.width,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorManager.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: DropdownButton<String>(
                      alignment: Alignment.center,
                      underline: Container(),
                      hint: const Text('  Select province'),
                      value: selectedPro,
                      items: pAKprovince.map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedCity = null;
                          cities = val == "Islamabad"
                              ? iCity
                              : val == 'punjab'
                                  ? pCity
                                  : val == 'sindh'
                                      ? sCity
                                      : val == 'KPK'
                                          ? kCity
                                          : bCity;
                          selectedPro = val!;
                        });
                      }),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                width: Get.width,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorManager.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: DropdownButton<String>(
                      menuMaxHeight: Get.height * 0.7,
                      alignment: Alignment.center,
                      underline: Container(),
                      hint: const Text('   Select city'),
                      value: selectedCity,
                      items: cities.map((e) {
                        return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedCity = val!;
                        });
                      }),
                ),
              ),

              buildSpaceVertical(2.h),

              GetTextField(
                controller: addressController,
                hintName: StringsManager.address,
                icon: Icons.home,
                inputLines: 1,
                inputLength: 300,
              ),
              buildSpaceVertical(2.h),

              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    if (cameraImage != null) {
                      _profileCompletionController.uploadData(
                          firstNameController.text.trim(),
                          lastNameController.text.trim(),
                          emailController.text.trim(),
                          phoneController.text.trim(),
                          cnicController.text.trim(),
                          selectedPro!,
                          selectedCity!,
                          addressController.text.trim(),
                          cameraImage!);
                    } else if (galleryImage != null) {
                      _profileCompletionController.uploadData(
                          firstNameController.text.trim(),
                          lastNameController.text.trim(),
                          emailController.text.trim(),
                          phoneController.text.trim(),
                          cnicController.text.trim(),
                          selectedPro!,
                          selectedCity!,
                          addressController.text.trim(),
                          galleryImage!);
                    } else {
                      errorToast(StringsManager.error, StringsManager.noPic);
                    }
                  }
                },
                child: Obx(() {
                  return _profileCompletionController.isLoading.isTrue
                      ? Center(
                          child: Container(
                              height: 7.h,
                              width: 60.w,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s26),
                                color: ColorManager.primaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.grey.withOpacity(AppSize.s0_5),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: const Center(
                                  child: CupertinoActivityIndicator())),
                        )
                      : const LargeButton(
                          title: StringsManager.continued,
                          color: ColorManager.primaryColor);
                }),
              ),

              buildSpaceVertical(4.h),
            ],
          ),
        ),
      ),
    );
  }

  imagePickerDialog() {
    Get.bottomSheet(
      Container(
          height: 17.h,
          color: ColorManager.primaryColor,
          child: Column(
            children: [
              buildSpaceVertical(2.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: InkWell(
                  onTap: () {
                    Get.back();
                    getCameraImage();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.add_a_photo,
                          size: 4.h, color: ColorManager.whiteColor),
                      textStyle2(StringsManager.camera, TextAlign.right,
                          ColorManager.whiteColor),
                    ],
                  ),
                ),
              ),
              buildSpaceVertical(1.h),
              const Divider(color: ColorManager.whiteColor, thickness: 2),
              buildSpaceVertical(1.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: InkWell(
                  onTap: () {
                    Get.back();
                    getGalleryImage();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.add_photo_alternate_outlined,
                          size: 4.h, color: ColorManager.whiteColor),
                      textStyle2(StringsManager.gallery, TextAlign.right,
                          ColorManager.whiteColor),
                    ],
                  ),
                ),
              ),
              buildSpaceVertical(2.h),
            ],
          )),
      enableDrag: false,
    );
  }

  Future getGalleryImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        galleryImage = File(pickedFile.path);
      } else {
        errorToast(StringsManager.error, StringsManager.noImage);
      }
    });
  }

  Future getCameraImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        cameraImage = File(pickedFile.path);
      } else {
        errorToast(StringsManager.error, StringsManager.noImage);
      }
    });
  }
}
