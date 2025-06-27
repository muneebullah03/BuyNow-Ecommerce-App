// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:buynow/models/user_model.dart';
import 'package:buynow/routes/routes_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final RxString email = ''.obs;
  final RxString password = ''.obs;
  final RxString confirmPass = ''.obs;
  final RxString name = ''.obs;
  final RxString imageBase64 = ''.obs;
  RxBool isLoading = false.obs;
  Rx<XFile?> pickedImage = Rx<XFile?>(null);
  final ImagePicker _image = ImagePicker();

  Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  @override
  void onInit() {
    super.onInit();
    getUserData(); // Automatically fetch user data on controller init
  }

  // get user data
  Future<void> getUserData() async {
    try {
      String uid = auth.currentUser!.uid;

      DocumentSnapshot docs =
          await _firestore.collection('users').doc(uid).get();
      if (docs.exists) {
        currentUser.value =
            UserModel.fromMap(docs.data() as Map<String, dynamic>);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user data');
    }
  }
  // picke image

  void pickImage() async {
    final XFile? image = await _image.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage.value = image;
      File file = File(image.path);
      List<int> imageBytes = await file.readAsBytes();
      imageBase64.value = base64Encode(imageBytes);
    }
  }

  void signUpUser(GlobalKey<FormState> signupFormKey) async {
    if (signupFormKey.currentState!.validate()) {
      if (imageBase64.value.isEmpty) {
        Get.snackbar('Error', 'Please select a profile image');
        return;
      }
      isLoading.value = true;
      try {
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
                email: email.value.trim(), password: password.value.trim());

        String uid = userCredential.user!.uid;

        UserModel newUser = UserModel(
          email: email.value,
          uid: uid,
          name: name.value,
          imageBase64: imageBase64.value,
        );

        await _firestore.collection('users').doc(uid).set(newUser.toMap());

        Get.snackbar('Success', 'Account Created Successfully!',
            snackPosition: SnackPosition.BOTTOM,
            icon: Icon(Icons.check, color: Colors.green),
            duration: Duration(seconds: 3));
        Get.offAllNamed(RoutesName.homescreen);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar('Error', 'Weak Password');
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar('Error', 'Email Already In Use');
        } else {
          Get.snackbar('Error', e.message ?? 'Error');
        }
      } catch (e) {
        print(e.toString());
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> signInUser(GlobalKey<FormState> loginFormKey) async {
    if (loginFormKey.currentState!.validate()) {
      isLoading.value = true;
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.value.trim(), password: password.value.trim());

        Get.snackbar('Success', 'Logged in Successfully!',
            snackPosition: SnackPosition.BOTTOM,
            icon: Icon(Icons.check, color: Colors.green),
            duration: Duration(seconds: 3));

        Get.offAllNamed(RoutesName.myhomescreen);
        print('Navigating to home screen...');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar('Error', 'No user found for that email');
        } else if (e.code == 'wrong-password') {
          Get.snackbar('Error', 'Wrong password provided');
        } else {
          Get.snackbar('Error', e.message ?? 'Login failed');
        }
      } catch (e) {
        print(e.toString());
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> logoutUser() async {
    isLoading.value = true;
    try {
      await auth.signOut();
      // You can navigate the user to the login screen or perform any additional action
      Get.snackbar('Success', 'You have logged out successfully',
          snackPosition: SnackPosition.BOTTOM);
      Get.offAllNamed(
          RoutesName.loginscreen); // Assuming you have a login screen route
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong while logging out');
    } finally {
      isLoading.value = false;
    }
  }
}
