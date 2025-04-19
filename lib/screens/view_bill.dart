// view_bill.dart
import 'package:flutter/material.dart';

class ViewBill extends StatelessWidget {
  final Map<String, dynamic> bill;

  const ViewBill({super.key, required this.bill});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> items = bill['items'] ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text('View Bill')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.purple.shade50,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoRow("Customer Name:", bill['customerName']),
                _infoRow("Phone Number:", bill['phoneNumber']),
                _infoRow("Date:", bill['billDate']),
                _infoRow("Time:", bill['billTime']),
                const SizedBox(height: 20),
                const Text(
                  "Items",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Item')),
                      DataColumn(label: Text('Qty')),
                      DataColumn(label: Text('Rate')),
                      DataColumn(label: Text('Price')),
                    ],
                    rows:
                        items.map((item) {
                          return DataRow(
                            cells: [
                              DataCell(Text(item['name'])),
                              DataCell(Text(item['quantity'].toString())),
                              DataCell(Text(item['rate'].toString())),
                              DataCell(Text(item['price'].toString())),
                            ],
                          );
                        }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                _infoRow("Discount:", "Rs ${bill['discount']}"),
                _infoRow("Total Amount:", "Rs ${bill['totalAmount']}"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 18))),
        ],
      ),
    );
  }
}
