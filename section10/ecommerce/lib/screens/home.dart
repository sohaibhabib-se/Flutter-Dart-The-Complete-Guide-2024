import 'package:ecommerce/screens/new_item.dart';
import 'package:flutter/material.dart';

import '../data/dummy_items.dart';
import '../widgets/grocery_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void _addItem() {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const NewItemScreen()));
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Groceries"),
        actions: [
          IconButton(onPressed: _addItem, icon: const Icon(Icons.add),),
        ],
      ),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, index) => GroceryListItem(groceryItem: groceryItems[index]),
        ),
    );
    
  }
}