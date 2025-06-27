import 'package:buynow/screen/add_product_screen.dart';
import 'package:buynow/screen/favirte_screen.dart';
import 'package:buynow/screen/my_home_screen.dart';
import 'package:buynow/screen/user_acount_screen.dart';
import 'package:buynow/widgets/botttom_nav_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    MyHomeScreen(),
    FavirteScreen(),
    AddProductScreen(),
    Center(child: Text('favorite Page')),
    UserAcountScreen()
  ];
  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Expanded(child: _screens[_selectedIndex]),
          ],
        ),
        bottomNavigationBar: CostumBttomNavBar(
            currentIndex: _selectedIndex, onTap: _onTabChange));
  }
}
