import 'package:flutter/material.dart';
import '../providers/items.dart';

class ChangeCount extends StatelessWidget {
  final bool add;
  final Function(Item) function;
  final Item item;

  ChangeCount({required this.add, required this.function, required this.item});
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(add ? Icons.add : Icons.remove),
        onPressed: () => function(item));
  }
}
