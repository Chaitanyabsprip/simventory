import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/home_screen_state_providers.dart';
import 'providers/building_plans.dart';
import 'screens/home.dart';

void main() {
  runApp(Simventory());
}

class Simventory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BuildingPlanBook>(
          create: (context) => BuildingPlanBook(),
        ),
        ChangeNotifierProvider<HomeScreenState>(
          create: (context) => HomeScreenState(),
        )
      ],
      child: MaterialApp(
        title: 'Simventory',
        theme: ThemeData(
            primaryColor: Color.fromRGBO(1, 76, 131, 1),
            scaffoldBackgroundColor: Color(0xFFFFFFFF),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              secondary: Color(0xFF54DAF7),
            ),
            textTheme: TextTheme(
                headlineMedium:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w400))),
        home: Home(),
      ),
    );
  }
}
