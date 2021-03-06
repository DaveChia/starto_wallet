import 'package:flutter/material.dart';
import './transaction_added_success.dart' as QuickAddTransactionSuccess;
import './quick_add_transaction_key.dart' as QuickAddTransactionKey;
// import './quick_add_transaction_key.dart' as QuickAddTransactionKey;
import './create_category.dart' as CreateCategory;
import '../main.dart' as Main;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class QuickAddTransaction extends StatefulWidget {
  QuickAddTransaction();
  @override
  _QuickAddTransactionState createState() => _QuickAddTransactionState();
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

class _QuickAddTransactionState extends State<QuickAddTransaction> {
  static const IconData warning = IconData(0xe6cb, fontFamily: 'MaterialIcons');

  Color borderColor = Color(0xFFEBEDEF);
  Color backgroundColor = Color(0xFFFFFFFF);
  Color addButtonColor = Color(0xFF24324A);
  Color hintTextColor = Color(0xFF9CA3AD);
  Color whenButtonInactiveColor = Color(0xFFC4C8CE);
  Color transfer_color = Color(0xFFC4C8CE);
  Color unselected_nav_color = Color(0xFF616C7D);
  Color dragHintCOlor = Color(0xFFC4C8CE);
  Color aletDialogTextColor = Color(0xFF24324A);
  Color categoryAddIconBackgroundColor = Color(0xFFC4C4C4);

  String selected_transaction_sub_type = 'expense';

  List expense_transactions = [];
  List income_transactions = [];
  List active_transactions = [];

  List expense_categories = [];
  List income_categories = [];
  List active_categories = [];

  @override
  void initState() {
    super.initState();
    _loadSuggestedTransactionsAndCategories();
  }

  _saveTransaction(data) async {
    //  Save transaction here
    DateTime selected_date = DateTime.now();

    var transaction_data = active_transactions[int.parse(data)];

    Category transaction_data_category = Category(
        name: transaction_data['category']['name'],
        type: transaction_data['category']['type']);

    final new_transaction = Transaction(
        amount: transaction_data['price'],
        category: transaction_data_category,
        description: transaction_data['note'],
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

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              QuickAddTransactionSuccess.TransactionAddedSuccess()),
    );
  }

  _loadSuggestedTransactionsAndCategories() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Object> expense_transactions_local = [];
    List<Object> income_transactions_local = [];

    final String existing_suggested_transactions =
        await prefs.getString('saved_suggested_transactions');

    var decodedData = jsonDecode(existing_suggested_transactions);

    decodedData.forEach((transaction) {
      if (transaction['category']['type'] == 'expense') {
        expense_transactions_local.add(transaction);
      } else {
        income_transactions_local.add(transaction);
      }
    });

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
      expense_transactions = expense_transactions_local;
      income_transactions = income_transactions_local;

      expense_categories = expense_categories_local2;
      income_categories = income_categories_local2;

      active_transactions = expense_transactions;
      active_categories = expense_categories_local2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
          title: Text('Add Transaction'),
          centerTitle: true,
          elevation: 0,
          leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Main.MyApp()),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: Container(
                  child: Text(
                    'Cancel',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: hintTextColor,
                      height:
                          2.65, //HACK, need to find better way to align vertical center and horizontal center at the same time
                    ),
                  ),
                ),
              ))
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => Main.MyApp()),
          //     );
          //   },
          //   icon: Icon(Icons.cancel_outlined),
          // ),
          ),
      body: Center(
        child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border(
                            bottom: BorderSide(
                              width: 1.0,
                              color: transfer_color,
                            ),
                            top: BorderSide(
                              width: 1.0,
                              color: transfer_color,
                            ),
                            left: BorderSide(
                              width: 1.0,
                              color: transfer_color,
                            ),
                            right: BorderSide(
                              width: 1.0,
                              color: transfer_color,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected_transaction_sub_type = 'expense';
                                    active_transactions = expense_transactions;
                                    active_categories = expense_categories;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: selected_transaction_sub_type ==
                                            'expense'
                                        ? Colors.transparent
                                        : borderColor,
                                  ),
                                  child: Text(
                                    'Expense',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: selected_transaction_sub_type ==
                                                'expense'
                                            ? addButtonColor
                                            : hintTextColor,
                                        height:
                                            2.3 //HACK, need to find better way to align vertical center and horizontal center at the same time
                                        ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected_transaction_sub_type = 'income';
                                    active_transactions = income_transactions;
                                    active_categories = income_categories;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: selected_transaction_sub_type ==
                                            'income'
                                        ? Colors.transparent
                                        : borderColor,
                                  ),
                                  child: Text(
                                    'Income',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                        color: selected_transaction_sub_type ==
                                                'income'
                                            ? addButtonColor
                                            : hintTextColor,
                                        height:
                                            2.3 //HACK, need to find better way to align vertical center and horizontal center at the same time
                                        ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 30),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              for (var i = 0;
                                  i < active_transactions.length;
                                  i++)
                                Draggable(
                                  // Data is the value this Draggable stores.
                                  data: i.toString(),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10, right: 10),
                                    height: 36,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 10, right: 10, top: 8),
                                      child: Text(
                                        '${active_transactions[i]['note'].toString()[0].toUpperCase()}${active_transactions[i]['note'].toString().substring(1)} \$${active_transactions[i]['price'].toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: unselected_nav_color),
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
                                  feedback: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    height: 36,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 10, right: 10, top: 8),
                                      child: Text(
                                        '${active_transactions[i]['note'].toString()[0].toUpperCase()}${active_transactions[i]['note'].toString().substring(1)} \$${active_transactions[i]['price'].toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: unselected_nav_color),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: backgroundColor,
                                      border: Border.all(
                                        width: 1.0,
                                        color: transfer_color,
                                      ),
                                    ),
                                  ),
                                ),
                              Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 20),
                                  width: double.infinity,
                                  child: Text(
                                    'Drag an expense to the wallet to do a quick add',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontStyle: FontStyle.italic, // italic
                                      color: dragHintCOlor,
                                    ),
                                  )),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        child: DragTarget(
                          builder: (context, List<String> candidateData,
                              rejectedData) {
                            return Center(
                              child: Image.asset(
                                  'assets/images/quick_add_transaction_drag_drop.png'),
                            );
                          },
                          onWillAccept: (data) {
                            return true;
                          },
                          onAccept: (data) {
                            _saveTransaction(data);
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 50, bottom: 10),
                        width: double.infinity,
                        child: Text(
                          'Or select a category add a transaction',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontStyle: FontStyle.italic, // italic
                            color: dragHintCOlor,
                          ),
                        ),
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          for (var i = 0; i < active_categories.length; i++)
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          QuickAddTransactionKey
                                              .QuickAddTransactionKey(
                                            transaction_type:
                                                selected_transaction_sub_type,
                                            category_type:
                                                active_categories[i].type,
                                            category_name:
                                                active_categories[i].name,
                                          )),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10, top: 10),
                                height: 36,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 20, top: 5),
                                    child: Wrap(
                                      children: [
                                        Icon(
                                          Icons.arrow_right_sharp,
                                        ),
                                        Text(
                                          '${active_categories[i].name.toString()[0].toUpperCase()}${active_categories[i].name.toString().substring(1)} ',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: unselected_nav_color,
                                              height: 1.45),
                                        ),
                                      ],
                                    )),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(
                                    width: 1.0,
                                    color: transfer_color,
                                  ),
                                ),
                              ),
                            ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CreateCategory.Category(
                                          type: 'create',
                                          category_type:
                                              selected_transaction_sub_type,
                                        )),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  width: 1.0,
                                  color: transfer_color,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 10),
                                child: Container(
                                  height: 16,
                                  width: 16,
                                  decoration: BoxDecoration(
                                    color: categoryAddIconBackgroundColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '+',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      height: 0.95,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 30,
                      )
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
