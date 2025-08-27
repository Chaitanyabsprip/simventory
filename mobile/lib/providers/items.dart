import 'package:flutter/material.dart';

class Info {
  static final Map<String, Map<String, dynamic>> _itemsList = {
    "Raw Materials": {
      "Metal": {"time": 1},
      "Wood": {"time": 3},
      "Plastic": {"time": 9},
      "Seeds": {"time": 20},
      "Minerals": {"time": 30},
      "Chemicals": {"time": 120},
      "Textiles": {"time": 180},
      "Sugar and Spices": {"time": 240},
      "Glass": {"time": 300},
      "Animal Feed": {"time": 360},
      "Electrical Components": {"time": 420},

      //*removed because I dont have the image assets for these items yet

      // "Crude Oil": {"time": 6},
      // "Recycled Fabric": {"time": 6},
      // "Silk": {"time": 6},
      // "Coconut": {"time": 6},
      // "Fish": {"time": 6},
    },
    "Building Supply Store": {
      "Nails": {
        "time": 5,
        "materials required": {"Metal": 2},
      },
      "Planks": {
        "time": 30,
        "materials required": {"Wood": 2},
      },
      "Bricks": {
        "time": 20,
        "materials required": {"Minerals": 2},
      },
      "Cement": {
        "time": 50,
        "materials required": {"Minerals": 2, "Chemicals": 1},
      },
      "Glue": {
        "time": 60,
        "materials required": {"Plastic": 1, "Chemicals": 2},
      },
      "Paint": {
        "time": 60,
        "materials required": {"Metal": 2, "Minerals": 1, "Chemicals": 2},
      }
    },
    "Hardware Store": {
      "Hammer": {
        "time": 14,
        "materials required": {"Metal": 1, "Wood": 1},
      },
      "Measuring Tape": {
        "time": 20,
        "materials required": {"Metal": 1, "Plastic": 1},
      },
      "Shovel": {
        "time": 30,
        "materials required": {"Metal": 1, "Wood": 1, "Plastic": 1},
      },
      "Utensils": {
        "time": 45,
        "materials required": {"Metal": 2, "Wood": 2, "Plastic": 2},
      },
      "Ladder": {
        "time": 60,
        "materials required": {"Metal": 2, "Plank": 2},
      },
      "Drill": {
        "time": 120,
        "materials required": {
          "Metal": 2,
          "Plastic": 2,
          "Electrical Components": 1
        },
      },
    },
    "Farmer's Market": {
      "Vegetables": {
        "time": 20,
        "materials required": {"Seeds": 2},
      },
      "Flour Bag": {
        "time": 30,
        "materials required": {"Seeds": 2, "Textiles": 2},
      },
      "Fruit and Berries": {
        "time": 90,
        "materials required": {"Seeds": 2, "Tree Saplings": 1},
      },
      "Cream": {
        "time": 75,
        "materials required": {"Animal Feed": 1},
      },
      "Corn": {
        "time": 60,
        "materials required": {"Seeds": 4, "Minerals": 1},
      },
      "Cheese": {
        "time": 105,
        "materials required": {"Animal Feed": 2},
      },
      "Beef": {
        "time": 150,
        "materials required": {"Animal Feed": 3},
      },
    },
    "Furniture Store": {
      "Chairs": {
        "time": 20,
        "materials required": {"Wood": 2, "Nails": 2, "Hammer": 1},
      },
      "Tables": {
        "time": 30,
        "materials required": {"Planks": 2, "Nails": 2, "Hammer": 1},
      },
      "Home Textiles": {
        "time": 75,
        "materials required": {"Textiles": 2, "Measuring Tape": 1},
      },
      "Cupboard": {
        "time": 45,
        "materials required": {"Glass": 2, "Planks": 2, "Paint": 1},
      },
      "Couch": {
        "time": 150,
        "materials required": {"Textiles": 3, "Drill": 1, "Glue": 1},
      },
    },
    "Gardening Supply": {
      "Grass": {
        "time": 30,
        "materials required": {"Seeds": 1, "Shovel": 1},
      },
      "Tree Saplings": {
        "time": 90,
        "materials required": {"Seeds": 2, "Shovel": 1},
      },
      "Garden Furniture": {
        "time": 135,
        "materials required": {"Plastic": 2, "Textiles": 2, "Planks": 2},
      },
      "Fire Pit": {
        "time": 240,
        "materials required": {"Bricks": 2, "Cement": 2, "Shovel": 1},
      },
      "Lawn Mower": {
        "time": 120,
        "materials required": {
          "Metal": 3,
          "Electrical Components": 1,
          "Paint": 1
        }
      },
      "Garden Gnomes": {
        "time": 90,
        "materials required": {"Cement": 2, "Glue": 1},
      },
    },
    "Donut Shop": {
      "Donuts": {
        "time": 45,
        "material required": {"Sugar and Spices": 1, "Flour Bags": 1},
      },
      "Green Smoothie": {
        "time": 30,
        "materials required": {"Vegetables": 1, "Fruits and Berries": 1},
      },
      "Bread Roll": {
        "time": 60,
        "materials required": {"Flour Bag": 2, "Cream": 2},
      },
      "Cherry Cheesecake": {
        "time": 90,
        "materials required": {
          "Flour Bag": 1,
          "Fruits and Berries": 1,
          "Cheese": 1
        },
      },
      "Frozen Yogurt": {
        "time": 240,
        "materials required": {
          "Sugar and Spices": 1,
          "Fruits and Berries": 1,
          "Cream": 1
        },
      },
      "Coffee": {
        "time": 60,
        "materials required": {"Seeds": 2, "Sugar and Spices": 1, "Cream": 1},
      },
    },
    "Fashion Store": {
      "Cap": {
        "time": 60,
        "materials required": {"Textiles": 2, "Measuring Tape": 1},
      },
      "Shoes": {
        "time": 75,
        "materials required": {"Plastic": 1, "Textiles": 2, "Glue": 1},
      },
      "Watch": {
        "time": 90,
        "materials required": {"Plastic": 2, "Chemicals": 1, "Glass": 1},
      },
      "Business Suits": {
        "time": 210,
        "materials required": {"Textiles": 3, "Glue": 1, "Measuring Tape": 1},
      },
      "Backpack": {
        "time": 150,
        "materials required": {
          "Plastic": 2,
          "Textiles": 2,
          "Measuring Tape": 1
        },
      },
    },
    // "Fast Food Restaurant": {},
    // "Home Appliances": {},
  };

  //getters

  static Map<String, Map<String, dynamic>> get itemsList => _itemsList;
  static List<String> get categoryNames => _itemsList.keys.toList();

  //methods

  static Map<String, dynamic> getCommercialProducts(
      String commercialBuildingName) {
    return _itemsList[commercialBuildingName] ?? {};
  }

  static List<String> getCommercialProductNames(String commercialBuildingName) {
    return getCommercialProducts(commercialBuildingName).keys.toList();
  }

  static Map<String, dynamic> getAllItems() {
    Map<String, dynamic> items = {};
    for (var i in Info.itemsList.values) {
      Map<String, dynamic> map = i;
      items.addAll(map);
    }
    return items;
  }
}

class Item {
  //fields

  String name;
  int count;

  //constructors

  Item(this.name) : this.count = 0;

  //getters

  int get time => Info.getAllItems()[name]?["time"] ?? 0;

  //methods

  void incrementCount() {
    this.count++;
  }

  void decrementCount() {
    this.count--;
  }

  String imageName() {
    return name.replaceAll(RegExp(' '), '');
  }

  @override
  bool operator ==(Object other) => other is Item && name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => "($name, $count, $time)";
}

class DerivedItem extends Item with ChangeNotifier {
  late Map<String, int>? _materialsRequired;
  bool isBasic = true;

  DerivedItem(String name) : super(name) {
    super.count = 0;
    this._materialsRequired = Info.getAllItems()[name]?["materials required"];
    this._materialsRequired == null
        ? this.isBasic = false
        : this.isBasic = true;
  }

  int get time => Info.getAllItems()[name]?["time"] ?? 0;

  void incrementCount() {
    this.count++;
    notifyListeners();
  }

  void decrementCount() {
    this.count--;
    notifyListeners();
  }
}
