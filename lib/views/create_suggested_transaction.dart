import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'suggested_transactions.dart' as SuggestedTransactions;

class CreateSuggestedTransaction extends StatefulWidget {
  CreateSuggestedTransaction();
  @override
  _CreateSuggestedTransactionState createState() =>
      _CreateSuggestedTransactionState();
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

class _CreateSuggestedTransactionState
    extends State<CreateSuggestedTransaction> {
  static const IconData warning = IconData(0xe6cb, fontFamily: 'MaterialIcons');

  Color borderColor = Color(0xFFEBEDEF);
  Color backgroundColor = Color(0xFFFFFFFF);
  Color addButtonColor = Color(0xFF24324A);
  Color hintTextColor = Color(0xFF9CA3AD);
  Color whenButtonInactiveColor = Color(0xFFC4C8CE);
  double transaction_amount = 0;
  Category transaction_category;
  List<Category> all_categories = [
    Category(
      name: 'Select',
      type: '-',
    ),
  ];

  bool categoryNameError = false;
  bool amountError = false;
  bool categoryError = false;

  String transaction_name = '';

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  _loadCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List expense_categories_local = [];
    List income_categories_local = [];

    if (prefs.getString('expense_categories') == null) {
      expense_categories_local = [
        {'name': 'Auto & Parking', 'type': 'expense'},
        {'name': 'bills', 'type': 'expense'},
        {'name': 'business', 'type': 'expense'},
        {'name': 'Cash & Cheque', 'type': 'expense'},
        {'name': 'education', 'type': 'expense'},
        {'name': 'entertainment', 'type': 'expense'},
        {'name': 'Gift & Charity', 'type': 'expense'},
        {'name': 'grocery', 'type': 'expense'},
        {'name': 'family', 'type': 'expense'},
        {'name': 'Food & Drink', 'type': 'expense'},
        {'name': 'fuel', 'type': 'expense'},
        {'name': 'Health & Medical', 'type': 'expense'},
        {'name': 'insurance', 'type': 'expense'},
        {'name': 'kid', 'type': 'expense'},
        {'name': 'Personal Care', 'type': 'expense'},
        {'name': 'pet', 'type': 'expense'},
        {'name': 'rental', 'type': 'expense'},
        {'name': 'shopping', 'type': 'expense'},
        {'name': 'subscription', 'type': 'expense'},
        {'name': 'tax', 'type': 'expense'},
        {'name': 'taxi', 'type': 'expense'},
        {'name': 'Public Transport', 'type': 'expense'},
        {'name': 'travel', 'type': 'expense'},
      ];
      var stringList = jsonEncode(expense_categories_local);
      prefs.setString('expense_categories', stringList);
    } else {
      expense_categories_local =
          jsonDecode(prefs.getString('expense_categories'));
    }

    if (prefs.getString('income_categories') == null) {
      income_categories_local = [
        {'name': 'bonus', 'type': 'income'},
        {'name': 'deposit', 'type': 'income'},
        {'name': 'investment', 'type': 'income'},
        {'name': 'refund', 'type': 'income'},
        {'name': 'salary', 'type': 'income'},
        {'name': 'Other Income', 'type': 'income'}
      ];
      var stringList = jsonEncode(income_categories_local);
      prefs.setString('income_categories', stringList);
    } else {
      income_categories_local =
          jsonDecode(prefs.getString('income_categories'));
    }

    List<Category> expense_categories_local2 = expense_categories_local
        .map((category) =>
            Category(name: category['name'], type: category['type']))
        .toList();

    List<Category> income_categories_local2 = income_categories_local
        .map((category) =>
            Category(name: category['name'], type: category['type']))
        .toList();

    setState(() {
      all_categories =
          all_categories + expense_categories_local2 + income_categories_local2;

      if (all_categories.length != 0) {
        transaction_category = all_categories[0];
      }
    });
  }

  _store_category() async {
    if (transaction_name == '') {
      categoryNameError = true;
      setState(() {});
      return false;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var new_suggested_transaction = {
      'note': transaction_name,
      'category': transaction_category,
      'price': transaction_amount
    };

    // Fetch and decode data
    final String existing_suggested_transactions =
        await prefs.getString('saved_suggested_transactions');

    if (existing_suggested_transactions == null) {
      var encodedData = [new_suggested_transaction];
      var stringList = jsonEncode(encodedData);

      prefs.setString('saved_suggested_transactions', stringList);
    } else {
      var decodedData = jsonDecode(existing_suggested_transactions);

      decodedData.add(new_suggested_transaction);

      var stringList = jsonEncode(decodedData);
      prefs.setString('saved_suggested_transactions', stringList);
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => SuggestedTransactions.SuggestedTransactions()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Add Suggested Transaction'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Column(children: [
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
                      child: DropdownButton<Category>(
                    icon: Visibility(
                      visible: false,
                      child: Icon(Icons.arrow_downward),
                    ),
                    items: all_categories.map((Category value) {
                      return DropdownMenuItem<Category>(
                        value: value,
                        child: Container(
                          width: (width - 16 - 16) / 2,
                          child: Text(
                            (value.name == 'Select')
                                ? value.name
                                : "${value.type.toString()[0].toUpperCase()}${value.type.toString().substring(1)}" +
                                    '/' +
                                    "${value.name.toString()[0].toUpperCase()}${value.name.toString().substring(1)}",
                            style: value.name == 'Select'
                                ? TextStyle(color: hintTextColor, fontSize: 14)
                                : TextStyle(fontSize: 14),
                            textAlign: TextAlign.right, //this will do that
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        transaction_category = value;
                      });
                    },
                    underline: SizedBox(),
                    value: transaction_category,
                  )),
                ],
              ),
            ),
            if (categoryError == true)
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                height: 20,
                width: double.infinity,
                child: Text(
                  'Select a category',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                  ),
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
                      'Price',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(
                          text: transaction_amount.toStringAsFixed(2)),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      onChanged: (content) {
                        transaction_amount = double.parse(content);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '\$0',
                        hintStyle: TextStyle(
                          fontSize: 14.0,
                          color: hintTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (amountError == true)
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                height: 20,
                width: double.infinity,
                child: Text(
                  'Enter the transaction amount',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                  ),
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
                      'Note',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: ''),
                      textAlign: TextAlign.right,
                      onChanged: (content) {
                        transaction_name = content;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name your category',
                        hintStyle: TextStyle(
                          fontSize: 14.0,
                          color: hintTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (categoryNameError == true)
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                height: 20,
                width: double.infinity,
                child: Text(
                  'Add a note for easy recognition.',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
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
                        if (transaction_category.name == 'Select') {
                          setState(() {
                            categoryError = true;
                          });
                        } else {
                          setState(() {
                            categoryError = false;
                          });
                        }
                        if (transaction_amount == 0.0) {
                          setState(() {
                            amountError = true;
                          });
                        } else {
                          setState(() {
                            amountError = false;
                          });
                        }
                        _store_category();
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
        ),
      ),
    );
  }
}
