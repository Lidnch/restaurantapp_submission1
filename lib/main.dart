import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/service/api/api_services.dart';
import 'package:restaurant_app/service/local/local_database_service.dart';
import 'package:restaurant_app/provider/detail/favorite_icon_provider.dart';
import 'package:restaurant_app/provider/detail/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/favorite/local_database_provider.dart';
import 'package:restaurant_app/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/main/index_nav_provider.dart';
import 'package:restaurant_app/provider/style/theme_provider.dart';
import 'package:restaurant_app/screen/detail/restaurant_detail_screen.dart';
import 'package:restaurant_app/screen/main/main_screen.dart';
import 'package:restaurant_app/static/nav_route.dart';

void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => IndexNavProvider(),
          ),
          Provider(
              create: (context) => ApiServices(),
          ),
          ChangeNotifierProvider(
              create: (context) => RestaurantListProvider(
                  context.read<ApiServices>(),
              ),
          ),
          ChangeNotifierProvider(
              create: (context) => RestaurantDetailProvider(
                  context.read<ApiServices>(),
              ),
          ),
          Provider(
              create: (context) => LocalDatabaseService(),
          ),
          ChangeNotifierProvider(
              create: (context) => LocalDatabaseProvider(
                  context.read<LocalDatabaseService>(),
              ),
          ),
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FavoriteIconProvider(),
          ),
        ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Restaurant App',
          theme: themeProvider.theme,
          initialRoute: NavigationRoute.mainRoute.name,
          routes: {
            NavigationRoute.mainRoute.name: (context) => const MainScreen(),
            NavigationRoute.detailRoute.name: (context) => RestaurantDetailScreen(
                  restaurantId:
                      ModalRoute.of(context)?.settings.arguments as String,
                ),
          },
        );
    });
  }
}
