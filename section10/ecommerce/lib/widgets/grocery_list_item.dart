import 'package:ecommerce/models/grocery_item.dart';
import 'package:flutter/material.dart';

class GroceryListItem extends StatelessWidget {
  const GroceryListItem({
    super.key,
    required this.groceryItem,
  });

  // final String title;
  // final int quantity;
  final GroceryItem groceryItem;

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     ListTile(
    //       leading: Text("Color"),
    //       title: Text(title),
    //       trailing: Text("1"),
    //     ),
    //   ],
    // );
    return ListTile(
      leading: Container(
        width: 24,
        height: 24,
        color: groceryItem.category.color,
      ),
      title: Text(groceryItem.name),
      trailing: Text(
        groceryItem.quantity.toString(),
      ),
    );
  }
}
