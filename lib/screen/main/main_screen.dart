import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/screen/bookmark/bookmark_screen.dart';
import 'package:restaurant_app/provider/main/index_nav_provider.dart';
import 'package:restaurant_app/screen/home/home_screen.dart';
import 'package:restaurant_app/screen/setting/settings_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavBar) {
            0 => const HomeScreen(),
            1 => const BookmarkScreen(),
            _ => const SettingsScreen(),
          };
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
          onTap: (index) {
            context.read<IndexNavProvider>().setIndexBottomNavBar = index;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              tooltip: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorite",
              tooltip: "Favorite",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
              tooltip: "Settings",
            ),
          ],
      ),
    );
  }
}