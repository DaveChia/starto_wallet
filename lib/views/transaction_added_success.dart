import 'package:flutter/material.dart';
import './quick_add_transaction.dart' as QuickAddTransaction;
import 'package:starto_wallet/main.dart' as Main;

class TransactionAddedSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color borderColor = Color(0xFFEBEDEF);
    Color hintTextColor = Color(0xFF9CA3AD);
    Color addButtonColor = Color(0xFF24324A);
    Color backgroundColor = Color(0xFFFFFFFF);
    Color nav_border_color = Color(0xFF24324A1A);
    Color selected_nav_color = Color(0xFF0472FF);
    Color unselected_nav_color = Color(0xFF616C7D);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Container(height: 130),
              Image.asset('assets/images/quick_add_transaction_success.png'),
              Container(
                margin: EdgeInsets.only(top: 90, bottom: 15),
                child: Text(
                  'Nice!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Color(0xFF24324A),
                  ),
                ),
                width: double.infinity,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 50),
                child: Text(
                  'You have successfully added a new transaction',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF9CA3AD),
                  ),
                ),
                width: double.infinity,
              ),
              Row(
                children: [
                  Expanded(
                    child: ButtonTheme(
                      height: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(100.0),
                        ),
                        elevation: 0,
                        color: addButtonColor,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Main.MyApp()),
                          );
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(height: 15),
              Row(
                children: [
                  Expanded(
                    child: ButtonTheme(
                      height: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          side: new BorderSide(color: Color(0xFF24324A)),
                          borderRadius: new BorderRadius.circular(100.0),
                        ),
                        elevation: 0,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    QuickAddTransaction.QuickAddTransaction()),
                          );
                        },
                        child: Text(
                          'Add another transaction',
                          style: TextStyle(
                            color: addButtonColor,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // child: Column(
        //   children: [
        //     Padding(
        //       padding: EdgeInsets.only(left: 40, right: 40),
        //       child: Text('123'),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
