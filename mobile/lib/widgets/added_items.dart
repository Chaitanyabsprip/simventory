import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/items.dart';
import '../providers/building_plans.dart';

class ShowItems extends StatelessWidget {
  ShowItems(
      {required this.plan,
      this.allowEdit = false,
      this.oneRow = false,
      this.radius = 18});

  final BuildingPlan plan;
  final bool allowEdit;
  final bool oneRow;
  final double radius;
  @override
  Widget build(BuildContext context) {
    int length = plan.ingredients.length;

    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      duration: Duration(milliseconds: 800),
      height: allowEdit
          ? 50.0 * ((length / 3).ceil())
          : (oneRow ? 50.0 : 50.0 * ((length / 4).ceil())),
      width: 400,
      // padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: oneRow
          ? ListView(
              children: List.generate(
                plan.ingredients.length,
                (index) {
                  final item = plan.ingredients.values.toList()[index];
                  return ItemCount(
                    item: item,
                  );
                },
              ),
              scrollDirection: Axis.horizontal,
            )
          : Center(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  runSpacing: 12.0,
                  spacing: allowEdit ? 40.0 : 26.0,
                  direction: Axis.horizontal,
                  children: List.generate(
                    plan.ingredients.length,
                    (index) {
                      final item = plan.ingredients.values.toList()[index];
                      return ItemCount(
                        item: item,
                        allowEdit: allowEdit,
                        oneRow: oneRow,
                        radius: radius,
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}

class ItemCount extends StatelessWidget {
  ItemCount({
    required this.item,
    this.radius = 18,
    this.allowEdit = false,
    this.oneRow = false,
    Key? key,
  }) : super(key: key);

  final bool oneRow;
  final double radius;
  final bool allowEdit;
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: null,
      margin: oneRow ? const EdgeInsets.symmetric(horizontal: 4) : null,
      width: allowEdit ? radius * 5.1 : radius * 3.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: radius,
            child: Image.asset('assets/items/${item.imageName()}.png'),
            backgroundColor: Colors.transparent,
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${item.count}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          allowEdit
              ? Expanded(
                  flex: 1,
                  child: Container(
                    width: 28.0,
                    height: 28.0,
                    alignment: Alignment(0, 0),
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Color(0x09FF0000),
                    ),
                    child: RemoveAll(
                      item: item,
                    ),
                  ),
                )
              : Visibility(
                  child: Container(),
                  visible: false,
                ),
        ],
      ),
    );
  }
}

class RemoveAll extends StatelessWidget {
  RemoveAll({required this.item, this.plan});
  final BuildingPlan? plan;
  final Item item;
  @override
  Widget build(BuildContext context) {
    BuildingPlan? plan = this.plan;
    try {
      plan ??= Provider.of<BuildingPlan>(context);
    } catch (e) {
      throw 'The Plan instance provided is not valid';
    }
    return IconButton(
      padding: EdgeInsets.all(0),
      icon: Icon(
        Icons.clear,
        color: Colors.red,
      ),
      onPressed: () {
        item.count = 0;
        plan?.removeItem(item.name);
      },
    );
  }
}
