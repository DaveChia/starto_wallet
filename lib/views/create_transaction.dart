import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart' as Main;

class CreateTransaction extends StatefulWidget {
  @override
  _CreateTransactionState createState() => _CreateTransactionState();
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

class Wallet {
  final String name;
  final String type;

  Wallet({@required this.name, @required this.type});

  // factory Wallet.fromJson(Map<String, dynamic> json) {
  //   return Wallet(
  //     name: json['name'],
  //     type: json['type'],
  //   );
  // }

  Wallet.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = json['type'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
    };
  }
}

class _CreateTransactionState extends State<CreateTransaction> {
  String selectedWhen = 'today';
  double transaction_amount = 0;
  String transaction_description = '';
  Color borderColor = Color(0xFFEBEDEF);
  Color hintTextColor = Color(0xFF9CA3AD);
  Color backgroundColor = Color(0xFFFFFFFF);
  Color addButtonColor = Color(0xFF24324A);
  Color whenButtonInactiveColor = Color(0xFFC4C8CE);
  Color whenButtonInactiveTextColor = Color(0xFF9CA3AD);
  Color whenButtonActiveColor = Color(0xFF24324A);
  Color whenButtonActiveTextColor = Color(0xFF24324A);
  List<Category> all_categories = [
    Category(
      name: 'Select',
      type: '-',
    ),
    Category(
      name: 'transfer',
      type: 'transfer',
    ),
  ];
  List<Wallet> all_wallets = [
    Wallet(
      name: 'Select',
      type: '-',
    ),
  ];
  bool amountError = false;
  bool categoryError = false;
  bool walletError = false;

  Category transaction_category;
  Wallet transaction_wallet;

  var formatter = NumberFormat('#,##,###.00#');

  @override
  void initState() {
    super.initState();
    print('333 I AM STARTING create transaction');
    _loadCategoriesAndWallets();
  }

  _loadCategoriesAndWallets() async {
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

    //  Wallet functionalities temporary disabled
    // Load Wallets
    // List<Wallet> all_wallets_local = [];
    // List bank_wallets_local = [];
    // List cash_wallets_local = [];
    // List credit_cards_wallets_local = [];
    // List loan_wallets_local = [];
    // List insurance_wallets_local = [];
    // List investment_wallets_local = [];

    // if (prefs.getString('bank_account_wallets') != null) {
    //   bank_wallets_local = jsonDecode(prefs.getString('bank_account_wallets'));
    //   List<Wallet> bank_wallets_local2 = bank_wallets_local
    //       .map((wallet) => Wallet(name: wallet['name'], type: wallet['type']))
    //       .toList();
    //   all_wallets_local.addAll(bank_wallets_local2);
    // }

    // if (prefs.getString('cash_wallets') != null) {
    //   cash_wallets_local = jsonDecode(prefs.getString('cash_wallets'));
    //   List<Wallet> cash_wallets_local2 = cash_wallets_local
    //       .map((wallet) => Wallet(name: wallet['name'], type: wallet['type']))
    //       .toList();
    //   all_wallets_local.addAll(cash_wallets_local2);
    // }

    // if (prefs.getString('credit_card_wallets') != null) {
    //   credit_cards_wallets_local =
    //       jsonDecode(prefs.getString('credit_card_wallets'));
    //   List<Wallet> credit_cards_wallets_local2 = credit_cards_wallets_local
    //       .map((wallet) => Wallet(name: wallet['name'], type: wallet['type']))
    //       .toList();
    //   all_wallets_local.addAll(credit_cards_wallets_local2);
    // }

    // if (prefs.getString('loan_wallets') != null) {
    //   loan_wallets_local = jsonDecode(prefs.getString('loan_wallets'));
    //   List<Wallet> loan_wallets_local2 = loan_wallets_local
    //       .map((wallet) => Wallet(name: wallet['name'], type: wallet['type']))
    //       .toList();
    //   all_wallets_local.addAll(loan_wallets_local2);
    // }

    // if (prefs.getString('insurance_wallets') != null) {
    //   insurance_wallets_local =
    //       jsonDecode(prefs.getString('insurance_wallets'));
    //   List<Wallet> insurance_wallets_local2 = insurance_wallets_local
    //       .map((wallet) => Wallet(name: wallet['name'], type: wallet['type']))
    //       .toList();
    //   all_wallets_local.addAll(insurance_wallets_local2);
    // }

    // if (prefs.getString('investment_wallets') != null) {
    //   investment_wallets_local =
    //       jsonDecode(prefs.getString('investment_wallets'));
    //   List<Wallet> investment_wallets_local2 = investment_wallets_local
    //       .map((wallet) => Wallet(name: wallet['name'], type: wallet['type']))
    //       .toList();
    //   all_wallets_local.addAll(investment_wallets_local2);
    // }

    setState(() {
      all_categories =
          all_categories + expense_categories_local2 + income_categories_local2;
      // all_wallets = all_wallets + all_wallets_local;
      if (all_categories.length != 0) {
        transaction_category = all_categories[0];
      }

      // if (all_wallets.length != 0) {
      //   transaction_wallet = all_wallets[0];
      // }
    });
  }

  _saveTransaction() async {
    DateTime selected_date = DateTime.now();

    if (selectedWhen == 'yesterday') {
      selected_date = DateTime.now().subtract(Duration(days: 1));
    }

    if (selectedWhen == 'custom') {
      selected_date = selectedCustomDate;
    }

    final new_transaction = Transaction(
        amount: transaction_amount,
        category: transaction_category,
        // wallet: transaction_wallet,
        description: transaction_description,
        date: selected_date);

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

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Main.MyApp()),
      (route) => false,
    );
  }

  DateTime selectedCustomDate = DateTime.now();
  TextEditingController _date = new TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedCustomDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedCustomDate)
      setState(() {
        selectedCustomDate = picked;
        _date.value = TextEditingValue(text: picked.toString());
      });
  }

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
                          onChanged: (content) {
                            transaction_amount = double.parse(content);
                            setState(() {});
                          },
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
                                    ? TextStyle(
                                        color: hintTextColor, fontSize: 14)
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
                          print('Changed transaction_category');
                          print(transaction_category);
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
                //  Wallet functionalities temporary disabled
                // Container(
                //   height: 50,
                //   decoration: BoxDecoration(
                //     border: Border(
                //       bottom: BorderSide(
                //         width: 1.0,
                //         color: borderColor,
                //       ),
                //     ),
                //   ),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Text(
                //           'Wallet',
                //           style: TextStyle(
                //             fontSize: 14.0,
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //           child: DropdownButton<Wallet>(
                //         icon: Visibility(
                //           visible: false,
                //           child: Icon(Icons.arrow_downward),
                //         ),
                //         items: all_wallets.map((Wallet value) {
                //           return DropdownMenuItem<Wallet>(
                //             value: value,
                //             child: Container(
                //               width: (width - 16 - 16) / 2,
                //               child: Text(
                //                 (value.name == 'Select')
                //                     ? value.name
                //                     : "${value.type.toString()[0].toUpperCase()}${value.type.toString().substring(1)}" +
                //                         '/' +
                //                         "${value.name.toString()[0].toUpperCase()}${value.name.toString().substring(1)}",
                //                 style: value.name == 'Select'
                //                     ? TextStyle(
                //                         color: hintTextColor, fontSize: 14)
                //                     : TextStyle(fontSize: 14),
                //                 textAlign: TextAlign.right, //this will do that
                //               ),
                //             ),
                //           );
                //         }).toList(),
                //         onChanged: (value) {
                //           setState(() {
                //             transaction_wallet = value;
                //           });
                //         },
                //         underline: SizedBox(),
                //         value: transaction_wallet,
                //       )),
                //     ],
                //   ),
                // ),
                // if (walletError == true)
                //   Container(
                //     margin: const EdgeInsets.only(top: 8, bottom: 8),
                //     height: 20,
                //     width: double.infinity,
                //     child: Text(
                //       'Select a wallet',
                //       textAlign: TextAlign.right,
                //       style: TextStyle(
                //         color: Colors.red,
                //         fontSize: 12.0,
                //       ),
                //     ),
                //   ),
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
                          child: Row(
                            children: [
                              // if (selectedWhen == 'today')
                              //   Icon(
                              //     Icons.check,
                              //     color: addButtonColor,
                              //     size: 14,
                              //   ),
                              // Container(
                              //   width: 5,
                              //   height: 36,
                              // ),
                              Text(
                                'Today',
                                style: TextStyle(
                                  color: selectedWhen == 'today'
                                      ? whenButtonActiveTextColor
                                      : whenButtonInactiveTextColor,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
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
                          child: Row(
                            children: [
                              // if (selectedWhen == 'yesterday')
                              //   Icon(
                              //     Icons.check,
                              //     color: addButtonColor,
                              //     size: 14,
                              //   ),
                              // Container(
                              //   width: 5,
                              //   height: 36,
                              // ),
                              Text(
                                'Yesterday',
                                style: TextStyle(
                                  color: selectedWhen == 'yesterday'
                                      ? whenButtonActiveTextColor
                                      : whenButtonInactiveTextColor,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
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
                            _selectDate(context);
                            setState(() {
                              selectedWhen = 'custom';
                            });
                          },
                          child: Row(
                            children: [
                              // if (selectedWhen == 'custom')
                              //   Icon(
                              //     Icons.check,
                              //     color: addButtonColor,
                              //     size: 14,
                              //   ),
                              // Container(
                              //   width: 5,
                              //   height: 36,
                              // ),
                              Text(
                                (selectedWhen == 'custom')
                                    ? DateFormat('y MMM d')
                                        .format(selectedCustomDate)
                                    : 'Custom',
                                style: TextStyle(
                                  color: selectedWhen == 'custom'
                                      ? whenButtonActiveTextColor
                                      : whenButtonInactiveTextColor,
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //  Temp disabled until we have backend to do cronjob calculations
                // Container(
                //   height: 50,
                //   decoration: BoxDecoration(
                //     border: Border(
                //       bottom: BorderSide(
                //         width: 1.0,
                //         color: borderColor,
                //       ),
                //     ),
                //   ),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Text(
                //           'Repeat (Optional)',
                //           style: TextStyle(
                //             fontSize: 14.0,
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //           child: DropdownButton<String>(
                //         icon: Visibility(
                //           visible: false,
                //           child: Icon(Icons.arrow_downward),
                //         ),
                //         items: <String>[
                //           'Select',
                //           'Cash',
                //           'Debit Card',
                //           'Bank Account',
                //           'Credit Card',
                //           'Loan Account'
                //         ].map((String value) {
                //           return DropdownMenuItem<String>(
                //             value: value,
                //             child: Container(
                //               width: (width - 16 - 16) / 2,
                //               child: Text(
                //                 value,
                //                 style: value == 'Select'
                //                     ? TextStyle(
                //                         color: hintTextColor, fontSize: 14)
                //                     : TextStyle(fontSize: 14),
                //                 textAlign: TextAlign.right, //this will do that
                //               ),
                //             ),
                //           );
                //         }).toList(),
                //         onChanged: (value) {
                //           // setState(() {
                //           //   walletType = value;
                //           // });
                //           // print('Changed wallet type');
                //           // print(walletType);
                //         },
                //         underline: SizedBox(),
                //         value: 'Select',
                //       )),
                //     ],
                //   ),
                // ),
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
                    onChanged: (content) {
                      transaction_description = content;
                      setState(() {});
                    },
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
                            print(selectedCustomDate);
                            if (transaction_category.name == 'Select') {
                              setState(() {
                                categoryError = true;
                              });
                            } else {
                              setState(() {
                                categoryError = false;
                              });
                            }
                            //  Wallet functionalities temporary disabled
                            // if (transaction_wallet.name == 'Select') {
                            //   setState(() {
                            //     walletError = true;
                            //   });
                            // } else {
                            //   setState(() {
                            //     walletError = false;
                            //   });
                            // }
                            if (transaction_amount == 0.0) {
                              setState(() {
                                amountError = true;
                              });
                            } else {
                              setState(() {
                                amountError = false;
                              });
                            }

                            if (categoryError == false &&
                                walletError == false &&
                                amountError == false) {
                              _saveTransaction();
                            }
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
