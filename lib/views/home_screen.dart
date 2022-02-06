import 'package:firebase_auth_app/controllers/email_auth_controller.dart';
import 'package:firebase_auth_app/utils/color_manager.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => EmailAuthController.authInstance.signOut(),
                child: Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}
