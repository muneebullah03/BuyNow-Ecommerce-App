import 'package:flutter/material.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

class CustomBotttomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBotttomNavBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.deepPurple,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.shop,
            ),
            label: 'Shop'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.badge,
            ),
            label: 'Bag'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            label: 'Favorite'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Setting'),
      ],
    );
  }
}

class CostumBttomNavBar extends StatelessWidget {
  const CostumBttomNavBar(
      {super.key, required this.currentIndex, required this.onTap});
  final int currentIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.blueAccent,
      items: [
        CurvedNavigationBarItem(
          child: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        CurvedNavigationBarItem(
          child: Icon(Icons.favorite_border_outlined),
          label: 'Favorite',
        ),
        CurvedNavigationBarItem(
          child: Icon(Icons.add_box_outlined),
          label: 'Add',
        ),
        CurvedNavigationBarItem(
          child: Icon(Icons.shopping_cart_outlined),
          label: 'Cart',
        ),
        CurvedNavigationBarItem(
          child: Icon(Icons.perm_identity),
          label: 'Personal',
        ),
      ],
      onTap: onTap,
    );
  }
}
