import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController textController = TextEditingController();
  List<int> numberList = [];
  int maxDisplayCount = 4;
  int currentIndex = 0;

  void addNumbersToList() {
    numberList.clear();
    for (int i = currentIndex; i < currentIndex + maxDisplayCount; i++) {
      int adjustedIndex = i % int.parse(textController.text); // Ensure the index wraps from 9 to 0.
      numberList.add(adjustedIndex);
    }
  }

  void onPreviousButtonPressed() {
    if (currentIndex - maxDisplayCount >= 0) {
      currentIndex -= maxDisplayCount;
    } else {
      currentIndex = (currentIndex - maxDisplayCount) % int.parse(textController.text) + int.parse(textController.text);
    }
    addNumbersToList();
    setState(() {});
  }

  void onNextButtonPressed() {
    currentIndex = (currentIndex + maxDisplayCount) % int.parse(textController.text);
    addNumbersToList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Input Limit Example'),
      ),
      body: Column(
        children: [
          TextField(
            controller: textController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter an integer',
            ),
            onSubmitted: (value) {
              int? number = int.tryParse(value);
              if (number != null) {
                currentIndex = 0; // Reset the start index
                addNumbersToList();
                setState(() {});
              }
            },
          ),
          numberList.isNotEmpty
              ? SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: numberList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  height: 100,
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child: Text(
                      numberList[index].toString(),
                    ),
                  ),
                );
              },
            ),
          )
              : const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: onPreviousButtonPressed,
                child: const Text('Previous'),
              ),
              ElevatedButton(
                onPressed: onNextButtonPressed,
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
