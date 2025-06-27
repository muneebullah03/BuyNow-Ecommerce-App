import 'package:buynow/const/app_colors.dart';
import 'package:buynow/controller/user_controller.dart';
import 'package:buynow/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_button.dart';
import '../widgets/custome_text_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final UserController _userController = Get.put(UserController());
  final GlobalKey<FormState> _loginFormKey =
      GlobalKey<FormState>(); // Unique key for Login

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _loginFormKey, // Attach unique key here
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 23, top: 150, bottom: 50),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              CustomeTextForm(
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => _userController.email.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'Enter valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomeTextForm(
                hintText: 'Password',
                onChanged: (value) => _userController.password.value = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 210),
                child: Text('Forgotten Password?'),
              ),
              SizedBox(height: 40),
              Obx(
                () => CustomButton(
                  ontap: () {
                    if (_loginFormKey.currentState!.validate()) {
                      _userController
                          .signInUser(_loginFormKey); // Pass the unique key
                      Get.offAllNamed(RoutesName.homescreen);
                    }
                  },
                  widget: _userController.isLoading.value
                      ? CupertinoActivityIndicator()
                      : Center(
                          child: Text(
                            "L O G I N",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  GestureDetector(
                    onTap: () {
                      Get.offAllNamed(RoutesName.signupscreen);
                    },
                    child: Text(
                      " Sign up",
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
