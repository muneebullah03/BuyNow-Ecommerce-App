import 'dart:async';
import 'package:buynow/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), checkUserLoginStatus);
  }

  void checkUserLoginStatus() {
    User? user = auth.currentUser;

    if (user != null) {
      Get.offAllNamed(RoutesName.homescreen);
      // Navigate to Home if logged in
    } else {
      Get.offAllNamed(RoutesName.loginscreen);
// Navigate to Login if not
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Splash Screen'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: height * 0.3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 70,
                width: 70,
                child: Image.asset(
                  'assets/icons/trolley.png',
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Buy-Now",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 39, 35, 35),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Retail Store",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 39, 35, 35),
                          fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      )),
    );
  }
}
