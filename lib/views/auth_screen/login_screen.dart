import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seed_haven/consts/consts.dart';
import 'package:seed_haven/consts/list.dart';
import 'package:seed_haven/controllers/auth_controller.dart';
import 'package:seed_haven/views/auth_screen/signup_screen.dart';
import 'package:seed_haven/views/home_screen/home.dart';
import 'package:seed_haven/widgets_common/app_logo.dart';
import 'package:seed_haven/widgets_common/bg_widget.dart';
import 'package:seed_haven/widgets_common/custom_textfield.dart';
import 'package:seed_haven/widgets_common/our_button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var controller = Get.put(AuthController());

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return bgWidget(Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // (context.screenHeight * 0.07).heightBox,
              SizedBox(
                height: context.screenHeight * 0.07,
              ),
              applogoWidget(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Log in to $appname',
                style: TextStyle(
                    fontSize: 18, fontFamily: bold, color: Colors.white),
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  customTextfield(email, emailHint, emailController, false),
                  customTextfield(
                      password, passwordHint, passwordController, true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: const Text(forgetPass)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: context.screenWidth,
                    child: isLoading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : ourButton(
                            title: 'Login',
                            color: redColor,
                            onpress: () {
                              setState(() {
                                isLoading = true;
                              });

                              controller
                                  .loginMethod(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      context: context)
                                  .then((value) {
                                if (value != null) {
                                  VxToast.show(context, msg: loggedin);
                                  setState(() {
                                    isLoading = false;
                                  });

                                  Get.offAll(const Home());
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              });
                            },
                            textColor: whiteColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    createNewAccount,
                    style: TextStyle(color: fontGrey),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: context.screenWidth,
                    child: ourButton(
                        title: signup,
                        color: lightgolden,
                        textColor: redColor,
                        onpress: () {
                          Get.to(() => SignupScreen());
                        }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    loginWith,
                    style: TextStyle(color: fontGrey),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  backgroundColor: lightGrey,
                                  radius: 25,
                                  child: Image.asset(
                                    socialIconList[index],
                                    width: 30,
                                  )),
                            )),
                  )
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  //this shadow is great
                  .make(),
            ],
          ),
        ),
      ),
    ));
  }
}
