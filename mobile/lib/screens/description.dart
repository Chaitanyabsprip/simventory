import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/plan_descriptions_state_providers.dart';
import '../widgets/gradients.dart';
import '../providers/building_plans.dart';
import '../providers/items.dart';
import '../widgets/edit_name.dart';
import '../widgets/app_bar.dart';
import '../widgets/added_items.dart';

class PlanDescription extends StatelessWidget {
  PlanDescription({required this.plan});
  final BuildingPlan plan;
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PlanDescriptionState>(context);
    return Scaffold(
      body: Container(
        decoration: BackgroundGradient(BackgroundGradient.linearGradient()),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              flexibleSpace: GradientAppBar(),
              floating: true,
              // expandedHeight: 250.0,
              title: Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    backgroundColor: Colors.transparent,
                  ),
                  child: Text(plan.name,
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  onPressed: () {
                    state.edit();
                  },
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: state.editing
                  ? EditName(
                      labelText: "Name",
                      hintText: "Add a name to your Building Plan",
                      plan: plan)
                  : Container(),
            ),
            SliverToBoxAdapter(
              child: Container(
                // height: 180,
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Column(
                    children: [
                      Container(
                        height: 55,
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Text(
                          "Added Items:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: Center(
                              child: ShowItems(
                            plan: plan,
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                Item item = plan.derivedItems.values.toList()[index];
                return Container(
                  margin: const EdgeInsets.all(8),
                  height: 150.0,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: Color(0xFFCCE0F5),
                                child: Image.asset(
                                    "assets/items/${item.imageName()}.png"), //"assets/items/${item.imageName()}.png"
                              ),
                              Expanded(
                                child: Text(
                                  item.count.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }, childCount: plan.derivedItems.length),
            ),
          ],
        ),
      ),
    );
  }
}
