import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../../controllers/search_controller.dart';
import '../../../utils/constants/color_manager.dart';
import '../../../utils/constants/strings_manager.dart';
import '../../../utils/constants/values_manager.dart';
import '../../../utils/helpers/helper.dart';
import '../../../utils/helpers/text_helper.dart';

class SearchMemberScreen extends StatefulWidget {
  const SearchMemberScreen({Key? key}) : super(key: key);

  @override
  State<SearchMemberScreen> createState() => _SearchMemberScreenState();
}

class _SearchMemberScreenState extends State<SearchMemberScreen> {
  final searchController = TextEditingController();

  QuerySnapshot? snapshot;
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildSpaceVertical(10.h),
          buildSearchField(),
          buildSpaceVertical(3.h),
          Expanded(
            child: snapshot != null
                ? ListView.separated(
                    itemCount: snapshot!.docs.length,
                    itemBuilder: (context, index) {
                      return buildSearchedCard(index);
                    },
                    separatorBuilder: (context, index) {
                      return buildLine();
                    })
                : textStyle2("No Member Found Search Member", TextAlign.center,
                    ColorManager.primaryColor),
          ),
        ],
      ),
    );
  }

  Padding buildLine() {
    return const Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
        child: Divider(
            color: ColorManager.blackColor, thickness: 1, height: AppSize.s28));
  }

  Column buildSearchedCard(int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: show
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textStyle2(StringsManager.businessName, TextAlign.center,
                        ColorManager.primaryColor),
                    textStyle2("${snapshot!.docs[index].get('businessName')}",
                        TextAlign.center, ColorManager.primaryColor),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textStyle2(StringsManager.name, TextAlign.center,
                        ColorManager.primaryColor),
                    textStyle2("${snapshot!.docs[index].get('firstName')}",
                        TextAlign.center, ColorManager.primaryColor),
                  ],
                ),
        ),
        buildSpaceVertical(1.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle2("Email:", TextAlign.center, ColorManager.primaryColor),
              textStyle2("${snapshot!.docs[index].get('email')}",
                  TextAlign.center, ColorManager.primaryColor),
            ],
          ),
        ),
        buildSpaceVertical(1.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle2(
                  "PhoneNo:", TextAlign.center, ColorManager.primaryColor),
              textStyle2("${snapshot!.docs[index].get('phoneNo')}",
                  TextAlign.center, ColorManager.primaryColor),
            ],
          ),
        ),
      ],
    );
  }

  Padding buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $StringsManager.search';
          }
          return null;
        },
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
            borderSide: BorderSide(color: ColorManager.primaryColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
            borderSide: BorderSide(color: ColorManager.primaryColor),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
            borderSide: BorderSide(color: ColorManager.redColor),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
            borderSide: BorderSide(color: ColorManager.redColor),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s22)),
            borderSide: BorderSide(color: ColorManager.primaryColor),
          ),
          suffixIcon: GetBuilder<SearchController>(
            init: SearchController(),
            builder: (val) {
              return InkWell(
                  onTap: () {
                    val.searchBusinessData(searchController.text).then((value) {
                      snapshot = value;
                      show = true;
                      setState(() {});
                      if (snapshot!.docs.isEmpty) {
                        val
                            .searchPersonalData(searchController.text)
                            .then((values) {
                          snapshot = values;
                          setState(() {});
                        });
                      }
                    });
                  },
                  child: const Icon(Icons.search,
                      color: ColorManager.primaryColor));
            },
          ),
          hintText: StringsManager.search,
          hintStyle: const TextStyle(fontSize: AppSize.s14),
          fillColor: ColorManager.whiteColor,
          filled: true,
        ),
      ),
    );
  }
}
