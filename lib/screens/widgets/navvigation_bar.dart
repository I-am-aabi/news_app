// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controllers/bottom_nav_controller.dart';
import 'package:news_app/screens/home_screen/home_screen.dart';
import 'package:news_app/screens/save_screen/save_screen.dart';
import 'package:news_app/screens/search_screen/search_screen.dart';

class Navbar extends StatelessWidget {
  Navbar({super.key});
  final BottomNavController bottomNavController =
      Get.put(BottomNavController());
  final pagelist = [HomeScreen(),  SearchScreen(), const SaveScreen()];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: SafeArea(
            child: pagelist.elementAt(bottomNavController.index.value)),
        bottomNavigationBar: Container(
          // let's make our button nav bar float
          margin: const EdgeInsets.all(12),
          height: 60,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          child: BottomNavigationBar(
            onTap: (value) {
              bottomNavController.changeIndex(value);
            },
            currentIndex: bottomNavController.index.value,
            backgroundColor: Colors.transparent,
            unselectedItemColor: Colors.grey,
            elevation: 0.0,
            selectedItemColor: Colors.orange.shade900,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Explore",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: "Saved",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
