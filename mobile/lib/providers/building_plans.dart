import 'package:flutter/Material.dart';
import 'items.dart';

class BuildingPlan with ChangeNotifier {
  BuildingPlan() {
    id++;
    uid = id;
    name = "Building Plan #$uid";
  }

  //fields

  late String name;
  late int uid;
  static int id = 0;
  Map<String, Item> ingredients = {};

  //getters

  int get numberOfItems {
    int totalCount = 0;
    for (var item in ingredients.values) {
      totalCount += item.count;
    }
    return totalCount;
  }

  int get totalTimeTaken {
    int totalTime = 0;
    for (var item in ingredients.values) {
      totalTime += item.time * item.count;
    }
    return totalTime;
  }

  Map<String, Item> get derivedItems {
    Map<String, DerivedItem> derivedItems = Map.from(ingredients);
    derivedItems.removeWhere((key, value) => !value.isBasic);
    return derivedItems;
  }

  //methods

  void addItem(Item item) {
    if (!ingredients.containsValue(item)) {
      ingredients[item.name] = item;
    }
    ingredients[item.name]?.incrementCount();
    // _sortIngredients();
    notifyListeners();
  }

  void removeItem(String itemName) {
    Item? item = ingredients[itemName];
    if (ingredients.containsKey(itemName) && item != null) {
      item.decrementCount();
      if (ingredients[itemName]!.count <= 0) ingredients.remove(itemName);
    }
    notifyListeners();
  }

  String convertedTime() {
    int hours = totalTimeTaken ~/ 60;
    int mins = totalTimeTaken % 60;
    if (hours == 0) {
      return '$mins m';
    } else {
      return '${totalTimeTaken ~/ 60}h ${totalTimeTaken % 60}m';
    }
  }

  void changeNameTo(String newName) {
    name = newName;
    notifyListeners();
  }

  void _sortIngredients() {
    // Sort ingredients by name
    List<String> sortedKeys = ingredients.keys.toList()..sort();
    Map<String, Item> temp = {};
    for (var key in sortedKeys) {
      temp[key] = ingredients[key]!;
    }
    ingredients = temp;
  }

  void notify() => notifyListeners();

  @override
  String toString() => "$name: ${ingredients.values.toList()}";
}

class BuildingPlanBook extends ChangeNotifier {
  BuildingPlanBook();

  //fields

  BuildingPlan? buildingPlan;
  Map<String, BuildingPlan> book = {};
  Map recipeType = Map.unmodifiable(
    {
      1: "Building",
      2: "Ship Shipment",
      3: [
        "Air Shipment",
        {1: "Paris", 2: "London", 3: "Tokyo"}
      ],
      4: "War Delivery",
      5: "Citizen Offers",
    }, //*not happy with this structure
  );

  //methods

  void addPlan(BuildingPlan plan) {
    book[plan.name] = plan;
    notifyListeners();
  }

  void removePlan(String name) {
    if (book.containsKey(name)) {
      book.remove(name);
    }
    notifyListeners();
  }
}
