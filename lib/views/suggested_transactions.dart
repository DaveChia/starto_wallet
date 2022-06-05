import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'create_category.dart' as CreateCategory;
import 'create_suggested_transaction.dart' as CreateSuggestedTransaction;
import 'edit_category.dart' as EditCategory;
import 'settings.dart' as Setting;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SuggestedTransactions extends StatefulWidget {
  @override
  _SuggestedTransactionsState createState() => _SuggestedTransactionsState();
}

class _SuggestedTransactionsState extends State<SuggestedTransactions> {
  List expense_transactions = [];
  List income_transactions = [];
  List active_transactions = [];

  bool isEditMode = false;
  bool isFilterSearchMode = false;
  String filteredSearchString = '';

  String selectedCategory = 'expense';
  Color borderColor = Color(0xFFEBEDEF);
  Color hintTextColor = Color(0xFF9CA3AD);
  Color backgroundColor = Color(0xFFFFFFFF);
  Color addButtonColor = Color(0xFF24324A);
  Color whenButtonInactiveColor = Color(0xFFC4C8CE);
  Color whenButtonInactiveTextColor = Color(0xFF9CA3AD);
  Color whenButtonActiveColor = Color(0xFF24324A);
  Color whenButtonActiveTextColor = Color(0xFF24324A);
  Color addIconColor = Color(0xFF616C7D);
  Color activeCategoryColor = Color(0xFF3A475C);
  Color inActiveCategoryColor = Color(0xFFEBEDEF);
  Color deleteButtonColor = Color(0xFFE36565);
  Color addNewCategoryTextColor = Color(0xFF0472FF);
  var formatter = NumberFormat('#,##,###.00#');

  @override
  void initState() {
    super.initState();
    _loadSuggestedTransactions();
  }

  _loadSuggestedTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<Object> expense_transactions_local = [];
    List<Object> income_transactions_local = [];
    List<Object> transactions_local = [];

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

    setState(() {
      expense_transactions = expense_transactions_local;
      income_transactions = income_transactions_local;

      active_transactions = expense_transactions;
    });
  }

  _deleteCategory(transaction_index) async {
    switch (selectedCategory) {
      case 'expense':
        expense_transactions.removeAt(transaction_index);
        active_transactions = expense_transactions;
        break;
      case 'income':
        income_transactions.removeAt(transaction_index);
        active_transactions = income_transactions;
        break;
    }

    List updated_transactions = expense_transactions + income_transactions;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var stringList = jsonEncode(updated_transactions);
    prefs.setString('saved_suggested_transactions', stringList);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double scrollHeight = MediaQuery.of(context).size.height -
        100 -
        MediaQuery.of(context).viewPadding.top - // height of status bar
        AppBar().preferredSize.height; //  height of AppBar

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Suggested Transactions'),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            if (isEditMode) {
              setState(() {
                isEditMode = false;
              });
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Setting.Settings()),
                (route) => false,
              );
            }
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: addIconColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateSuggestedTransaction
                        .CreateSuggestedTransaction()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 50,
              child: Row(children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'expense';
                        active_transactions = expense_transactions;
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: selectedCategory == 'expense' ? 2 : 0.5,
                            color: selectedCategory == 'expense'
                                ? activeCategoryColor
                                : inActiveCategoryColor,
                          ),
                        ),
                      ),
                      child: Text(
                        'Expense',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedCategory == 'expense'
                              ? whenButtonActiveColor
                              : whenButtonInactiveTextColor,
                          fontSize: 14.0,
                          height:
                              2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = 'income';
                        active_transactions = income_transactions;
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: selectedCategory == 'income' ? 2 : 0.5,
                            color: selectedCategory == 'income'
                                ? activeCategoryColor
                                : inActiveCategoryColor,
                          ),
                        ),
                      ),
                      child: Text(
                        'Income',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selectedCategory == 'income'
                              ? whenButtonActiveColor
                              : whenButtonInactiveTextColor,
                          fontSize: 14.0,
                          height:
                              2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: SizedBox(
                height: scrollHeight,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Stack(children: [
                    Column(children: [
                      for (var i = 0; i < active_transactions.length; i++)
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1.0,
                                color: borderColor,
                              ),
                            ),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            child: Row(
                              children: [
                                Container(
                                  width: 17,
                                  height: double.infinity,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        showAlertDialog(context, i,
                                            active_transactions[i]['note']);
                                      });
                                    },
                                    padding: new EdgeInsets.all(0.0),
                                    icon: Icon(
                                      Icons.remove_circle_outlined,
                                      color: deleteButtonColor,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 18,
                                ),
                                Expanded(
                                  child: Text(
                                    "${active_transactions[i]['note'].toString()[0].toUpperCase()}${active_transactions[i]['note'].toString().substring(1)}",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: hintTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ]),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, suggested_transaction_index,
      suggested_transaction_name) {
    // set up the buttons
    Widget deleteButton = TextButton(
      child: Text("Delete now"),
      onPressed: () {
        _deleteCategory(suggested_transaction_index);
        Navigator.of(context).pop();
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Delete Suggested Transaction",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: whenButtonActiveColor,
          fontSize: 16.0,
        ),
      ),
      content: RichText(
        text: new TextSpan(
          // Note: Styles for TextSpans must be explicitly defined.
          // Child text spans will inherit styles from parent
          style: new TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            new TextSpan(
                text:
                    'Are you sure you want to delete the suggested transaction '),
            new TextSpan(
              text:
                  "${suggested_transaction_name[0].toUpperCase()}${suggested_transaction_name.substring(1)}",
              style: new TextStyle(fontWeight: FontWeight.bold),
            ),
            new TextSpan(text: ' ?'),
          ],
        ),
      ),
      actions: [
        cancelButton,
        deleteButton,
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
