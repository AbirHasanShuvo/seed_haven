import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seed_haven/consts/colors.dart';
import 'package:seed_haven/consts/consts.dart';
import 'package:seed_haven/views/auth_screen/login_screen.dart';
import 'package:seed_haven/views/home_screen/home.dart';
import 'package:seed_haven/widgets_common/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //for state changing here use the function
  changeScreen() {
    Future.delayed(const Duration(milliseconds: 500), () {
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => LoginScreen());
        } else {
          Get.to(() => const Home());
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                icSplashBg,
                width: 300,
              ),
            ),
            // const SizedBox(
            //   height: 15,
            // ),
            applogoWidget(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              appname,
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),

            const Text(
              appversion,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const Spacer(),
            const Text(
              credits,
              style: TextStyle(fontFamily: semibold, color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
