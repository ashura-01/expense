import 'package:flutter/material.dart';
import 'package:expense/expense.dart';

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
  double _total = 0.0;

  void _addExpense(
      String title, double amount, DateTime date, String catagory) {
    setState(() {
      _expense.add(Expense(
          title: title, amount: amount, date: date, catagory: catagory));
      _total += amount;
    });
  }

  void _removeExpense(int index){
      setState(() {
        _expense.removeAt(index);
      });
  }

  void _showForm(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    String selectedCatagory = _catagory.first;
    DateTime date = DateTime.now();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: SingleChildScrollView(
            // ✅ Fix: Enables scrolling
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Title:",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.zero,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Amount:",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.zero,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField(
                  value: selectedCatagory,
                  items: _catagory
                      .map((catagory) => DropdownMenuItem(
                            value: catagory,
                            child: Text(catagory,
                                style:
                                    TextStyle(fontWeight: FontWeight.normal)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      // ✅ Fix: Ensures dropdown updates UI
                      selectedCatagory = value!;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Select Category",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.zero,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isEmpty ||
                        double.tryParse(amountController.text) == null) {
                      return;
                    } else {
                      _addExpense(
                          titleController.text,
                          double.parse(amountController.text),
                          date,
                          selectedCatagory);
                      Navigator.pop(
                          context); // ✅ Fix: Closes bottom sheet after adding
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Add Expense"),
                ),
                SizedBox(height: 80),
              ],
            ),
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
        title: Text("Expense Tracker"),
        actions: [
          IconButton(
            onPressed: () => _showForm(context), // ✅ Fix: Opens bottom sheet
            icon: Icon(Icons.add),
          ),
        ],
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
                return GestureDetector(
                  onLongPress: (){
                    _removeExpense(index);
                  },
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Text(_expense[index]
                            .catagory
                            .substring(0, 1)
                            .toUpperCase()), 
                      ),
                      title: Text(_expense[index].title),
                      trailing: Text(_expense[index].amount.toString()),
                      subtitle: Text(_expense[index]
                          .date
                          .toString()
                          .split(' ')[0]), // ✅ Fix: Shorter date format
                    ),
                  ),
                );
              },
            ),
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
