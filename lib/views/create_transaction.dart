import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateTransaction extends StatefulWidget {
  @override
  _CreateTransactionState createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  String selectedWhen = 'today';
  Color borderColor = Color(0xFFEBEDEF);
  Color hintTextColor = Color(0xFF9CA3AD);
  Color backgroundColor = Color(0xFFFFFFFF);
  Color addButtonColor = Color(0xFF24324A);
  Color whenButtonInactiveColor = Color(0xFFC4C8CE);
  Color whenButtonInactiveTextColor = Color(0xFF9CA3AD);
  Color whenButtonActiveColor = Color(0xFF24324A);
  Color whenButtonActiveTextColor = Color(0xFF24324A);

  var formatter = NumberFormat('#,##,###.00#');

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Transaction'),
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
          child: SingleChildScrollView(
            child: Stack(children: [
              Column(children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: borderColor,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Amount',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '0.00',
                            hintStyle: TextStyle(
                              color: hintTextColor,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 32,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: borderColor,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Category',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Expanded(
                          child: DropdownButton<String>(
                        icon: Visibility(
                          visible: false,
                          child: Icon(Icons.arrow_downward),
                        ),
                        items: <String>[
                          'Select',
                          'Cash',
                          'Debit Card',
                          'Bank Account',
                          'Credit Card',
                          'Loan Account'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                              width: (width - 16 - 16) / 2,
                              child: Text(
                                value,
                                style: value == 'Select'
                                    ? TextStyle(
                                        color: hintTextColor, fontSize: 14)
                                    : TextStyle(fontSize: 14),
                                textAlign: TextAlign.right, //this will do that
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          // setState(() {
                          //   walletType = value;
                          // });
                          // print('Changed wallet type');
                          // print(walletType);
                        },
                        underline: SizedBox(),
                        value: 'Select',
                      )),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: borderColor,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Wallet',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Expanded(
                          child: DropdownButton<String>(
                        icon: Visibility(
                          visible: false,
                          child: Icon(Icons.arrow_downward),
                        ),
                        items: <String>[
                          'Select',
                          'Cash',
                          'Debit Card',
                          'Bank Account',
                          'Credit Card',
                          'Loan Account'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                              width: (width - 16 - 16) / 2,
                              child: Text(
                                value,
                                style: value == 'Select'
                                    ? TextStyle(
                                        color: hintTextColor, fontSize: 14)
                                    : TextStyle(fontSize: 14),
                                textAlign: TextAlign.right, //this will do that
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          // setState(() {
                          //   walletType = value;
                          // });
                          // print('Changed wallet type');
                          // print(walletType);
                        },
                        underline: SizedBox(),
                        value: 'Select',
                      )),
                    ],
                  ),
                ),
                Container(
                  height: 32,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: borderColor,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'When',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 75,
                        height: 36,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(6.0),
                              side: BorderSide(
                                color: selectedWhen == 'today'
                                    ? whenButtonActiveColor
                                    : whenButtonInactiveColor,
                              )),
                          elevation: 0,
                          color: backgroundColor,
                          onPressed: () {
                            setState(() {
                              selectedWhen = 'today';
                            });
                          },
                          child: Text(
                            'Today',
                            style: TextStyle(
                              color: selectedWhen == 'today'
                                  ? whenButtonActiveTextColor
                                  : whenButtonInactiveTextColor,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 8,
                      ),
                      ButtonTheme(
                        minWidth: 82,
                        height: 36,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(6.0),
                              side: BorderSide(
                                color: selectedWhen == 'yesterday'
                                    ? whenButtonActiveColor
                                    : whenButtonInactiveColor,
                              )),
                          elevation: 0,
                          color: backgroundColor,
                          onPressed: () {
                            setState(() {
                              selectedWhen = 'yesterday';
                            });
                          },
                          child: Text(
                            'Yesterday',
                            style: TextStyle(
                              color: selectedWhen == 'yesterday'
                                  ? whenButtonActiveTextColor
                                  : whenButtonInactiveTextColor,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 8,
                      ),
                      ButtonTheme(
                        minWidth: 68,
                        height: 36,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(6.0),
                              side: BorderSide(
                                color: selectedWhen == 'custom'
                                    ? whenButtonActiveColor
                                    : whenButtonInactiveColor,
                              )),
                          elevation: 0,
                          color: backgroundColor,
                          onPressed: () {
                            setState(() {
                              selectedWhen = 'custom';
                            });
                          },
                          child: Text(
                            'Custom',
                            style: TextStyle(
                              color: selectedWhen == 'custom'
                                  ? whenButtonActiveTextColor
                                  : whenButtonInactiveTextColor,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: borderColor,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Repeat (Optional)',
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                      Expanded(
                          child: DropdownButton<String>(
                        icon: Visibility(
                          visible: false,
                          child: Icon(Icons.arrow_downward),
                        ),
                        items: <String>[
                          'Select',
                          'Cash',
                          'Debit Card',
                          'Bank Account',
                          'Credit Card',
                          'Loan Account'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                              width: (width - 16 - 16) / 2,
                              child: Text(
                                value,
                                style: value == 'Select'
                                    ? TextStyle(
                                        color: hintTextColor, fontSize: 14)
                                    : TextStyle(fontSize: 14),
                                textAlign: TextAlign.right, //this will do that
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          // setState(() {
                          //   walletType = value;
                          // });
                          // print('Changed wallet type');
                          // print(walletType);
                        },
                        underline: SizedBox(),
                        value: 'Select',
                      )),
                    ],
                  ),
                ),
                Container(
                  height: 32,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1.0,
                        color: borderColor,
                      ),
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description (Optional)',
                      hintStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 32,
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
                            // print('save wallet');
                            // print(walletName);
                            // if (walletName == '') {
                            //   setState(() {
                            //     walletNameError = true;
                            //   });
                            // } else {
                            //   setState(() {
                            //     walletNameError = false;
                            //   });
                            // }
                            // if (walletType == 'Select') {
                            //   setState(() {
                            //     walletTypeError = true;
                            //   });
                            // } else {
                            //   setState(() {
                            //     walletTypeError = false;
                            //   });
                            // }
                            // if (walletNameError == true ||
                            //     walletTypeError == true) {
                            //   return false;
                            // }
                            // _store_wallet();
                          },
                          child: Text(
                            'Add',
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
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}
