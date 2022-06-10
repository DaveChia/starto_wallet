import 'package:flutter/material.dart';
import './create_transaction.dart' as CreateTransaction;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Transactions extends StatefulWidget {
  @override
  _WalletsState createState() => _WalletsState();
}

class _WalletsState extends State<Transactions> {
  List cash_wallets = [];
  List bank_wallets = [];
  List credit_cards_wallets = [];
  List loan_wallets = [];
  List insurance_wallets = [];
  List investment_wallets = [];

  Color activeTransactionColor = Color(0xFF3A475C);
  Color inActiveTransactionColor = Color(0xFFEBEDEF);
  Color transactionBackgroundColor = Color(0xFFF4F5F6);

  String selected_transaction = 'daily';

  bool isEditMode = false;

  Color deleteButtonColor = Color(0xFFE36565);
  Color whenButtonInactiveColor = Color(0xFFC4C8CE);
  Color whenButtonInactiveTextColor = Color(0xFF9CA3AD);
  Color whenButtonActiveColor = Color(0xFF24324A);
  Color whenButtonActiveTextColor = Color(0xFF24324A);
  Color incomeTextColor = Color(0xFF7CAC5F);
  Color expenseTextColor = Color(0xFFDA5358);
  Color transferTextColor = Color(0xFFC4C8CE);

  @override
  void initState() {
    super.initState();
    _loadWallets();
  }

  _loadWallets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List bank_wallets_local = [];
    List cash_wallets_local = [];
    List credit_cards_wallets_local = [];
    List loan_wallets_local = [];
    List insurance_wallets_local = [];
    List investment_wallets_local = [];

    if (prefs.getString('bank_account_wallets') != null) {
      bank_wallets_local = jsonDecode(prefs.getString('bank_account_wallets'));
    }

    if (prefs.getString('cash_wallets') != null) {
      cash_wallets_local = jsonDecode(prefs.getString('cash_wallets'));
    }

    if (prefs.getString('credit_card_wallets') != null) {
      credit_cards_wallets_local =
          jsonDecode(prefs.getString('credit_card_wallets'));
    }

    if (prefs.getString('loan_wallets') != null) {
      loan_wallets_local = jsonDecode(prefs.getString('loan_wallets'));
    }

    if (prefs.getString('insurance_wallets') != null) {
      insurance_wallets_local =
          jsonDecode(prefs.getString('insurance_wallets'));
    }

    if (prefs.getString('investment_wallets') != null) {
      investment_wallets_local =
          jsonDecode(prefs.getString('investment_wallets'));
    }

    setState(() {
      cash_wallets = cash_wallets_local;
      bank_wallets = bank_wallets_local;
      credit_cards_wallets = credit_cards_wallets_local;
      loan_wallets = loan_wallets_local;
      insurance_wallets = insurance_wallets_local;
      investment_wallets = investment_wallets_local;
    });
  }

  static const IconData warning = IconData(0xe6cb, fontFamily: 'MaterialIcons');

  Color borderColor = Color(0xFFEBEDEF);
  Color backgroundColor = Color(0xFFFFFFFF);
  Color addButtonColor = Color(0xFF24324A);
  Color hintTextColor = Color(0xFF9CA3AD);
  Color addIconColor = Color(0xFF616C7D);

  String walletName = '';
  @override
  Widget build(BuildContext context) {
    double scrollHeight = MediaQuery.of(context).size.height -
        50 -
        MediaQuery.of(context).viewPadding.top - // height of status bar
        AppBar().preferredSize.height; //  height of AppBar
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Transactions'),
        elevation: 0,
        automaticallyImplyLeading: false,
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
                    builder: (context) =>
                        CreateTransaction.CreateTransaction()),
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
                        selected_transaction = 'daily';
                        // active_categories = expense_categories;
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: selected_transaction == 'daily' ? 2 : 0.5,
                            color: selected_transaction == 'daily'
                                ? activeTransactionColor
                                : inActiveTransactionColor,
                          ),
                        ),
                      ),
                      child: Text(
                        'Daily',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selected_transaction == 'daily'
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
                        selected_transaction = 'weekly';
                        // active_categories = income_categories;
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: selected_transaction == 'weekly' ? 2 : 0.5,
                            color: selected_transaction == 'weekly'
                                ? activeTransactionColor
                                : inActiveTransactionColor,
                          ),
                        ),
                      ),
                      child: Text(
                        'Weekly',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selected_transaction == 'weekly'
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
                        selected_transaction = 'monthly';
                        // active_categories = transfer_categories;
                      });
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: selected_transaction == 'monthly' ? 2 : 0.5,
                            color: selected_transaction == 'monthly'
                                ? activeTransactionColor
                                : inActiveTransactionColor,
                          ),
                        ),
                      ),
                      child: Text(
                        'Monthly',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: selected_transaction == 'monthly'
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
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            for (var i = 0; i < 6; i++)
                              Container(
                                margin: EdgeInsets.only(
                                    top: 16, bottom: (i == 5) ? 16 : 0),
                                width: double.infinity,
                                color: transactionBackgroundColor,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 12, bottom: 12),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 24,
                                        width: double.infinity,
                                        child: Text(
                                          'Today | 4 Jan, Tue',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: whenButtonActiveColor,
                                            fontWeight: FontWeight.bold,
                                            height:
                                                1.35, //HACK, need to find better way to align vertical center and horizontal center at the same time
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.arrow_downward,
                                                  color: incomeTextColor,
                                                  size: 12,
                                                ),
                                                Text(
                                                  '3,200.00',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: incomeTextColor,
                                                    height:
                                                        1.35, //HACK, need to find better way to align vertical center and horizontal center at the same time
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.arrow_upward,
                                                  color: expenseTextColor,
                                                  size: 12,
                                                ),
                                                Text(
                                                  '3,200.00',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: expenseTextColor,
                                                    height:
                                                        1.35, //HACK, need to find better way to align vertical center and horizontal center at the same time
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.arrow_forward,
                                                  color: transferTextColor,
                                                  size: 12,
                                                ),
                                                Text(
                                                  '3,200.00',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: transferTextColor,
                                                    height:
                                                        1.35, //HACK, need to find better way to align vertical center and horizontal center at the same time
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              width: 1,
                                              color: inActiveTransactionColor,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    height: 24,
                                                    child: Text(
                                                      'Foodpanda Subscription',
                                                      style: TextStyle(
                                                        height:
                                                            1.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                                                        fontSize: 14.0,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    height: 24,
                                                    child: Text(
                                                      'HSBC',
                                                      style: TextStyle(
                                                        color:
                                                            whenButtonInactiveTextColor,
                                                        height:
                                                            1.75, //HACK, need to find better way to align vertical center and horizontal center at the same time
                                                        fontSize: 12.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 100,
                                              child: Text(
                                                '8.00',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: expenseTextColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                              width: 1,
                                              color: inActiveTransactionColor,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    height: 24,
                                                    child: Text(
                                                      'Foodpanda Subscription',
                                                      style: TextStyle(
                                                        height:
                                                            1.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                                                        fontSize: 14.0,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    height: 24,
                                                    child: Text(
                                                      'HSBC',
                                                      style: TextStyle(
                                                        color:
                                                            whenButtonInactiveTextColor,
                                                        height:
                                                            1.75, //HACK, need to find better way to align vertical center and horizontal center at the same time
                                                        fontSize: 12.0,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 100,
                                              child: Text(
                                                '8.00',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: expenseTextColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  showAlertDialog(
      BuildContext context, wallet_index, wallet_name, wallet_type) {
    // set up the buttons
    Widget deleteButton = TextButton(
      child: Text("Delete now"),
      onPressed: () {
        _deleteWallet(wallet_index, wallet_type);
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
        "Delete Wallet",
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
            new TextSpan(text: 'Are you sure you want to delete the wallet '),
            new TextSpan(
              text:
                  "${wallet_name[0].toUpperCase()}${wallet_name.substring(1)}",
              style: new TextStyle(fontWeight: FontWeight.bold),
            ),
            new TextSpan(text: ' ?'),
          ],
        ),
      ),
      // content: Text('Are you sure you want to delete the category ' +
      //     "${category_name[0].toUpperCase()}${category_name.substring(1)}" +
      //     ' ?'),

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

  _deleteWallet(wallet_index, wallet_type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String stringList = '';

    switch (wallet_type) {
      case 'cash':
        cash_wallets.removeAt(wallet_index);
        stringList = jsonEncode(cash_wallets);

        break;
      case 'bank_account':
        bank_wallets.removeAt(wallet_index);
        stringList = jsonEncode(bank_wallets);
        break;
      case 'credit_card':
        credit_cards_wallets.removeAt(wallet_index);
        stringList = jsonEncode(credit_cards_wallets);
        break;
      case 'loan':
        loan_wallets.removeAt(wallet_index);
        stringList = jsonEncode(loan_wallets);
        break;
      case 'investment':
        investment_wallets.removeAt(wallet_index);
        stringList = jsonEncode(investment_wallets);
        break;
      case 'insurance':
        insurance_wallets.removeAt(wallet_index);
        stringList = jsonEncode(insurance_wallets);
        break;
    }

    prefs.setString(wallet_type + '_wallets', stringList);

    setState(() {});
  }
}
