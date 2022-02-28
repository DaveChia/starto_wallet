import 'package:flutter/material.dart';
import './create_wallet_landing.dart' as CreateWalletLand;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import './settings.dart' as Setting;
import 'package:starto_wallet/main.dart' as Main;
import 'edit_wallet.dart' as EditWallet;
import 'settings.dart' as Settings;

class Wallets extends StatefulWidget {
  @override
  _WalletsState createState() => _WalletsState();
}

class _WalletsState extends State<Wallets> {
  List cash_wallets = [];
  List bank_wallets = [];
  List credit_cards_wallets = [];
  List loan_wallets = [];
  List insurance_wallets = [];
  List investment_wallets = [];

  bool isEditMode = false;

  Color deleteButtonColor = Color(0xFFE36565);
  Color whenButtonActiveColor = Color(0xFF24324A);

  @override
  void initState() {
    super.initState();
    print('333 I AM STARTING');
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

  Color nav_border_color = Color(0xFF24324A1A);
  Color selected_nav_color = Color(0xFF0472FF);
  Color unselected_nav_color = Color(0xFF616C7D);

  String selected_page = 'wallet';

  String walletName = '';

  @override
  Widget build(BuildContext context) {
    double scrollHeight = MediaQuery.of(context).size.height -
        72 -
        MediaQuery.of(context).viewPadding.top - // height of status bar
        AppBar().preferredSize.height; //  height of AppBar

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Wallets'),
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
          if (isEditMode == true)
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
                          CreateWalletLand.CreateWalletLand()),
                );
              },
            ),
          if (isEditMode == false)
            IconButton(
              icon: Icon(
                Icons.edit,
                color: addIconColor,
              ),
              onPressed: () {
                setState(() {
                  isEditMode = !isEditMode;
                });
              },
            ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Container(
                height: scrollHeight,
                child: SingleChildScrollView(
                  child: Stack(children: [
                    if (cash_wallets.length == 0 &&
                        insurance_wallets.length == 0 &&
                        investment_wallets.length == 0 &&
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
                        insurance_wallets.length > 0 ||
                        investment_wallets.length > 0 ||
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
                            for (var i = 0; i < cash_wallets.length; i++)
                              GestureDetector(
                                onTap: () {
                                  print(i);
                                },
                                child: Container(
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
                                  child: Row(
                                    children: [
                                      if (isEditMode == true)
                                        Container(
                                          width: 17,
                                          height: double.infinity,
                                          child: IconButton(
                                            onPressed: () {
                                              showAlertDialog(
                                                  context,
                                                  i,
                                                  cash_wallets[i]['name'],
                                                  cash_wallets[i]['type']);
                                            },
                                            padding: new EdgeInsets.all(0.0),
                                            icon: Icon(
                                              Icons.remove_circle_outlined,
                                              color: deleteButtonColor,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      if (isEditMode == true)
                                        Container(
                                          width: 18,
                                        ),
                                      Expanded(
                                        child: Text(
                                          "${cash_wallets[i]['name'][0].toUpperCase()}${cash_wallets[i]['name'].substring(1)}",
                                          style: TextStyle(
                                            height:
                                                1.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                      if (isEditMode == true)
                                        Container(
                                          width: 17,
                                          height: double.infinity,
                                          child: IconButton(
                                            padding: new EdgeInsets.all(0.0),
                                            icon: Icon(
                                              Icons.edit_outlined,
                                              color: hintTextColor,
                                              size: 18,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditWallet.Wallet(
                                                          type: 'cash',
                                                          editWallet:
                                                              insurance_wallets[
                                                                  i],
                                                          walletIndex: i,
                                                        )),
                                              );
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              )
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
                            for (var i = 0; i < bank_wallets.length; i++)
                              GestureDetector(
                                onTap: () {
                                  print(i);
                                },
                                child: Container(
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
                                  child: Row(
                                    children: [
                                      if (isEditMode == true)
                                        Container(
                                          width: 17,
                                          height: double.infinity,
                                          child: IconButton(
                                            onPressed: () {
                                              showAlertDialog(
                                                  context,
                                                  i,
                                                  bank_wallets[i]['name'],
                                                  bank_wallets[i]['type']);
                                            },
                                            padding: new EdgeInsets.all(0.0),
                                            icon: Icon(
                                              Icons.remove_circle_outlined,
                                              color: deleteButtonColor,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      if (isEditMode == true)
                                        Container(
                                          width: 18,
                                        ),
                                      Expanded(
                                        child: Text(
                                          "${bank_wallets[i]['name'][0].toUpperCase()}${bank_wallets[i]['name'].substring(1)}",
                                          style: TextStyle(
                                            height:
                                                1.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                      if (isEditMode == true)
                                        Container(
                                          width: 17,
                                          height: double.infinity,
                                          child: IconButton(
                                            padding: new EdgeInsets.all(0.0),
                                            icon: Icon(
                                              Icons.edit_outlined,
                                              color: hintTextColor,
                                              size: 18,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditWallet.Wallet(
                                                          type: 'bank_account',
                                                          editWallet:
                                                              bank_wallets[i],
                                                          walletIndex: i,
                                                        )),
                                              );
                                            },
                                          ),
                                        ),
                                    ],
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
                            for (var i = 0;
                                i < credit_cards_wallets.length;
                                i++)
                              GestureDetector(
                                onTap: () {
                                  print(i);
                                },
                                child: Container(
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
                                  child: Row(
                                    children: [
                                      if (isEditMode == true)
                                        Container(
                                          width: 17,
                                          height: double.infinity,
                                          child: IconButton(
                                            onPressed: () {
                                              showAlertDialog(
                                                  context,
                                                  i,
                                                  credit_cards_wallets[i]
                                                      ['name'],
                                                  credit_cards_wallets[i]
                                                      ['type']);
                                            },
                                            padding: new EdgeInsets.all(0.0),
                                            icon: Icon(
                                              Icons.remove_circle_outlined,
                                              color: deleteButtonColor,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      if (isEditMode == true)
                                        Container(
                                          width: 18,
                                        ),
                                      Expanded(
                                        child: Text(
                                          "${credit_cards_wallets[i]['name'][0].toUpperCase()}${credit_cards_wallets[i]['name'].substring(1)}",
                                          style: TextStyle(
                                            height:
                                                1.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                                            fontSize: 14.0,
                                          ),
                                        ),
                                      ),
                                      if (isEditMode == true)
                                        Container(
                                          width: 17,
                                          height: double.infinity,
                                          child: IconButton(
                                            padding: new EdgeInsets.all(0.0),
                                            icon: Icon(
                                              Icons.edit_outlined,
                                              color: hintTextColor,
                                              size: 18,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditWallet.Wallet(
                                                          type: 'credit_card',
                                                          editWallet:
                                                              credit_cards_wallets[
                                                                  i],
                                                          walletIndex: i,
                                                        )),
                                              );
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              )
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
                            for (var i = 0; i < loan_wallets.length; i++)
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
                                child: Row(
                                  children: [
                                    if (isEditMode == true)
                                      Container(
                                        width: 17,
                                        height: double.infinity,
                                        child: IconButton(
                                          onPressed: () {
                                            showAlertDialog(
                                                context,
                                                i,
                                                loan_wallets[i]['name'],
                                                loan_wallets[i]['type']);
                                          },
                                          padding: new EdgeInsets.all(0.0),
                                          icon: Icon(
                                            Icons.remove_circle_outlined,
                                            color: deleteButtonColor,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    if (isEditMode == true)
                                      Container(
                                        width: 18,
                                      ),
                                    Expanded(
                                      child: Text(
                                        "${loan_wallets[i]['name'][0].toUpperCase()}${loan_wallets[i]['name'].substring(1)}",
                                        style: TextStyle(
                                          height:
                                              1.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                    if (isEditMode == true)
                                      Container(
                                        width: 17,
                                        height: double.infinity,
                                        child: IconButton(
                                          padding: new EdgeInsets.all(0.0),
                                          icon: Icon(
                                            Icons.edit_outlined,
                                            color: hintTextColor,
                                            size: 18,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditWallet.Wallet(
                                                        type: 'loan',
                                                        editWallet:
                                                            loan_wallets[i],
                                                        walletIndex: i,
                                                      )),
                                            );
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                          ]),
                        if (investment_wallets.length > 0)
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
                                'Investment Account',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: hintTextColor,
                                ),
                              ),
                            ),
                            for (var i = 0; i < investment_wallets.length; i++)
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
                                child: Row(
                                  children: [
                                    if (isEditMode == true)
                                      Container(
                                        width: 17,
                                        height: double.infinity,
                                        child: IconButton(
                                          onPressed: () {
                                            showAlertDialog(
                                                context,
                                                i,
                                                investment_wallets[i]['name'],
                                                investment_wallets[i]['type']);
                                          },
                                          padding: new EdgeInsets.all(0.0),
                                          icon: Icon(
                                            Icons.remove_circle_outlined,
                                            color: deleteButtonColor,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    if (isEditMode == true)
                                      Container(
                                        width: 18,
                                      ),
                                    Expanded(
                                      child: Text(
                                        "${investment_wallets[i]['name'][0].toUpperCase()}${investment_wallets[i]['name'].substring(1)}",
                                        style: TextStyle(
                                          height:
                                              1.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                    if (isEditMode == true)
                                      Container(
                                        width: 17,
                                        height: double.infinity,
                                        child: IconButton(
                                          padding: new EdgeInsets.all(0.0),
                                          icon: Icon(
                                            Icons.edit_outlined,
                                            color: hintTextColor,
                                            size: 18,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditWallet.Wallet(
                                                        type: 'investment',
                                                        editWallet:
                                                            investment_wallets[
                                                                i],
                                                        walletIndex: i,
                                                      )),
                                            );
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                          ]),
                        if (insurance_wallets.length > 0)
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
                                'Insurance Account',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: hintTextColor,
                                ),
                              ),
                            ),
                            for (var i = 0; i < insurance_wallets.length; i++)
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
                                child: Row(
                                  children: [
                                    if (isEditMode == true)
                                      Container(
                                        width: 17,
                                        height: double.infinity,
                                        child: IconButton(
                                          onPressed: () {
                                            showAlertDialog(
                                                context,
                                                i,
                                                insurance_wallets[i]['name'],
                                                insurance_wallets[i]['type']);
                                          },
                                          padding: new EdgeInsets.all(0.0),
                                          icon: Icon(
                                            Icons.remove_circle_outlined,
                                            color: deleteButtonColor,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    if (isEditMode == true)
                                      Container(
                                        width: 18,
                                      ),
                                    Expanded(
                                      child: Text(
                                        "${insurance_wallets[i]['name'][0].toUpperCase()}${insurance_wallets[i]['name'].substring(1)}",
                                        style: TextStyle(
                                          height:
                                              1.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ),
                                    if (isEditMode == true)
                                      Container(
                                        width: 17,
                                        height: double.infinity,
                                        child: IconButton(
                                          padding: new EdgeInsets.all(0.0),
                                          icon: Icon(
                                            Icons.edit_outlined,
                                            color: hintTextColor,
                                            size: 18,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditWallet.Wallet(
                                                        type: 'insurance',
                                                        editWallet:
                                                            insurance_wallets[
                                                                i],
                                                        walletIndex: i,
                                                      )),
                                            );
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                          ]),
                      ]),
                  ]),
                ),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      width: 1.0,
                      color: nav_border_color,
                    ),
                  ),
                ),
                height: 72,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            //  MaterialPageRoute(builder: (context) => CreateWallet.Wallet()),
                            // MaterialPageRoute(builder: (context) => Wallets.Wallets()),
                            MaterialPageRoute(
                                builder: (context) => Main.MyApp()),
                            // MaterialPageRoute(builder: (context) => Settings.Settings()),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 16),
                          child: Column(
                            children: [
                              Text(
                                '21 Nov',
                                style: TextStyle(
                                  color: selected_page == 'transaction'
                                      ? selected_nav_color
                                      : unselected_nav_color,
                                  fontSize: 14.0,
                                ),
                              ),
                              Container(
                                height: 4,
                              ),
                              Icon(
                                Icons.circle,
                                size: 8,
                                color: selected_page == 'transaction'
                                    ? selected_nav_color
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Column(
                            children: [
                              Icon(
                                Icons.folder_open_rounded,
                                size: 24,
                                color: selected_page == 'wallet'
                                    ? selected_nav_color
                                    : unselected_nav_color,
                              ),
                              Container(
                                height: 4,
                              ),
                              Icon(
                                Icons.circle,
                                size: 8,
                                color: selected_page == 'wallet'
                                    ? selected_nav_color
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Settings.Settings()),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Column(
                            children: [
                              Icon(
                                Icons.settings,
                                size: 24,
                                color: selected_page == 'setting'
                                    ? selected_nav_color
                                    : unselected_nav_color,
                              ),
                              Container(
                                height: 4,
                              ),
                              Icon(
                                Icons.circle,
                                size: 8,
                                color: selected_page == 'setting'
                                    ? selected_nav_color
                                    : Colors.transparent,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
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
