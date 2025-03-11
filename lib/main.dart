import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/notification/local_notification_provider.dart';
import 'package:restaurant_app/provider/notification/payload_provider.dart';
import 'package:restaurant_app/provider/shared_preferences_provider.dart';
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
import 'package:restaurant_app/service/local/local_notification_service.dart';
import 'package:restaurant_app/service/local/shared_preferences_service.dart';
import 'package:restaurant_app/static/nav_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final notificationAppLaunchDetails =
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  String route = NavigationRoute.mainRoute.name;
  String? payload;

  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    final notificationResponse =
        notificationAppLaunchDetails!.notificationResponse;
    route = NavigationRoute.detailRoute.name;
    payload = notificationResponse?.payload;
  }

  runApp(
    MultiProvider(
        providers: [
          Provider(
              create: (context) => SharedPreferencesService(prefs),
          ),
          ChangeNotifierProvider(
              create: (context) => SharedPreferencesProvider(
                  context.read<SharedPreferencesService>(),
              ),
          ),
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
          Provider(
              create: (context) => LocalNotificationService()
                ..init()
                ..configureLocalTimeZone(),
          ),
          ChangeNotifierProvider(
              create: (context) => LocalNotificationProvider(
                  context.read<LocalNotificationService>(),
              )..requestPermissions(),
          ),
          ChangeNotifierProvider(
              create: (context) => PayloadProvider(
                payload: payload,
              ),
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
