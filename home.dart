import 'package:flutter/material.dart';

class FunkyHomeView extends StatefulWidget {
  final String title;

  const FunkyHomeView({super.key, required this.title});

  @override
  State<FunkyHomeView> createState() => _FunkyHomeViewState();
}

class _FunkyHomeViewState extends State<FunkyHomeView> {
  final TextEditingController controller = TextEditingController();
  List<List<dynamic>> toDoList = [
    ["Learn Flutter", false],
    ["Build a project", false],
    ["Drink coffee", false],
  ];

  // Method to toggle the checkbox
  void _toggleCheckBox(int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  // Method to save a new task
  void _saveNewTask() {
    if (controller.text.isNotEmpty) {
      setState(() {
        toDoList.add([controller.text, false]);
        controller.clear(); // Clear the text field after adding
      });
    }
  }

  // Method to delete a task
  void _deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index); // Remove the item at the given index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // Using the title passed from the widget
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Checkbox(
                    value: toDoList[index][1], // The checkbox state (true/false)
                    onChanged: (bool? value) {
                      _toggleCheckBox(index); // Toggle the state when checked/unchecked
                    },
                    checkColor: Colors.white, // Inside check color
                    activeColor: Colors.green, // Border color of the checkbox
                  ),
                  const SizedBox(width: 10), // Adding space between checkbox and text
                  Expanded(
                    child: Text(
                      toDoList[index][0], // Display the to-do item
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  // Delete button
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: () {
                      _deleteTask(index); // Call the delete method
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: controller, // Attach the controller to the TextField
                decoration: InputDecoration(
                  hintText: "Add a new to-do item",
                  filled: true,
                  fillColor: Colors.deepPurple.shade100,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.deepPurple,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: _saveNewTask, // Call the save method
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
