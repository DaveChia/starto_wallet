import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'transaction_added_success.dart' as QuickAddTransactionSuccess;
import 'package:intl/intl.dart';

class QuickAddTransactionKey extends StatefulWidget {
  String category_type;
  String category_name;
  String transaction_type;

  QuickAddTransactionKey(
      {this.transaction_type, this.category_type, this.category_name});
  @override
  _QuickAddTransactionKeyState createState() => _QuickAddTransactionKeyState();
}

class Transaction {
  final double amount;
  final Category category;
  // final Wallet wallet;
  final String description;
  final DateTime date;

  Transaction(
      {@required this.amount,
      @required this.category,
      // @required this.wallet,
      @required this.description,
      @required this.date});

  Transaction.fromJson(Map<String, dynamic> json)
      : amount = json['amount'],
        category = json['category'],
        // wallet = json['wallet'],
        description = json['description'],
        date = json['date'];

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'category': category.toJson(),
      // 'wallet': wallet.toJson(),
      'description': description,
      'date': date.toString(),
    };
  }
}

class Category {
  final String name;
  final String type;

  Category({@required this.name, @required this.type});

  // factory Category.fromJson(Map<String, dynamic> json) {
  //   return Category(
  //     name: json['name'],
  //     type: json['type'],
  //   );
  // }

  Category.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = json['type'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
    };
  }
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
  String note = '';
  String selected_date = 'Today';

  String selected_transaction_sub_type = 'expense';

  DateTime selectedCustomDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedCustomDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedCustomDate)
      setState(() {
        String formattedDate = DateFormat('yyyy MMMM dd').format(picked);
        selected_date = formattedDate.toString();
      });
  }

  _saveTransaction() async {
    //  Save transaction here
    print(amount);
    print(note);
    print(selected_date);

    if (selected_date == 'Today') {
      selected_date = DateTime.now().toString();
    }

    Category transaction_data_category =
        Category(name: widget.category_name, type: widget.category_type);

    final new_transaction = Transaction(
        amount: double.parse(amount),
        category: transaction_data_category,
        description: note,
        date: new DateFormat("yyyy-MM-dd").parse(selected_date));

    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Fetch and decode data
    final String existing_transactions = await prefs.getString('transactions');

    if (existing_transactions == null) {
      var encodedData = [new_transaction.toJson()];

      var stringList = jsonEncode(encodedData);

      prefs.setString('transactions', stringList);
    } else {
      var decodedData = jsonDecode(existing_transactions);

      decodedData.add(new_transaction.toJson());
      var stringList = jsonEncode(decodedData);
      prefs.setString('transactions', stringList);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              QuickAddTransactionSuccess.TransactionAddedSuccess()),
    );
  }

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
        title: Text('Add ' +
            '${widget.transaction_type.toString()[0].toUpperCase()}${widget.transaction_type.toString().substring(1)}'),
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
                          margin: EdgeInsets.only(top: 5),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 10, bottom: 10, left: 10, right: 10),
                            child: Text(
                              '${widget.category_name.toString()[0].toUpperCase()}${widget.category_name.toString().substring(1)}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xFF9CA3AD),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              width: 1.0,
                              color: transfer_color,
                            ),
                          ),
                        ),
                        TextField(
                          controller: TextEditingController(text: note),
                          textAlign: TextAlign.center,
                          onChanged: (content) {
                            note = content;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Add a description here',
                            hintStyle: TextStyle(
                              fontSize: 14.0,
                              color: hintTextColor,
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
                        selected_date,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            height:
                                1.25 //HACK, need to find better way to align vertical center and horizontal center at the same time
                            ),
                      ),
                      elevation: 0,
                      color: buttonTopRowColor,
                      onPressed: () {
                        _selectDate(context);
                      },
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
                            if (amount == '' ||
                                double.parse(amount) <= 0 ||
                                note == '') {
                              showAlertDialog(context);
                            } else {
                              _saveTransaction();
                            }
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

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Errors:",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.red,
          fontSize: 16.0,
        ),
      ),
      content: Text('Please include the transaction amount and description.'),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
