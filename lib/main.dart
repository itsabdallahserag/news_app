import 'package:flutter/material.dart';
import 'package:news_api_app/home/home.dart';
import 'package:news_api_app/home/search_tab/search.dart';
import 'package:news_api_app/provider/theme_provider.dart';
import 'package:news_api_app/utils/app_routes.dart';
import 'package:news_api_app/utils/theme_app.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();
  runApp(ChangeNotifierProvider.value(value: themeProvider, child: NewsApp()));
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => Home(),
        AppRoutes.search: (context) => Search(),
      },
      theme: ThemeApp.lightTheme,
      darkTheme: ThemeApp.darkTheme,
      themeMode: themeProvider.appTheme,
    );
  }
}
