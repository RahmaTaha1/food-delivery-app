import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:project_1/Pages/about_us.dart';
import 'package:project_1/Pages/home_screen.dart';
import 'package:project_1/Pages/order.dart';
import 'package:project_1/Pages/profile.dart';


class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late HomeScreen homepage;
  late Profile profile;
  late Order order;
  late AboutUs aboutUs;

  @override
  void initState() {
    homepage = const HomeScreen();
    order = const Order();
    profile = const Profile();
    aboutUs = AboutUs();
    pages = [homepage, order, aboutUs, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          backgroundColor: Colors.white,
          color: Color.fromARGB(255, 146, 18, 28),
          animationDuration: const Duration(milliseconds: 500),
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          items: const [
            Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.help_outline_outlined,
              color: Colors.white,
            ),
            Icon(
              Icons.person_outline,
              color: Colors.white,
            )
          ]),
      body: pages[currentTabIndex],
    );
  }
}