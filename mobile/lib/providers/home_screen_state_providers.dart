import 'package:flutter/material.dart';
import '../widgets/gradients.dart';
import 'building_plans.dart';

class HomeScreenState with ChangeNotifier {
  BackgroundGradient backgroundGradient =
      BackgroundGradient(BackgroundGradient.linearGradient());

  BuildingPlan? plan;
}
