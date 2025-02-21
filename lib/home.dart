import 'package:expense/expense.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Expense> _expense = [];
  final List<String> _catagory = [
    "food",
    "transport",
    "entertainment",
    "bills"
  ];
  final double _total = 0.0;

  void _showForm(BuildContext context) {
    TextEditingController _titleController = TextEditingController();
    TextEditingController _amountController = TextEditingController();

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, // Makes the bottom sheet rectangular
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Title:",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.zero, // Rectangular border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.zero, // Rectangular border
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Amount:",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.zero, // Rectangular border
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.zero, // Rectangular border
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                  items: _catagory.map((catagory) => DropdownMenuItem(
                        value: catagory,
                        child: Text(catagory),
                      )).toList(),
                  onChanged: )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        title: Text("Expense tracker"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: Column(
        children: [
          Center(
            child: Card(
              color: Colors.white,
              shadowColor: Colors.black,
              margin: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Total: \$$_total",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: _expense.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(_expense[index].catagory),
                        backgroundColor: Colors.blueAccent,
                      ),
                      title: Text(_expense[index].title),
                      subtitle: Text(_expense[index].date.toString()),
                    ),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
