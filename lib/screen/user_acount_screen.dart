import 'dart:convert';

import 'package:buynow/controller/user_controller.dart';
import 'package:buynow/widgets/custome_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserAcountScreen extends StatefulWidget {
  const UserAcountScreen({super.key});

  @override
  State<UserAcountScreen> createState() => _UserAcountScreenState();
}

class _UserAcountScreenState extends State<UserAcountScreen> {
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Personal Info'),
          centerTitle: true,
        ),
        drawer: CustomeDrawer(),
        body: Obx(() {
          final user = _userController.currentUser.value;
          if (user == null) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: MemoryImage(base64Decode(user.imageBase64)),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 202, 201, 201),
                      borderRadius: BorderRadius.circular(20)),
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Name : ${user.name}",
                      style:
                          TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 202, 201, 201),
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Text(
                      "Email : ${user.email}",
                      style:
                          TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              )
            ],
          );
        }));
  }
}
