import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './create_transaction.dart' as CreateTransaction;

class RepeatedTransactions extends StatefulWidget {
  @override
  _RepeatedTransactionsState createState() => _RepeatedTransactionsState();
}

class _RepeatedTransactionsState extends State<RepeatedTransactions> {
  List transactions_income = [];
  List transactions_expense = [];

  @override
  void initState() {
    super.initState();
    print('333 I AM STARTING');
    _loadTransactions();
  }

  _loadTransactions() async {
    List transactions_income_local = [
      {
        'type': 'income',
        'category': 'household',
        'date': '30/11',
        'date_type': 'monthly',
        'name': 'Nov Salary',
        'wallet_name': 'DBS Multiplier',
        'amount': 3200,
      },
      {
        'type': 'income',
        'category': 'household',
        'date': '31/11',
        'date_type': 'monthly',
        'name': 'Nov Salary2',
        'wallet_name': 'DBS Multiplier2',
        'amount': 3201.23,
      },
    ];

    List transactions_expense_local = [
      {
        'type': 'expense',
        'category': 'household',
        'date': '07/11',
        'date_type': 'monthly',
        'name': 'Spotify',
        'wallet_name': 'UOB PPV',
        'amount': 17.15,
      },
      {
        'type': 'expense',
        'category': 'household',
        'date': '18/11',
        'date_type': 'monthly',
        'name': 'Netflix',
        'wallet_name': 'UOB PPV',
        'amount': 21.98,
      },
      {
        'type': 'expense',
        'category': 'household / Repairs',
        'date': '30/11',
        'date_type': 'monthly',
        'name': 'Rental',
        'wallet_name': 'UOB PRVI',
        'amount': 1000,
      },
    ];

    setState(() {
      transactions_income = transactions_income_local;
      transactions_expense = transactions_expense_local;
    });

    print(transactions_income[0]);
  }

  @override
  Widget build(BuildContext context) {
    Color borderColor = Color(0xFFEBEDEF);
    Color hintTextColor = Color(0xFF9CA3AD);
    Color backgroundColor = Color(0xFFFFFFFF);
    Color addIconColor = Color(0xFF616C7D);

    var formatter = NumberFormat('#,##,###.00#');

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Repeated Transactions'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
              color: addIconColor,
            ),
            onPressed: () {
              print('delete transactions');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.add,
              color: addIconColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CreateTransaction.CreateTransaction()),
              );
            },
          )
        ],
      ),
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
                    'Income',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: hintTextColor,
                    ),
                  ),
                ),
                for (var transaction in transactions_income)
                  GestureDetector(
                    onTap: () {
                      print("repeated transactions was tapped");
                    },
                    child: Container(
                      height: 56,
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
                          Container(
                            width: 40,
                            height: 28,
                            child: Column(children: [
                              Container(
                                width: double.infinity,
                                height: 16,
                                child: Text(
                                  transaction['date'].toString(),
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: hintTextColor,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 12,
                                child: Text(
                                  "${transaction['date_type'].toString()[0].toUpperCase()}${transaction['date_type'].toString().substring(1)}",
                                  style: TextStyle(
                                    fontSize: 8.0,
                                    color: hintTextColor,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(children: [
                              Container(
                                width: double.infinity,
                                height: 8,
                              ),
                              Container(
                                width: double.infinity,
                                height: 23,
                                child: Text(
                                  transaction['name'].toString(),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 16,
                                child: Text(
                                  transaction['wallet_name'].toString() +
                                      ' ' +
                                      "${transaction['category'].toString()[0].toUpperCase()}${transaction['category'].toString().substring(1)}",
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    height: 1.5,
                                    color: hintTextColor,
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 8,
                              ),
                            ]),
                          ),
                          Container(
                            width: 8,
                          ),
                          Container(
                            width: 84,
                            child: Text(
                              '\$' + formatter.format(transaction['amount']),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Container(
                  height: 16,
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
                    'Expenses',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: hintTextColor,
                    ),
                  ),
                ),
                for (var transaction in transactions_expense)
                  GestureDetector(
                    onTap: () {
                      print("repeated transactions was tapped");
                    },
                    child: Container(
                      height: 56,
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
                          Container(
                            width: 40,
                            height: 28,
                            child: Column(children: [
                              Container(
                                width: double.infinity,
                                height: 16,
                                child: Text(
                                  transaction['date'].toString(),
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: hintTextColor,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 12,
                                child: Text(
                                  "${transaction['date_type'].toString()[0].toUpperCase()}${transaction['date_type'].toString().substring(1)}",
                                  style: TextStyle(
                                    fontSize: 8.0,
                                    color: hintTextColor,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            width: 8,
                          ),
                          Expanded(
                            child: Column(children: [
                              Container(
                                width: double.infinity,
                                height: 8,
                              ),
                              Container(
                                width: double.infinity,
                                height: 23,
                                child: Text(
                                  transaction['name'].toString(),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 16,
                                child: Text(
                                  transaction['wallet_name'].toString() +
                                      ' ' +
                                      "${transaction['category'].toString()[0].toUpperCase()}${transaction['category'].toString().substring(1)}",
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    height: 1.5,
                                    color: hintTextColor,
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 8,
                              ),
                            ]),
                          ),
                          Container(
                            width: 8,
                          ),
                          Container(
                            width: 84,
                            child: Text(
                              '\$' + formatter.format(transaction['amount']),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Container(
                  height: 16,
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
                    'Transfer',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: hintTextColor,
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
