import 'dart:convert';

import 'package:ecommerce/data/categories.dart';
import 'package:ecommerce/models/grocery_item.dart';
import 'package:ecommerce/screens/new_item.dart';
import 'package:ecommerce/widgets/grocery_list_item.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

// import '../data/dummy_items.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https('flutter-prep-a48de-default-rtdb.firebaseio.com',
        'shopping-list.json');

    // final response = await http.get(url);
    // print(response.statusCode);
    // print(response.body);

    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch data please try it again later.';
        });
      }

      if(response.body == 'null'){
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData =
      json.decode(response.body);
      // print(respon)
      final List<GroceryItem> loadedItems = [];
      for (final item in listData.entries) {
        final category = categories.entries
            .firstWhere((catItem) => catItem.value.name == item.value['category'])
            .value;
        loadedItems.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category,
          ),
        );
      }
      setState(() {
        _groceryItems = loadedItems;
        _isLoading = false;
      });
    }
    catch(error) {
      setState(() {
        _error = 'Something went wrong!!! ${error.toString()}';
      });
    }
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItemScreen(),
      ),
    );

    if (newItem == null) {
      return;
    }

    // _loadItems();

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) async {

    final _index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });

    final url = Uri.https('flutter-prep-a48de-default-rtdb.firebaseio.com', 'shopping-list/${item.id}.json');

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(_index, item);
      });
    }

    // setState(() {
    //   _groceryItems.remove(item);
    // });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text(
        'Please add new items using + button.',
      ),
    );

    if(_isLoading == true){
      content = const Center(child: CircularProgressIndicator(),);
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            _removeItem(_groceryItems[index]);
          },
          key: ValueKey(_groceryItems[index].id),
          child: GroceryListItem(
            groceryItem: _groceryItems[index],
          ),
        ),
      );
    }

    if(_error != null ){
      content = Center(child: Text(_error!),);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Groceries"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
