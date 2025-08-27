import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/gradients.dart';
import '../providers/plan_descriptions_state_providers.dart';
import '../providers/building_plans.dart';
import '../providers/new_building_plan_state_providers.dart';
import '../screens/new_building_plan.dart';
import '../widgets/added_items.dart';
import '../widgets/app_bar.dart';
import 'description.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final buildingPlansProvider = Provider.of<BuildingPlanBook>(context);
    final bool planExists = buildingPlansProvider.book.length != 0;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GradientAppBar(),
        title: Center(child: const Text('Simventory')),
      ),
      floatingActionButton: Container(
        width: 60,
        height: 60,
        margin: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          // backgroundColor: Color(0xFFFF630C),
          clipBehavior: Clip.hardEdge,
          elevation: 8,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color(0xFFFF630C),
                  Color(0xFFBA3B0C),
                ],
                stops: [0.3, 1],
              ),
            ),
            child: Icon(Icons.add, color: Colors.white, size: 28),
          ),
          onPressed: () async {
            final BuildingPlan? plan = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (context) => BuildingPlan()),
                    ChangeNotifierProvider(
                      create: (context) => NewBuildingPlanState(),
                    ),
                  ],
                  child: NewBuildingPlan(),
                ),
              ),
            );
            if (plan != null) {
              print(plan);
              buildingPlansProvider.addPlan(plan);
            } else {
              BuildingPlan.id--;
            }
          },
        ),
      ),
      body: Container(
        decoration: BackgroundGradient(BackgroundGradient.linearGradient()),
        child: !planExists ? DefaultWidget() : Book(),
      ),
    );
  }
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 150,
        child: const Text(
          "No Building Plans added yet",
          style: TextStyle(fontSize: 18, color: Color(0xAA014779)),
        ),
      ),
    );
  }
}

class Book extends StatelessWidget {
  Book({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final buildingPlansProvider = Provider.of<BuildingPlanBook>(context);
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: buildingPlansProvider.book.entries.length,
      itemBuilder: (BuildContext context, int index) {
        return PlanInfo(index);
      },
    );
  }
}

class PlanInfo extends StatelessWidget {
  PlanInfo(this.index);
  final int index;
  @override
  Widget build(BuildContext context) {
    final buildingPlansProvider = Provider.of<BuildingPlanBook>(context);
    final plan = buildingPlansProvider.book.values.toList()[index];
    bool isExpanded = false;

    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ExpansionTile(
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Number of Items: ${plan.numberOfItems.toString()}',
              style: TextStyle(color: Colors.black54),
            ),
            Text(
              'Total Time: ${plan.convertedTime()}',
              style: TextStyle(color: Colors.black54),
            )
          ],
        ),
        children: [
          ShowItems(
            plan: plan,
            oneRow: true,
          ),
        ],
        onExpansionChanged: (value) => isExpanded = !isExpanded,
        title: TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.all(0.0)),
          onPressed: () async {
            bool isDeleted = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (_) => NewBuildingPlanState(),
                    ),
                    ChangeNotifierProvider(
                      create: (_) => PlanDescriptionState(),
                    ),
                  ],
                  child: PlanDescription(plan: plan),
                ),
              ),
            );
            if (isDeleted) buildingPlansProvider.removePlan(plan.name);
          },
          child: Container(
            width: double.infinity,
            child: Text(
              buildingPlansProvider.book.values.toList()[index].name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
