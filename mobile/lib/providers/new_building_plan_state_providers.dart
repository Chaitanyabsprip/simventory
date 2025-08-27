import 'package:flutter/material.dart';
import 'package:simventory/providers/building_plans.dart';

class NewBuildingPlanState extends ChangeNotifier {
  //fields

  BuildingPlan? plan;
  bool editing = false;

  //methods

  void edit() {
    editing = !editing;
    notifyListeners();
  }
}
