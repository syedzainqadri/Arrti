
import 'dart:io';
import 'package:apni_mandi/controllers/business_profile_completion_controller.dart';
import 'package:apni_mandi/utils/constants/assets_manager.dart';
import 'package:apni_mandi/utils/constants/color_manager.dart';
import 'package:apni_mandi/utils/constants/strings_manager.dart';
import 'package:apni_mandi/utils/constants/values_manager.dart';
import 'package:apni_mandi/utils/helpers/helper.dart';
import 'package:apni_mandi/utils/helpers/text_helper.dart';
import 'package:apni_mandi/widgets/large_button.dart';
import 'package:apni_mandi/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';


class BusinessProfileCompletion extends StatefulWidget {
  const BusinessProfileCompletion({Key? key}) : super(key: key);

  @override
  State<BusinessProfileCompletion> createState() => _BusinessProfileCompletionState();
}

class _BusinessProfileCompletionState extends State<BusinessProfileCompletion> {

  final businessNameController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final ntnController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? selectedCity;
  String? selectedProvince;
  String? selectedDistrict;
  String? selectedMandi;
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('dd-MM-yyyy');
  String? formatted;


  List<DropdownMenuItem<String>> cities = const [
    DropdownMenuItem(child: Text("Islamabad"), value: "Islamabad"),
    DropdownMenuItem(child: Text("Rawalpindi"), value: "Rawalpindi"),
    DropdownMenuItem(child: Text("Lahore"), value: "Lahore"),
    DropdownMenuItem(child: Text("Peshawar"), value: "Peshawar"),
    DropdownMenuItem(child: Text("Swabi"), value: "Swabi"),
  ];

  List<DropdownMenuItem<String>> mandees = const [
    DropdownMenuItem(child: Text("Islamabad Mandi"), value: "Islamabad Mandi"),
    DropdownMenuItem(child: Text("Rawalpindi Mandi"), value: "Rawalpindi Mandi"),
    DropdownMenuItem(child: Text("Lahore Mandi"), value: "Lahore Mandi"),
    DropdownMenuItem(child: Text("Peshawar Mandi"), value: "Peshawar Mandi"),
    DropdownMenuItem(child: Text("Swabi Mandi"), value: "Swabi Mandi"),
  ];

  List<DropdownMenuItem<String>> provinces = const [
    DropdownMenuItem(child: Text("Punjab"), value: "Punjab"),
    DropdownMenuItem(child: Text("Khyber Pukhtunkhwa"), value: "Khyber Pukhtunkhwa"),
    DropdownMenuItem(child: Text("Sindh"), value: "Sindh"),
    DropdownMenuItem(child: Text("Baluchistan"), value: "Baluchistan"),
  ];

  File? galleryImage;
  File? cameraImage;
  final picker = ImagePicker();

  final BusinessProfileCompletionController _profileCompletionController = Get.put(BusinessProfileCompletionController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildSpaceVertical(5.h),
              Center(
                child: textStyle7(
                    StringsManager.businessPC,
                    TextAlign.center,
                    ColorManager.primaryColor),
              ),
              buildSpaceVertical(1.5.h),
              Center(
                child: textStyle2(
                    StringsManager.businessPCText,
                    TextAlign.center,
                    ColorManager.grayColor),
              ),
              buildSpaceVertical(2.h),

              SizedBox(
                height: 18.h,
                width: 36.w,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    cameraImage != null ?
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: ColorManager.grayColor,
                      backgroundImage: FileImage(cameraImage!),
                    )
                        : galleryImage != null ?
                    CircleAvatar(
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

              buildSpaceVertical(5.h),

              GetTextField(
                controller: businessNameController,
                hintName: StringsManager.bName,
                icon: Icons.business,
              ),
              // buildSpaceVertical(1.h),

              GetTextField(
                controller: addressController,
                hintName: StringsManager.address,
                icon: Icons.home,
                inputLines: 4,
                inputLength: 300,
              ),
              // buildSpaceVertical(1.h),

              GetTextField(
                controller: emailController,
                hintName: StringsManager.email,
                icon: Icons.email,
                inputType: TextInputType.emailAddress,
                inputLength: 20,
              ),
              // buildSpaceVertical(1.h),

              GetTextField(
                controller: phoneController,
                hintName: StringsManager.phoneNo,
                icon: Icons.call_rounded,
                inputType: TextInputType.phone,
                inputLength: 11,
              ),
              // buildSpaceVertical(1.h),

              GetTextField(
                controller: ntnController,
                hintName: StringsManager.ntnNo,
                icon: Icons.credit_card,
                inputType: TextInputType.number,
                inputLength: 8,
              ),
              // buildSpaceVertical(1.h),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
                        borderSide: BorderSide(color: ColorManager.primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
                        borderSide: BorderSide(color: ColorManager.primaryColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
                        borderSide: BorderSide(color: ColorManager.redColor),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
                        borderSide: BorderSide(color: ColorManager.redColor),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
                        borderSide: BorderSide(color: ColorManager.primaryColor),
                      ),
                      filled: true,
                      fillColor: ColorManager.whiteColor,
                    ),
                    validator: (value) => value == null ?  StringsManager.sCity: null,
                    dropdownColor: ColorManager.whiteColor,
                    hint: const Text(StringsManager.sCity),
                    value: selectedCity,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCity = newValue!;
                      });
                    },
                    items: cities
                ),
              ),
              buildSpaceVertical(2.h),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
                        borderSide: BorderSide(color: ColorManager.primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
                        borderSide: BorderSide(color: ColorManager.primaryColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
                        borderSide: BorderSide(color: ColorManager.redColor),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
                        borderSide: BorderSide(color: ColorManager.redColor),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
                        borderSide: BorderSide(color: ColorManager.primaryColor),
                      ),
                      filled: true,
                      fillColor: ColorManager.whiteColor,
                    ),
                    validator: (value) => value == null ?  StringsManager.sProvince: null,
                    dropdownColor: ColorManager.whiteColor,
                    hint: const Text(StringsManager.sProvince),
                    value: selectedProvince,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedProvince = newValue!;
                      });
                    },
                    items: provinces
                ),
              ),
              buildSpaceVertical(2.h),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
                        borderSide: BorderSide(color: ColorManager.primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
                        borderSide: BorderSide(color: ColorManager.primaryColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
                        borderSide: BorderSide(color: ColorManager.redColor),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
                        borderSide: BorderSide(color: ColorManager.redColor),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
                        borderSide: BorderSide(color: ColorManager.primaryColor),
                      ),
                      filled: true,
                      fillColor: ColorManager.whiteColor,
                    ),
                    validator: (value) => value == null ?  StringsManager.sDistrict: null,
                    dropdownColor: ColorManager.whiteColor,
                    hint: const Text(StringsManager.sDistrict),
                    value: selectedDistrict,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDistrict = newValue!;
                      });
                    },
                    items: cities
                ),
              ),
              buildSpaceVertical(2.h),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
                child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
                        borderSide: BorderSide(color: ColorManager.primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
                        borderSide: BorderSide(color: ColorManager.primaryColor),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
                        borderSide: BorderSide(color: ColorManager.redColor),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
                        borderSide: BorderSide(color: ColorManager.redColor),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
                        borderSide: BorderSide(color: ColorManager.primaryColor),
                      ),
                      filled: true,
                      fillColor: ColorManager.whiteColor,
                    ),
                    validator: (value) => value == null ?  StringsManager.sMandi: null,
                    dropdownColor: ColorManager.whiteColor,
                    hint: const Text(StringsManager.sMandi),
                    value: selectedMandi,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMandi = newValue!;
                      });
                    },
                    items: mandees
                ),
              ),
              buildSpaceVertical(4.h),

              InkWell(
                onTap: () {
                  if(_formKey.currentState!.validate()){
                    _formKey.currentState!.save();
                    formatted = formatter.format(now);

                    if(cameraImage != null){
                      _profileCompletionController.uploadData(businessNameController.text.trim(), addressController.text.trim(),
                          emailController.text.trim(), phoneController.text.trim(), ntnController.text.trim(),
                      selectedCity!, selectedProvince!, selectedDistrict!, selectedMandi!, formatted!, cameraImage!);
                    }else if(galleryImage != null){
                      _profileCompletionController.uploadData(businessNameController.text.trim(), addressController.text.trim(),
                          emailController.text.trim(), phoneController.text.trim(), ntnController.text.trim(),
                          selectedCity!, selectedProvince!, selectedDistrict!, selectedMandi!, formatted!, galleryImage!);
                    }else{
                      errorToast(StringsManager.error, StringsManager.noPic);
                    }


                  }
                },
                child: Obx(() {
                  return  _profileCompletionController.isLoading.isTrue ?
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
                      title:  StringsManager.continued,
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

  imagePickerDialog(){
    Get.bottomSheet(
      Container(
          height: 17.h,
          color: ColorManager.primaryColor,
          child:Column(
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
                      Icon(Icons.add_a_photo, size: 4.h, color: ColorManager.whiteColor),
                      textStyle2(StringsManager.camera, TextAlign.right, ColorManager.whiteColor),
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
                      Icon(Icons.add_photo_alternate_outlined, size: 4.h, color: ColorManager.whiteColor),
                      textStyle2(StringsManager.gallery, TextAlign.right, ColorManager.whiteColor),
                    ],
                  ),
                ),
              ),
              buildSpaceVertical(2.h),
            ],
          )
      ),
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
