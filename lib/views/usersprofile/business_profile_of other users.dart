import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/profile_controller.dart';
import '../../models/user_business_info_model.dart';
import '../../utils/constants/assets_manager.dart';
import '../../utils/constants/color_manager.dart';
import '../../utils/constants/values_manager.dart';
import '../../utils/helpers/helper.dart';
import '../../utils/helpers/text_helper.dart';

class BussinessProfileofotherusers extends StatefulWidget {
  String uid;
  BussinessProfileofotherusers(this.uid, {Key? key}) : super(key: key);

  @override
  State<BussinessProfileofotherusers> createState() =>
      _BussinessProfileofotherusersState();
}

class _BussinessProfileofotherusersState
    extends State<BussinessProfileofotherusers> {
  final ProfileController _profileController = Get.put(ProfileController());
  UserBusinessInfoModel? userBusinessInfoModel;

  @override
  void initState() {
    super.initState();
    getData(widget.uid);
  }

  getData(usersId) async {
    userBusinessInfoModel =
        await _profileController.getUsersBusinessData(usersId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorManager.primaryColor,
          centerTitle: true,
          title: const Text("Profile")),
      body: _profileController.isLoading.isTrue
          ? const Center(child: CircularProgressIndicator())
          : userBusinessInfoModel != null
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      buildSpaceVertical(3.h),
                      userBusinessInfoModel!.profileImage != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buildSpaceHorizontal(20.w),
                                CircleAvatar(
                                  radius: 60,
                                  backgroundColor: ColorManager.grayColor,
                                  backgroundImage: NetworkImage(
                                      userBusinessInfoModel!.profileImage ??
                                          ''),
                                ),
                                buildSpaceHorizontal(20.w),
                                userBusinessInfoModel!.isPresidence == true
                                    ? textStyle2("President", TextAlign.center,
                                        ColorManager.primaryColor)
                                    : SizedBox(),
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
                                //     Get.to(UpdateBusinessProfile(
                                //         businessInfoModel: businessInfoModel!));
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
                            textStyle3("Business Name:", TextAlign.center,
                                ColorManager.primaryColor),
                            textStyle2("${userBusinessInfoModel!.businessName}",
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
                            textStyle3("Business No:", TextAlign.center,
                                ColorManager.primaryColor),
                            textStyle2("${userBusinessInfoModel!.phoneNo}",
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
                            textStyle3("Business Email", TextAlign.center,
                                ColorManager.primaryColor),
                            textStyle2("${userBusinessInfoModel!.email}",
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
                            textStyle3("Member Since", TextAlign.center,
                                ColorManager.primaryColor),
                            textStyle2("${userBusinessInfoModel!.memberSince}",
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
                            textStyle3("Business City:", TextAlign.center,
                                ColorManager.primaryColor),
                            textStyle2("${userBusinessInfoModel!.city}",
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
                            textStyle3("Business Address:", TextAlign.center,
                                ColorManager.primaryColor),
                            Expanded(
                                child: textStyle2(
                                    "${userBusinessInfoModel!.address}",
                                    TextAlign.center,
                                    ColorManager.primaryColor)),
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
                            textStyle3("Business Province:", TextAlign.center,
                                ColorManager.primaryColor),
                            textStyle2("${userBusinessInfoModel!.province}",
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
                            textStyle3("Membership Status:", TextAlign.center,
                                ColorManager.primaryColor),
                            Container(
                              height: 6.h,
                              width: 20.w,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s20),
                                color: userBusinessInfoModel!.membershipStatus!
                                    ? ColorManager.greenColor
                                    : ColorManager.redColor,
                              ),
                              child: Center(
                                  child: textStyle2(
                                      userBusinessInfoModel!.membershipStatus!
                                          ? "Active"
                                          : "Inactive",
                                      TextAlign.center,
                                      ColorManager.whiteColor)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 40, bottom: 10),
                        child: Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: ColorManager.primaryColor),
                              onPressed: () async {
                                if (userBusinessInfoModel!.membershipStatus ==
                                    false) {
                                  var val = await updateToPremimum(widget.uid);
                                  if (val) {
                                    getData(widget.uid);
                                  }
                                } else {
                                  var val =
                                      await removeFromPremimum(widget.uid);
                                  if (val) {
                                    getData(widget.uid);
                                  }
                                }
                              },
                              child: userBusinessInfoModel!.membershipStatus !=
                                      true
                                  ? const Text("Add to premimum")
                                  : const Text("Remove premimum"),
                            ),
                            const Spacer(),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: ColorManager.primaryColor),
                                onPressed: () async {
                                  if (userBusinessInfoModel!.isPresidence ==
                                      false) {
                                    var val = await makePresedent(widget.uid);
                                    if (val) {
                                      setState(() {
                                        getData(widget.uid);
                                      });
                                    }
                                  } else {
                                    var val =
                                        await removeFromPremimum(widget.uid);
                                    if (val) {
                                      setState(() {
                                        getData(widget.uid);
                                      });
                                    }
                                  }
                                },
                                child:
                                    userBusinessInfoModel!.isPresidence != true
                                        ? const Text("Make presednet")
                                        : const Text("Remove presednet")),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : Center(
                  child: textStyle3("No Personal Info Available",
                      TextAlign.center, ColorManager.primaryColor)),
    );
  }

  updateToPremimum(userId) async {
    var val = await FirebaseFirestore.instance
        .collection("usersBusinessData")
        .doc(userId)
        .update({'membershipStatus': true});
    return val;
  }

  removeFromPremimum(userId) async {
    var val = await FirebaseFirestore.instance
        .collection("usersBusinessData")
        .doc(userId)
        .update({'membershipStatus': false});
    return val;
  }

  makePresedent(userId) async {
    var val = await FirebaseFirestore.instance
        .collection("usersBusinessData")
        .doc(userId)
        .update({'isPresidence': true});
    return val;
  }

  removePresedent(userId) async {
    var val = await FirebaseFirestore.instance
        .collection("usersBusinessData")
        .doc(userId)
        .update({'isPresidence': false});
    return val;
  }
}
