
import 'dart:async';
import 'package:apni_mandi/utils/constants/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

import '../../controllers/profile_controller.dart';
import '../../models/business_info_model.dart';
import '../../models/personal_info_model.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  var duration = const Duration(milliseconds: 2000);
  late Tween<double> _tweenSize;
  late Animation<double> _animationSize;
  late AnimationController _animationController;
  final ProfileController _profileController = Get.put(ProfileController());
  PersonalInfoModel? personalInfoModel;
  BusinessInfoModel? businessInfoModel;

  String? userId;
  int? initScreen;
  @override
  void initState() {
    super.initState();
    getData();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _tweenSize = Tween(begin: 20, end: 180);
    _animationSize = _tweenSize.animate(_animationController);
    _animationController.forward();
    startTime();
  }

  getData() async{
    personalInfoModel = await _profileController.getPersonalData();
    businessInfoModel = await _profileController.getBusinessData();
    setState(() { });
  }

  startTime() async {
    return Timer(duration, route);
  }

  route() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString("userId");
    initScreen = prefs.getInt("initScreen");
    await prefs.setInt("initScreen", 1);
    if(initScreen == 0 || initScreen == null){
      Get.toNamed('/onBoarding');
    }else if(userId != null){
      if(personalInfoModel != null && businessInfoModel != null ){
        Get.offNamed('/waitingView');
      }else if(personalInfoModel == null){
        Get.offNamed('/waitingView');
      }else if(businessInfoModel == null){
        Get.offNamed('/waitingView');
      }else{
        Get.offNamed('/personalPC');
      }
    }else{
      Get.toNamed('/authView');
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
            animation: _animationSize,
            builder: (context, child) {
              return Image.asset(
                  AssetImages.logo,
                  height: _animationSize.value.h,
                  width: _animationSize.value.w
              );
            }),
      ),
    );
  }
}