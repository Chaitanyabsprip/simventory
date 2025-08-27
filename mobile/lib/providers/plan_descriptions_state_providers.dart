import 'package:flutter/material.dart';
import 'package:simventory/providers/building_plans.dart';
import 'package:simventory/widgets/gradients.dart';

class PlanDescriptionState extends ChangeNotifier {
  //fields

  bool editing = false;

  //methods

  void edit() {
    editing = !editing;
    notifyListeners();
  }
}
