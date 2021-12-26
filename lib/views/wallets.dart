import 'package:flutter/material.dart';
import './create_wallet.dart' as CreateWallet;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Wallets extends StatefulWidget {
  @override
  _WalletsState createState() => _WalletsState();
}

class _WalletsState extends State<Wallets> {
  List cash_wallets = [];
  List debit_cards_wallets = [];
  List bank_wallets = [];
  List credit_cards_wallets = [];
  List loan_wallets = [];

  @override
  void initState() {
    super.initState();
    print('333 I AM STARTING');
    _loadWallets();
  }

  _loadWallets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var wallets = jsonDecode(prefs.getString('wallets'));
    List cash_wallets_local = [];
    List debit_cards_wallets_local = [];
    List bank_wallets_local = [];
    List credit_cards_wallets_local = [];
    List loan_wallets_local = [];

    for (int i = 0; i < wallets?.length ?? 0; i++) {
      switch (wallets[i]['type']) {
        case 'Cash':
          cash_wallets_local.add((wallets[i]));
          break;
        case 'Debit Card':
          debit_cards_wallets_local.add((wallets[i]));
          break;
        case 'Bank Account':
          bank_wallets_local.add((wallets[i]));
          break;
        case 'Credit Card':
          credit_cards_wallets_local.add((wallets[i]));
          break;
        case 'Loan Account':
          loan_wallets_local.add((wallets[i]));
          break;
      }
    }

    setState(() {
      cash_wallets = cash_wallets_local;
      debit_cards_wallets = debit_cards_wallets_local;
      bank_wallets = bank_wallets_local;
      credit_cards_wallets = credit_cards_wallets_local;
      loan_wallets = loan_wallets_local;
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
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Wallets'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: addIconColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateWallet.Wallet()),
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
              if (cash_wallets.length == 0 &&
                  debit_cards_wallets.length == 0 &&
                  bank_wallets.length == 0 &&
                  credit_cards_wallets.length == 0 &&
                  loan_wallets.length == 0)
                Container(
                  height: 168,
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  width: 184,
                ),
              if (cash_wallets.length > 0 ||
                  debit_cards_wallets.length > 0 ||
                  bank_wallets.length > 0 ||
                  credit_cards_wallets.length > 0 ||
                  loan_wallets.length > 0)
                Column(children: [
                  if (cash_wallets.length > 0)
                    Column(children: [
                      Container(
                        height: 32,
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
                          'Cash',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: hintTextColor,
                          ),
                        ),
                      ),
                      for (var i in cash_wallets)
                        Container(
                          height: 48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1.0,
                                color: borderColor,
                              ),
                            ),
                          ),
                          child: Text(
                            i['name'].toString(),
                            style: TextStyle(
                              height:
                                  2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                    ]),
                  if (debit_cards_wallets.length > 0)
                    Column(children: [
                      Container(
                        height: 32,
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
                          'Debit Card',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: hintTextColor,
                          ),
                        ),
                      ),
                      for (var i in debit_cards_wallets)
                        Container(
                          height: 48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1.0,
                                color: borderColor,
                              ),
                            ),
                          ),
                          child: Text(
                            i['name'].toString(),
                            style: TextStyle(
                              height:
                                  2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                    ]),
                  if (bank_wallets.length > 0)
                    Column(children: [
                      Container(
                        height: 32,
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
                          'Bank Account',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: hintTextColor,
                          ),
                        ),
                      ),
                      for (var i in bank_wallets)
                        Container(
                          height: 48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1.0,
                                color: borderColor,
                              ),
                            ),
                          ),
                          child: Text(
                            i['name'].toString(),
                            style: TextStyle(
                              height:
                                  2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                    ]),
                  if (credit_cards_wallets.length > 0)
                    Column(children: [
                      Container(
                        height: 32,
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
                          'Credit Card',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: hintTextColor,
                          ),
                        ),
                      ),
                      for (var i in credit_cards_wallets)
                        Container(
                          height: 48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1.0,
                                color: borderColor,
                              ),
                            ),
                          ),
                          child: Text(
                            i['name'].toString(),
                            style: TextStyle(
                              height:
                                  2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                    ]),
                  if (loan_wallets.length > 0)
                    Column(children: [
                      Container(
                        height: 32,
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
                          'Loan Account',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: hintTextColor,
                          ),
                        ),
                      ),
                      for (var i in loan_wallets)
                        Container(
                          height: 48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1.0,
                                color: borderColor,
                              ),
                            ),
                          ),
                          child: Text(
                            i['name'].toString(),
                            style: TextStyle(
                              height:
                                  2.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                    ]),
                ]),
            ]),
          ),
        ),
      ),
    );
  }
}
