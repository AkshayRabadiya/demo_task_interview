import 'package:demo_task/test.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List itemList = ['AAA', 'BBB', 'CCC', 'DDD','EEE'];

  List selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('First Screen'),
        ),
        body: ListView.builder(
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(itemList[index]),
              onTap: () {
                if (selectedItems.contains(itemList[index])) {
                  selectedItems.remove(itemList[index]);
                } else {
                  selectedItems.add(itemList[index]);
                }
                setState(() {});
              },
              tileColor:
                  selectedItems.contains(itemList[index]) ? Colors.blue : Colors.white,
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SecondScreen(selectedItems),
              ),
            );
          },
          child: const Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  final List selectedItems;

  const SecondScreen(this.selectedItems, {super.key});

  List createLists(List selectedItems) {
    List lists = [];

    for (int i = 0; i < selectedItems.length; i++) {
      List newList = [];
      newList.addAll(selectedItems.sublist(i));
      newList.addAll(selectedItems.sublist(0, i));
      lists.add(newList);
    }

    return lists;
  }

  @override
  Widget build(BuildContext context) {
    List lists = createLists(selectedItems);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: ListView.builder(
        itemCount: lists.length,
        itemBuilder: (context, index) {
          List currentList = lists[index];
          return ListTile(
            title: Text('List ${index + 1}: ${currentList.join(', ')}'),
          );
        },
      ),
    );
  }
}
