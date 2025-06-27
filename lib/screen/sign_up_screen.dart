// ignore_for_file: body_might_complete_normally_nullable, unused_field

import 'dart:io';

import 'package:buynow/const/app_colors.dart';
import 'package:buynow/controller/user_controller.dart';
import 'package:buynow/routes/routes_name.dart';
import 'package:buynow/widgets/custom_button.dart';
import 'package:buynow/widgets/custome_text_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final UserController _userController = Get.put(UserController());
  final GlobalKey<FormState> _signupFormKey =
      GlobalKey<FormState>(); // Unique key for SignUp

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 23, top: 100, bottom: 10),
                child: Text(
                  'Sign up',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 150, vertical: 10),
                child: Stack(
                  children: [
                    Obx(
                      () => CircleAvatar(
                          radius: 50,
                          child: _userController.pickedImage.value == null
                              ? Icon(Icons.person, size: 50)
                              : ClipOval(
                                  child: Image.file(
                                    File(_userController
                                        .pickedImage.value!.path),
                                    fit: BoxFit.cover,
                                    width: 85,
                                    height: 85,
                                  ),
                                )),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: GestureDetector(
                            onTap: () {
                              _userController.pickImage();
                            },
                            child: Icon(Icons.add)),
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _signupFormKey, // Attach unique key here
                child: Column(
                  children: [
                    CustomeTextForm(
                      hintText: 'Full name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }
                      },
                      onChanged: (value) => _userController.name.value = value,
                    ),
                    SizedBox(height: 20),
                    CustomeTextForm(
                      hintText: 'Email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email';
                        }
                        if (!GetUtils.isEmail(value)) {
                          return 'Enter valid email';
                        }
                      },
                      onChanged: (value) => _userController.email.value = value,
                    ),
                    SizedBox(height: 20),
                    CustomeTextForm(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Password';
                        }
                        if (value.length < 6) {
                          return 'Please enter Strong password';
                        }
                      },
                      onChanged: (value) =>
                          _userController.password.value = value,
                      hintText: 'Password',
                    ),
                    SizedBox(height: 20),
                    CustomeTextForm(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Confirm the password';
                        }
                        if (_userController.password.value !=
                            _userController.confirmPass.value) {
                          return 'Incorrect password';
                        }
                      },
                      onChanged: (value) =>
                          _userController.confirmPass.value = value,
                      hintText: 'Confirmed Password',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Obx(
                () => CustomButton(
                    ontap: () {
                      if (_signupFormKey.currentState!.validate()) {
                        _userController
                            .signUpUser(_signupFormKey); // Pass the unique key
                      }
                    },
                    widget: _userController.isLoading.value
                        ? CupertinoActivityIndicator(
                            color: Colors.white,
                          )
                        : Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed(RoutesName.loginscreen);
                    },
                    child: Text(
                      " Sign in",
                      style: TextStyle(color: AppColors.buttonBackgroundColor),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
