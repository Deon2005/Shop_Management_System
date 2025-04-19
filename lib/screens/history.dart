import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shop/bill_database.dart';
import 'package:shop/screens/view_bill.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Map<String, dynamic>> bills = [];

  @override
  void initState() {
    super.initState();
    _fetchBills();
  }

  // Fetch bills from the database
  Future<void> _fetchBills() async {
    final billsData = await DatabaseHelper.instance.fetchBills();
    setState(() {
      bills = billsData;
    });
  }

  // Format the date
  String _formatDate(String date) {
    // Print the date to check its value
    try {
      DateTime dateTime = DateTime.parse(date);
      return '${dateTime.day}-${dateTime.month}-${dateTime.year}';
    } catch (e) {
      return 'Invalid Date'; // Return a fallback message if the date format is invalid
    }
  }

  // Delete a bill and refresh the list
  Future<void> _deleteBill(String id) async {
    await DatabaseHelper.instance.deleteBill(id);
    _fetchBills(); // Refresh the list after deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/ChatGPT_Image_Apr_15__2025__06_18_03_PM-removebg-preview.png',
            fit: BoxFit.contain,
          ),
          bills.isEmpty
              ? Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 250,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2.0),
                    color: Color.fromARGB(142, 215, 104, 235),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "No Records Found",
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Please add Enter Some bills to see it here....",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              : ListView.builder(
                itemCount: bills.length,
                itemBuilder: (context, index) {
                  var bill = bills[index];
                  String formattedDate = _formatDate(bill['billDate']);

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(15),
                      title: Text(
                        bill['customerName'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total: Rs${bill['totalAmount']}'),
                          Text('Date: $formattedDate'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _deleteBill(bill['id']);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewBill(bill: bill),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
        ],
      ),
    );
  }
}
