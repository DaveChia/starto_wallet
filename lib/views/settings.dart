import 'package:flutter/material.dart';
import './wallets.dart' as Wallets;
import './repeated_transactions.dart' as RepeatedTransactions;

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color borderColor = Color(0xFFEBEDEF);
    Color hintTextColor = Color(0xFF9CA3AD);
    Color backgroundColor = Color(0xFFFFFFFF);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
          centerTitle: true,
          title: Text('Settings'),
          elevation: 0,
          automaticallyImplyLeading: false),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: SingleChildScrollView(
            child: Stack(children: [
              Column(children: [
                Container(
                  height: 28,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: borderColor,
                      ),
                    ),
                  ),
                  width: double.infinity,
                  child: Text(
                    'Expense settings',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: hintTextColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RepeatedTransactions.RepeatedTransactions()),
                    );
                  },
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1.0,
                          color: borderColor,
                        ),
                      ),
                    ),
                    child: Text(
                      'Repeated transactions',
                      style: TextStyle(
                        fontSize: 14.0,
                        height:
                            2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("budget was tapped");
                  },
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1.0,
                          color: borderColor,
                        ),
                      ),
                    ),
                    child: Text(
                      'Budget',
                      style: TextStyle(
                        fontSize: 14.0,
                        height:
                            2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Wallets.Wallets()),
                    );
                  },
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1.0,
                          color: borderColor,
                        ),
                      ),
                    ),
                    child: Text(
                      'Wallet',
                      style: TextStyle(
                        fontSize: 14.0,
                        height:
                            2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("category was tapped");
                  },
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1.0,
                          color: borderColor,
                        ),
                      ),
                    ),
                    child: Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 14.0,
                        height:
                            2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 32,
                ),
                Container(
                  height: 28,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: borderColor,
                      ),
                    ),
                  ),
                  width: double.infinity,
                  child: Text(
                    'General settings',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: hintTextColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("date format was tapped");
                  },
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1.0,
                          color: borderColor,
                        ),
                      ),
                    ),
                    child: Text(
                      'Date format',
                      style: TextStyle(
                        fontSize: 14.0,
                        height:
                            2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("reminders was tapped");
                  },
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1.0,
                          color: borderColor,
                        ),
                      ),
                    ),
                    child: Text(
                      'Reminders',
                      style: TextStyle(
                        fontSize: 14.0,
                        height:
                            2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 32,
                ),
                GestureDetector(
                  onTap: () {
                    print("help faq was tapped");
                  },
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1.0,
                          color: borderColor,
                        ),
                      ),
                    ),
                    child: Text(
                      'Help/FAQ',
                      style: TextStyle(
                        fontSize: 14.0,
                        height:
                            2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("feedback was tapped");
                  },
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1.0,
                          color: borderColor,
                        ),
                      ),
                    ),
                    child: Text(
                      'Feedback',
                      style: TextStyle(
                        fontSize: 14.0,
                        height:
                            2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print("rate it was tapped");
                  },
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    child: Text(
                      'Rate it',
                      style: TextStyle(
                        fontSize: 14.0,
                        height:
                            2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                      ),
                    ),
                  ),
                ),
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}
