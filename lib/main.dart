
import 'package:firebase_auth_app/utils/strings_manager.dart';
import 'package:firebase_auth_app/utils/values_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constants/firebase_constants.dart';
import 'controllers/email_auth_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialization.then((value) {
    Get.put(EmailAuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: StringsManager.appName,
      debugShowCheckedModeBanner: false,
      home: Center(
        child: CupertinoActivityIndicator(radius: AppSize.s16),
      ),
    );
  }
}


