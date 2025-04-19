import 'package:flutter/material.dart';
import 'billing_screen.dart';
import 'home_screen.dart';
import 'package:shop/bill_database.dart';

class GenerateBillScreen extends StatefulWidget {
  final String customerName;
  final String mobileNumber;
  final List<PurchasedItem> items;
  final double discount;
  final double totalAmount;
  final String billDate;
  final String billTime;

  const GenerateBillScreen({
    required this.customerName,
    required this.mobileNumber,
    required this.items,
    required this.discount,
    required this.totalAmount,
    required this.billDate,
    required this.billTime,
    super.key,
  });

  @override
  State<GenerateBillScreen> createState() => _GenerateBillScreenState();
}

class _GenerateBillScreenState extends State<GenerateBillScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bill And Payment')),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/ChatGPT_Image_Apr_15__2025__06_18_03_PM-removebg-preview.png',
            fit: BoxFit.scaleDown,
          ),
          Text(
            "BILL",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(50),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(80),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade800, width: 1.5),
                  color: const Color.fromARGB(123, 243, 206, 251),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Customer Name:",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.customerName,
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            "Mobile Number : ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.mobileNumber,
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Date : ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.billDate,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Time : ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.billTime,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black87,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          columns: const [
                            DataColumn(
                              label: Text(
                                'Item',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Qty',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Rate',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Price',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                          rows:
                              widget.items
                                  .where(
                                    (item) =>
                                        item.name.trim().isNotEmpty &&
                                        item.quantity > 0 &&
                                        item.rate > 0,
                                  )
                                  .map((item) {
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Text(
                                            item.name,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            item.quantity.toString(),
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            item.rate.toStringAsFixed(2),
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            item.price.toStringAsFixed(2),
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  })
                                  .toList(),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Discount : ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Rs ${widget.discount}",
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Total Amount : ",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Rs ${widget.totalAmount}",
                            style: TextStyle(
                              fontSize: 33,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (mounted) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const home_screen(),
                              ),
                              (route) => false,
                            );
                          }
                          final now = DateTime.now();
                          final formattedDate =
                              "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
                          final formattedTime =
                              "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";

                          final customId =
                              "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour}${now.minute}${now.second}";

                          final billData = {
                            'id': customId,
                            'customerName': widget.customerName,
                            'phoneNumber': widget.mobileNumber,
                            'items':
                                widget.items
                                    .map(
                                      (item) => {
                                        'name': item.name,
                                        'quantity': item.quantity,
                                        'rate': item.rate,
                                        'price': item.price,
                                      },
                                    )
                                    .toList(), // Store as a list of maps, not as a string
                            'discount': widget.discount,
                            'totalAmount': widget.totalAmount,
                            'billDate': formattedDate,
                            'billTime': formattedTime,
                          };
                          await DatabaseHelper.instance.insertBill(billData);
                        },
                        child: const Text(
                          'Save & Go to Home',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
