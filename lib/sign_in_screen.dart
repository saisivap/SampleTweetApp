import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glints_assignment/controllers/firebase_controller.dart';
import 'package:lottie/lottie.dart';

import 'widgets/signin_button_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final firebaseController = Get.put(FirebaseController());
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Container(
      height: h,
      width: w,
      decoration: const BoxDecoration(
        color: Color(0XFFECECEC),
      ),
      child: Material(
        child: Container(
          height: h,
          width: w,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: h * 0.4,
                  // width: w,
                  decoration: const BoxDecoration(
                    color: Colors.blueGrey,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            firebaseController.google_sign_in();
                          },
                          child: signInButton(w: w)),
                    ],
                  ),
                ),
              ),
              Container(
                height: h * 0.7,
                width: w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Center(
                  child:
                      Lottie.asset("assets/lottie/signin.json", width: w * 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
