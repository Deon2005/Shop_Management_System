import 'package:flutter/material.dart';

class home_screen extends StatelessWidget {
  const home_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Karthika Stores'), centerTitle: true),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/ChatGPT_Image_Apr_15__2025__06_18_03_PM-removebg-preview.png',
            fit: BoxFit.scaleDown,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/billing');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.4,
                      MediaQuery.of(context).size.height * 0.3,
                    ),
                  ),
                  child: Text(
                    'Billing',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                ),
                const SizedBox(width: 50), // space between buttons
                ElevatedButton(
                  onPressed: () {
                    // Replace with your desired action or route
                    Navigator.pushNamed(context, '/history');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.4,
                      MediaQuery.of(context).size.height * 0.3,
                    ),
                  ),
                  child: Text(
                    'History',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
