// ignore_for_file: unnecessary_null_comparison

import 'package:buynow/controller/user_controller.dart';
import 'package:buynow/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomeDrawer extends StatefulWidget {
  const CustomeDrawer({super.key});

  @override
  State<CustomeDrawer> createState() => _CustomeDrawerState();
}

class _CustomeDrawerState extends State<CustomeDrawer> {
  final UserController _userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: Colors.red.shade700,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.red.shade700,
            ),
            accountName: Text('Muneeb Ullah'),
            accountEmail: Text('version 1.1.1'),
            currentAccountPicture: CircleAvatar(
              radius: 30, // size of circle
              backgroundColor: Colors.white,
              child: Icon(Icons.image),
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () {
              Get.toNamed(RoutesName.homescreen);
            },
          ),
          _buildDrawerItem(
            icon: Icons.person,
            text: 'Users',
            onTap: () {
              if (RoutesName.homescreen != null) {
                Get.toNamed(RoutesName.homescreen);
              } else {
                print('Route is null');
              }
            },
          ),
          _buildDrawerItem(
            icon: Icons.shopping_bag_outlined,
            text: 'Orders',
            onTap: () {},
          ),
          _buildDrawerItem(
            icon: Icons.reviews,
            text: 'Reviewa',
            onTap: () {},
          ),
          _buildDrawerItem(
            icon: Icons.inventory_2,
            text: 'Product',
            onTap: () {},
          ),
          _buildDrawerItem(
            icon: Icons.category,
            text: 'Cetagory',
            onTap: () {},
          ),
          _buildDrawerItem(
            icon: Icons.support_agent,
            text: 'Contact Us',
            onTap: () {},
          ),
          _buildDrawerItem(
            icon: Icons.logout_outlined,
            text: 'Log Out',
            onTap: () {
              _userController.logoutUser();
            },
          ),
        ],
      ),
    ));
  }

  Widget _buildDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onTap: onTap,
    );
  }
}
