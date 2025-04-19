import 'package:flutter/material.dart';
import 'generate_bill_screen.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  List<PurchasedItem> items = [PurchasedItem()];
  double totalAmount = 0.0;
  double discount = 0.0;
  String customerNamer = "Customer";
  String phoneNumber = "XXXXXXXXXX";
  late TextEditingController totalAmountController;

  @override
  void dispose() {
    for (var item in items) {
      item.dispose();
    }
    totalAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/ChatGPT_Image_Apr_15__2025__06_18_03_PM-removebg-preview.png',
            fit: BoxFit.contain,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'BILLING',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 152, 73, 170),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Customer Name',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter Customer Name',
                            ),
                            onChanged: (value) => customerNamer = value,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone No',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: '9876543210',
                            ),
                            onChanged: (value) => phoneNumber = value,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'PURCHASED ITEMS',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Row(
                        children: [
                          //name
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Product Name",
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white.withAlpha(
                                  (0.3 * 255).toInt(),
                                ),
                              ),
                              onChanged: (value) {
                                items[index].name = value;
                                _checkAndAddNewRow(index);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          //Quantity
                          SizedBox(
                            width: 100,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Qty",
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white.withAlpha(
                                  (0.3 * 255).toInt(),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                items[index].quantity =
                                    int.tryParse(value) ?? 0;
                                updatePrice(index);
                                _checkAndAddNewRow(index);
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          //Rate
                          SizedBox(
                            width: 150,
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Rate",
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white.withAlpha(
                                  (0.3 * 255).toInt(),
                                ),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                items[index].rate = double.tryParse(value) ?? 0;
                                updatePrice(index);
                                _checkAndAddNewRow(index);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              controller: items[index].priceController,
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: "Price",
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white.withAlpha(
                                  (0.3 * 255).toInt(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 400,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Discount",
                          filled: true,
                          fillColor: const Color.fromARGB(255, 175, 196, 176),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          discount = double.tryParse(value) ?? 0;
                          calculateTotalAmount();
                        },
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: totalAmountController,
                        decoration: InputDecoration(
                          labelText: 'Total Amount',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(20),
                  ),
                  onPressed: () {
                    final now = DateTime.now();
                    final billDate = "${now.day}-${now.month}-${now.year}";
                    final billTime =
                        "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => GenerateBillScreen(
                              customerName: customerNamer,
                              mobileNumber: phoneNumber,
                              items: items,
                              discount: discount,
                              totalAmount: totalAmount,
                              billDate: billDate,
                              billTime: billTime,
                            ),
                      ),
                    );
                  },
                  child: const Text('Generate Bill'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    totalAmountController = TextEditingController(
      text: totalAmount.toStringAsFixed(2),
    );
  }

  void updatePrice(int index) {
    final item = items[index];
    item.price = item.quantity * item.rate;
    item.priceController.text = item.price.toStringAsFixed(2);
    calculateTotalAmount();
  }

  void _checkAndAddNewRow(int index) {
    final item = items[index];
    if (item.name.isNotEmpty && item.quantity > 0 && item.rate > 0) {
      if (index == items.length - 1) {
        setState(() {
          items.add(PurchasedItem());
        });
      }
    }
  }

  void calculateTotalAmount() {
    double total = 0.0;
    for (var item in items) {
      total += item.price;
    }
    setState(() {
      totalAmount = total - discount;
      totalAmountController.text = totalAmount.toStringAsFixed(2);
    });
  }
}

class PurchasedItem {
  String name;
  int quantity;
  double rate;
  double price;
  TextEditingController priceController;

  PurchasedItem({
    this.name = '',
    this.quantity = 0,
    this.rate = 0.0,
    this.price = 0,
  }) : priceController = TextEditingController(text: "0.0");
  void dispose() {
    priceController.dispose();
  }
}
