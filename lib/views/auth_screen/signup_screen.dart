import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seed_haven/consts/consts.dart';
import 'package:seed_haven/consts/list.dart';
import 'package:seed_haven/controllers/auth_controller.dart';
import 'package:seed_haven/views/home_screen/home.dart';
import 'package:seed_haven/widgets_common/app_logo.dart';
import 'package:seed_haven/widgets_common/bg_widget.dart';
import 'package:seed_haven/widgets_common/custom_textfield.dart';
import 'package:seed_haven/widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  TextEditingController _nameController = TextEditingController();

  TextEditingController _retypepasswordController = TextEditingController();

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
                'Join the $appname',
                style: TextStyle(
                    fontSize: 18, fontFamily: bold, color: Colors.white),
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  customTextfield(name, nameHint, _nameController, false),
                  customTextfield(email, emailHint, _emailController, false),
                  customTextfield(
                      password, passwordHint, _passwordController, true),
                  customTextfield(retypePass, passwordHint,
                      _retypepasswordController, true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: const Text(forgetPass)),
                  ),
                  Row(
                    children: [
                      Checkbox(
                          activeColor: redColor,
                          value: isCheck,
                          checkColor: whiteColor,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue;
                            });
                          }),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: 'I agree to the ',
                              style: TextStyle(
                                  fontFamily: regular, color: fontGrey)),
                          TextSpan(
                              text: terms,
                              style: TextStyle(
                                  fontFamily: regular, color: redColor)),
                          TextSpan(
                              text: ' & ',
                              style: TextStyle(
                                  fontFamily: regular, color: fontGrey)),
                          TextSpan(
                              text: privacyPolicy,
                              style: TextStyle(
                                  fontFamily: regular, color: redColor))
                        ])),
                      ),
                    ],
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
                            title: signup,
                            color: isCheck! ? redColor : whiteColor,
                            textColor: whiteColor,
                            onpress: () async {
                              setState(() {
                                isLoading = true;
                              });
                              if (isCheck != false) {
                                try {
                                  await controller
                                      .signupMethod(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                          context: context)
                                      .then((value) {
                                    return controller.storeUserData(
                                        _nameController.text,
                                        _passwordController.text,
                                        _emailController.text);
                                  }).then((value) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    VxToast.show(context, msg: loggedin);
                                    Get.offAll(() => Home());
                                  });
                                } catch (e) {
                                  VxToast.show(context, msg: e.toString());
                                  setState(() {
                                    isLoading = false;
                                  });
                                  auth.signOut();
                                }
                              }
                            }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(alreadyHaveAccount,
                          style: TextStyle(color: fontGrey)),
                      const Text(login,
                              style:
                                  TextStyle(color: redColor, fontFamily: bold))
                          .onTap(() {
                        Get.back();
                        //this back is a awesome feature
                      }),
                    ],
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
