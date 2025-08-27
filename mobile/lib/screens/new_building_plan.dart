import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/edit_name.dart';
import '../widgets/app_bar.dart';
import '../providers/building_plans.dart';
import '../providers/items.dart';
import '../providers/new_building_plan_state_providers.dart';
import '../widgets/added_items.dart';
import '../widgets/change_item_count_button.dart';

class NewBuildingPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // provider variables

    final titleEditingState = Provider.of<NewBuildingPlanState>(context);
    final planProvider = Provider.of<BuildingPlan>(context);
    titleEditingState.plan = planProvider;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GradientAppBar(),
        title: Center(
          child: TextButton(
            style: TextButton.styleFrom(
              splashFactory: NoSplash.splashFactory,
              backgroundColor: Colors.transparent,
            ),
            child: Text(planProvider.name,
                style: TextStyle(color: Colors.white, fontSize: 18)),
            onPressed: () {
              titleEditingState.edit();
            },
          ),
        ),
        // added actions with a 0 opacity widget to add an invisible box
        // to center the title in the AppBar
        actions: [
          Opacity(
            opacity: 0,
            child: Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.lerp(Color(0xFFC4F4FF), Color(0xFFFFFFFF), 0.5)!,
              Color.lerp(Color(0xFFC4F4FF), Color(0xFFFFFFFF), 0.7)!,
              Color.lerp(Color(0xFFC4F4FF), Color(0xFFFFFFFF), 0.9)!,
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
              Color(0xFFFFFFFF),
              Color.lerp(Color(0xFFC4F4FF), Color(0xFFFFFFFF), 0.9)!,
              Color.lerp(Color(0xFFC4F4FF), Color(0xFFFFFFFF), 0.7)!,
              Color.lerp(Color(0xFFC4F4FF), Color(0xFFFFFFFF), 0.5)!,
            ],
            // stops: [0.45, 1],
          ),
        ),
        child: Column(
          children: <Widget>[
            titleEditingState.editing
                ? EditName(
                    labelText: "Name",
                    hintText: "Add a name to your Building Plan",
                    plan: planProvider)
                : Container(),
            Divider(
              color: Colors.black45,
            ),
            AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 800),
              height: planProvider.ingredients.length == 0
                  ? 0
                  : (planProvider.ingredients.length % 3 == 0
                      ? 50.0 *
                          ((planProvider.ingredients.length / 3).ceil() + 1)
                      : 50.0 * ((planProvider.ingredients.length / 3).ceil())),
              child: Stack(
                children: [
                  ShowItems(
                    plan: planProvider,
                    allowEdit: true,
                  ),
                  Positioned(
                    bottom: 8.0,
                    right: 24.0,
                    child: AnimatedContainer(
                      curve: Curves.ease,
                      duration: Duration(milliseconds: 800),
                      height: planProvider.ingredients.length == 0 ? 0.0 : 36.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        onPressed: () {
                          BuildingPlan? result;
                          result = planProvider;
                          if (planProvider.ingredients.length == 0) {
                            result = null;
                            BuildingPlan.id--;
                          }
                          Navigator.pop(context, result);
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: <Color>[
                                    Color(0xFFFF630C),
                                    Color(0xFFBA3B0C),
                                  ],
                                  stops: [
                                    0.3,
                                    1
                                  ]),
                              borderRadius: BorderRadius.circular(18.0)),
                          child: Container(
                            constraints:
                                BoxConstraints(maxWidth: 88.0, minHeight: 36.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Done",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              indent: 185,
              endIndent: 185,
              color: Colors.black45,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: Info.categoryNames.length,
                itemBuilder: (BuildContext context, int i) {
                  final List<String> categoryNames = Info.categoryNames;
                  return ExpansionTile(
                    title: Text(Info.categoryNames[i]),
                    children: List.generate(
                        Info.getCommercialProducts(categoryNames[i]).length,
                        (int j) {
                      Item item = DerivedItem(
                          Info.itemsList[categoryNames[i]]?.keys.toList()[j] ??
                              '');
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  child: Image.asset(
                                      "assets/items/${item.imageName()}.png"),
                                ),
                              ),
                            ),
                            Container(
                              width: 135,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                item.name,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ChangeCount(
                                        add: false,
                                        function: (i) =>
                                            planProvider.removeItem(i.name),
                                        item: item),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      (planProvider.ingredients
                                              .containsValue(item))
                                          ? planProvider
                                                  .ingredients[item.name]?.count
                                                  .toString() ??
                                              "0"
                                          : "0",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: ChangeCount(
                                        add: true,
                                        function: planProvider.addItem,
                                        item: item),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
