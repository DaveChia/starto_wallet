import 'dart:ffi';

import 'package:flutter/material.dart';
import 'transaction_added_success.dart' as QuickAddTransactionSuccess;

class QuickAddTransactionKey extends StatefulWidget {
  QuickAddTransactionKey();
  @override
  _QuickAddTransactionKeyState createState() => _QuickAddTransactionKeyState();
}

class _QuickAddTransactionKeyState extends State<QuickAddTransactionKey> {
  static const IconData warning = IconData(0xe6cb, fontFamily: 'MaterialIcons');

  Color borderColor = Color(0xFFEBEDEF);
  Color backgroundColor = Color(0xFFFFFFFF);
  Color addButtonColor = Color(0xFF24324A);
  Color hintTextColor = Color(0xFF9CA3AD);
  Color whenButtonInactiveColor = Color(0xFFC4C8CE);
  Color transfer_color = Color(0xFFC4C8CE);
  Color unselected_nav_color = Color(0xFF616C7D);
  Color buttonTopRowColor = Color(0xFFFFD159);
  Color buttonBottomRowColor = Color(0xFFF5F6F7);
  Color dragHintCOlor = Color(0xFFC4C8CE);

  String amount = '';

  String selected_transaction_sub_type = 'expense';

  calculate(data) {
    // print(amount.toString());

    if (amount == '' && data != '.' && data != 'delete') {
      amount = data;
    } else if (data == 'delete') {
      amount = amount.substring(0, amount.length - 1);
    } else {
      if (amount.length < 8) {
        if (amount.indexOf('.') == -1) {
          if (amount == '') {
            amount += '0' + data;
          } else {
            amount += data;
          }
        } else if (amount.indexOf('.') != -1 &&
            amount.length - amount.indexOf('.') <= 2) {
          amount += data;
        }
      }
    }

    // amount = amount + data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double viewHeight = MediaQuery.of(context).size.height -
        74 -
        105 -
        136 -
        MediaQuery.of(context).viewPadding.top - // height of status bar
        AppBar().preferredSize.height; //  height of AppBar
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Add Transasssction'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.cancel_outlined),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(
            children: [
              Container(
                  height: viewHeight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 70,
                          width: double.infinity,
                          child: Text(
                            '\$' + (amount == '' ? '0' : amount),
                            style: TextStyle(
                              fontSize: 60.0,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 25,
                          width: double.infinity,
                          child: Text(
                            'Lunch',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xFF9CA3AD),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'Today',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            height:
                                1.25 //HACK, need to find better way to align vertical center and horizontal center at the same time
                            ),
                      ),
                      elevation: 0,
                      color: buttonTopRowColor,
                      onPressed: () {},
                    ),
                  ),
                  Container(width: 5),
                  Expanded(
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'Repeated',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            height:
                                1.25 //HACK, need to find better way to align vertical center and horizontal center at the same time
                            ),
                      ),
                      elevation: 0,
                      color: buttonTopRowColor,
                      onPressed: () {},
                    ),
                  ),
                  Container(width: 5),
                  Expanded(
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'Note',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            height:
                                1.25 //HACK, need to find better way to align vertical center and horizontal center at the same time
                            ),
                      ),
                      elevation: 0,
                      color: buttonTopRowColor,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              Container(height: 15),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '1',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          // height:
                          //     1.25 //HACK, need to find better way to align vertical center and horizontal center at the same time
                        ),
                      ),
                      elevation: 0,
                      color: buttonBottomRowColor,
                      onPressed: () {
                        calculate('1');
                      },
                    ),
                  ),
                  Container(width: 5),
                  Expanded(
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '2',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          // height:
                          //     1.25 //HACK, need to find better way to align vertical center and horizontal center at the same time
                        ),
                      ),
                      elevation: 0,
                      color: buttonBottomRowColor,
                      onPressed: () {
                        calculate('2');
                      },
                    ),
                  ),
                  Container(width: 5),
                  Expanded(
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '3',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                          // height:
                          //     1.25 //HACK, need to find better way to align vertical center and horizontal center at the same time
                        ),
                      ),
                      elevation: 0,
                      color: buttonBottomRowColor,
                      onPressed: () {
                        calculate('3');
                      },
                    ),
                  ),
                ],
              ),
              Container(height: 5),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '4',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            height:
                                1.25 //HACK, need to find better way to align vertical center and horizontal center at the same time
                            ),
                      ),
                      elevation: 0,
                      color: buttonBottomRowColor,
                      onPressed: () {
                        calculate('4');
                      },
                    ),
                  ),
                  Container(width: 5),
                  Expanded(
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '5',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            height:
                                1.25 //HACK, need to find better way to align vertical center and horizontal center at the same time
                            ),
                      ),
                      elevation: 0,
                      color: buttonBottomRowColor,
                      onPressed: () {
                        calculate('5');
                      },
                    ),
                  ),
                  Container(width: 5),
                  Expanded(
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '6',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            height:
                                1.25 //HACK, need to find better way to align vertical center and horizontal center at the same time
                            ),
                      ),
                      elevation: 0,
                      color: buttonBottomRowColor,
                      onPressed: () {
                        calculate('6');
                      },
                    ),
                  ),
                ],
              ),
              Container(height: 5),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '7',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            height:
                                1.25 //HACK, need to find better way to align vertical center and horizontal center at the same time
                            ),
                      ),
                      elevation: 0,
                      color: buttonBottomRowColor,
                      onPressed: () {
                        calculate('7');
                      },
                    ),
                  ),
                  Container(width: 5),
                  Expanded(
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '8',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            height:
                                1.25 //HACK, need to find better way to align vertical center and horizontal center at the same time
                            ),
                      ),
                      elevation: 0,
                      color: buttonBottomRowColor,
                      onPressed: () {
                        calculate('8');
                      },
                    ),
                  ),
                  Container(width: 5),
                  Expanded(
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '9',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            height:
                                1.25 //HACK, need to find better way to align vertical center and horizontal center at the same time
                            ),
                      ),
                      elevation: 0,
                      color: buttonBottomRowColor,
                      onPressed: () {
                        calculate('9');
                      },
                    ),
                  ),
                ],
              ),
              Container(height: 5),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            height:
                                1.25 //HACK, need to find better way to align vertical center and horizontal center at the same time
                            ),
                      ),
                      elevation: 0,
                      color: buttonBottomRowColor,
                      onPressed: () {
                        calculate('.');
                      },
                    ),
                  ),
                  Container(width: 5),
                  Expanded(
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '0',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            height:
                                1.25 //HACK, need to find better way to align vertical center and horizontal center at the same time
                            ),
                      ),
                      elevation: 0,
                      color: buttonBottomRowColor,
                      onPressed: () {
                        calculate('0');
                      },
                    ),
                  ),
                  Container(width: 5),
                  Expanded(
                    child: RaisedButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        'Delete',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            height:
                                1.25 //HACK, need to find better way to align vertical center and horizontal center at the same time
                            ),
                      ),
                      elevation: 0,
                      color: buttonBottomRowColor,
                      onPressed: () {
                        calculate('delete');
                      },
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
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
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => Main.MyApp()),
                            // );
                          },
                          child: Text(
                            'Save',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
