import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import './wallets.dart' as Wallets;
import 'package:intl/intl.dart';

class Wallet extends StatefulWidget {
  String type;

  Wallet({this.type});
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  static const IconData warning = IconData(0xe6cb, fontFamily: 'MaterialIcons');

  Color borderColor = Color(0xFFEBEDEF);
  Color backgroundColor = Color(0xFFFFFFFF);
  Color addButtonColor = Color(0xFF24324A);
  Color hintTextColor = Color(0xFF9CA3AD);
  Color billCycleDateColor = Color(0xFF3A475C);
  Color tooltipIconColor = Color(0xFF616C7D);
  Color tooltipDialogTitleColor = Color(0xFF24324A);

  String walletType = 'Select';
  bool walletNameError = false;
  bool walletTypeError = false;
  String walletTypeName;
  String creditCardPaymentDay = 'Select date';
  String creditCardStatementDay = 'Select date';
  String walletName = '';
  String creditCardUpcomingBillingCycle = '-';
  String creditCardNextBillingCycle = '-';

  String next_mon;
  int current_mon_last_day;
  int next_mon_last_day;

  _calculate_credit_card_statement_date() {
    print(creditCardStatementDay);
    if (creditCardStatementDay == 'Select date') {
      creditCardUpcomingBillingCycle = '-';
      creditCardNextBillingCycle = '-';
      return false;
    }

    String creditCardStatementDayTrim =
        creditCardStatementDay.replaceAll("th", "");
    creditCardStatementDayTrim =
        creditCardStatementDayTrim.replaceAll("st", "");
    creditCardStatementDayTrim =
        creditCardStatementDayTrim.replaceAll("nd", "");
    creditCardStatementDayTrim =
        creditCardStatementDayTrim.replaceAll("rd", "");
    int creditCardStatementDayInt = int.parse(creditCardStatementDayTrim);

    List months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    int currentMonthInt = DateTime.now().month + 12;

    DateTime current_cycle_start_date = DateTime(
        DateTime.now().year, currentMonthInt, creditCardStatementDayInt);

    DateTime current_cycle_end_date = DateTime(DateTime.now().year,
        currentMonthInt + 1, creditCardStatementDayInt - 1);

    if (creditCardStatementDayInt > 28) {
      if (current_cycle_start_date.month > currentMonthInt) {
        current_cycle_start_date =
            DateTime(DateTime.now().year, currentMonthInt + 1, 0);
      }

      if (current_cycle_end_date.month - current_cycle_start_date.month > 1) {
        DateTime lastday =
            DateTime(DateTime.now().year, currentMonthInt + 2, 0);

        current_cycle_end_date =
            DateTime(lastday.year, lastday.month, lastday.day - 1);
      }
    }

    // print(current_cycle_start_date.month);
    // print(current_cycle_end_date.month);
    if (current_cycle_end_date.month - current_cycle_start_date.month > 1) {
      current_cycle_end_date =
          DateTime(DateTime.now().year, currentMonthInt + 2, 0);
    }

    DateTime next_cycle_start_date = DateTime(
        DateTime.now().year, currentMonthInt + 1, creditCardStatementDayInt);

    DateTime next_cycle_end_date = DateTime(DateTime.now().year,
        currentMonthInt + 2, creditCardStatementDayInt - 1);

    if (creditCardStatementDayInt > 28) {
      if (next_cycle_start_date.month > current_cycle_end_date.month) {
        print('I AM HEREE22');
        print(current_cycle_end_date);
        print(next_cycle_start_date);
        next_cycle_start_date = DateTime(
            current_cycle_end_date.year, current_cycle_end_date.month + 1, 0);

        next_cycle_end_date = DateTime(next_cycle_start_date.year,
            next_cycle_start_date.month + 1, creditCardStatementDayInt - 1);
      }
      if (next_cycle_end_date.month - next_cycle_start_date.month > 1) {
        print('I amhere 33');
        next_cycle_end_date = DateTime(
            next_cycle_start_date.year, next_cycle_start_date.month + 2, 0);
      }
    }

    String currentCycleStartDay = current_cycle_start_date.day.toString();
    String currentCycleStartMonth = months[current_cycle_start_date.month - 1];
    String currentCycleEndDay = current_cycle_end_date.day.toString();
    String currentCycleEndMonth = months[current_cycle_end_date.month - 1];

    String nextCycleStartDay = next_cycle_start_date.day.toString();
    String nextCycleStartMonth = months[next_cycle_start_date.month - 1];
    String nextCycleEndDay = next_cycle_end_date.day.toString();
    String nextCycleEndMonth = months[next_cycle_end_date.month - 1];

    creditCardUpcomingBillingCycle = currentCycleStartDay +
        ' ' +
        currentCycleStartMonth +
        ' - ' +
        currentCycleEndDay +
        ' ' +
        currentCycleEndMonth;
    creditCardNextBillingCycle = nextCycleStartDay +
        ' ' +
        nextCycleStartMonth +
        ' - ' +
        nextCycleEndDay +
        ' ' +
        nextCycleEndMonth;
  }

  _store_wallet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var new_wallet = {'name': walletName, 'type': walletType, 'balance': 0};

    // Fetch and decode data
    final String existing_wallets = await prefs.getString('wallets');

    if (existing_wallets == null) {
      var encodedData = [new_wallet];
      var stringList = jsonEncode(encodedData);
      prefs.setString('wallets', stringList);
    } else {
      var decodedData = jsonDecode(existing_wallets);
      print('here');
      print(decodedData);

      for (int i = 0; i < decodedData?.length ?? 0; i++) {
        if (decodedData[i]['name'] == new_wallet['name']) {
          print('same name cannot');
          return false;
        }
      }
      decodedData.add(new_wallet);
      var stringList = jsonEncode(decodedData);
      prefs.setString('wallets', stringList);
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Wallets.Wallets()),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case 'bank_account':
        walletTypeName = 'Add Bank Account';
        break;
      case 'cash':
        walletTypeName = 'Add Cash';
        break;
      case 'credit_card':
        walletTypeName = 'Add Credit Card';
        break;
      case 'loan':
        walletTypeName = 'Add Loan';
        break;
      case 'insurance':
        walletTypeName = 'Add Insurance';
        break;
      case 'investment':
        walletTypeName = 'Add Investment';
        break;
    }

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(walletTypeName),
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
                      'Name',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.right,
                      onChanged: (content) {
                        walletName = content;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name your wallet',
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
            if (walletNameError == true)
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                height: 20,
                width: double.infinity,
                child: Text(
                  'Add a name for easy recognition.',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12.0,
                  ),
                ),
              ),
            if (widget.type != 'credit_card')
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
                        'Wallet balance',
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '0.00',
                          hintStyle: TextStyle(
                            color: hintTextColor,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (widget.type == 'credit_card')
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
                        'Available credit',
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '0.00',
                          hintStyle: TextStyle(
                            color: hintTextColor,
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            //  Temp disabled until we have backend to do cronjob calculations
            // if (walletType == 'Credit Card')
            //   Container(
            //     height: 50,
            //     decoration: BoxDecoration(
            //       border: Border(
            //         bottom: BorderSide(
            //           width: 1.0,
            //           color: borderColor,
            //         ),
            //       ),
            //     ),
            //     child: Row(
            //       children: [
            //         Expanded(
            //           child: Text(
            //             'Pay from',
            //             style: TextStyle(
            //               fontSize: 14.0,
            //             ),
            //           ),
            //         ),
            //         Expanded(
            //           child: TextField(
            //             textAlign: TextAlign.right,
            //             decoration: InputDecoration(
            //               border: InputBorder.none,
            //               hintText: 'Select wallet',
            //               hintStyle: TextStyle(
            //                 fontSize: 14.0,
            //                 color: hintTextColor,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            if (widget.type == 'credit_card')
              Container(
                height: 32,
              ),
            if (widget.type == 'credit_card')
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
                      child: Row(
                        children: [
                          Text(
                            'Statement date',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showTooltipDialog(
                                  context,
                                  'Payment date',
                                  'Statement date (also known as billing date) refers to the date of which your credit card statement is generated. ',
                                  width);
                            },
                            padding: new EdgeInsets.all(0.0),
                            icon: Icon(
                              Icons.healing_outlined,
                              color: tooltipIconColor,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: DropdownButton<String>(
                      icon: Visibility(
                        visible: false,
                        child: Icon(Icons.arrow_downward),
                      ),
                      items: <String>[
                        'Select date',
                        '1st',
                        '2nd',
                        '3rd',
                        '4th',
                        '5th',
                        '6th',
                        '7th',
                        '8th',
                        '9th',
                        '10th',
                        '11th',
                        '12th',
                        '13th',
                        '14th',
                        '15th',
                        '16th',
                        '17th',
                        '18th',
                        '19th',
                        '20th',
                        '21th',
                        '22th',
                        '23th',
                        '24th',
                        '25th',
                        '26th',
                        '27th',
                        '28th',
                        '29th',
                        '30th',
                        '31th',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                            width: (width - 16 - 16) / 2,
                            child: Text(
                              value == 'Select date'
                                  ? value
                                  : value + ' of every month',
                              style: value == 'Select date'
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
                          creditCardStatementDay = value;
                          _calculate_credit_card_statement_date();
                        });
                      },
                      underline: SizedBox(),
                      value: creditCardStatementDay,
                    )),
                  ],
                ),
              ),
            if (widget.type == 'credit_card')
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
                      child: Row(
                        children: [
                          Text(
                            'Payment date',
                            style: TextStyle(
                              fontSize: 14.0,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showTooltipDialog(
                                  context,
                                  'Statement date',
                                  'Statement date (also known as billing date) refers to the date of which your credit card statement is generated. ',
                                  width);
                            },
                            padding: new EdgeInsets.all(0.0),
                            icon: Icon(
                              Icons.healing_outlined,
                              color: tooltipIconColor,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: DropdownButton<String>(
                      icon: Visibility(
                        visible: false,
                        child: Icon(Icons.arrow_downward),
                      ),
                      items: <String>[
                        'Select date',
                        '1st',
                        '2nd',
                        '3rd',
                        '4th',
                        '5th',
                        '6th',
                        '7th',
                        '8th',
                        '9th',
                        '10th',
                        '11th',
                        '12th',
                        '13th',
                        '14th',
                        '15th',
                        '16th',
                        '17th',
                        '18th',
                        '19th',
                        '20th',
                        '21th',
                        '22th',
                        '23th',
                        '24th',
                        '25th',
                        '26th',
                        '27th',
                        '28th',
                        '29th',
                        '30th',
                        '31th',
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                            width: (width - 16 - 16) / 2,
                            child: Text(
                              value == 'Select date'
                                  ? value
                                  : value + ' of every month',
                              style: value == 'Select date'
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
                          creditCardPaymentDay = value;
                        });
                      },
                      underline: SizedBox(),
                      value: creditCardPaymentDay,
                    )),
                  ],
                ),
              ),
            if (widget.type == 'credit_card')
              Container(
                height: 16,
              ),
            Container(
              height: 68,
              child: Padding(
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: 20,
                            child: Text(
                              'Upcoming billing cycle',
                              style: TextStyle(
                                color: hintTextColor,
                                fontSize: 12.0,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            creditCardUpcomingBillingCycle,
                            style: TextStyle(
                              color: billCycleDateColor,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: 20,
                            child: Text(
                              'Next billing cycle',
                              style: TextStyle(
                                color: hintTextColor,
                                fontSize: 12.0,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            creditCardNextBillingCycle,
                            style: TextStyle(
                              color: billCycleDateColor,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border(
                  bottom: BorderSide(
                    width: 1.0,
                    color: borderColor,
                  ),
                  top: BorderSide(
                    width: 1.0,
                    color: borderColor,
                  ),
                  left: BorderSide(
                    width: 1.0,
                    color: borderColor,
                  ),
                  right: BorderSide(
                    width: 1.0,
                    color: borderColor,
                  ),
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
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Notes (Optional)',
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
                        if (walletName == '') {
                          setState(() {
                            walletNameError = true;
                          });
                        } else {
                          setState(() {
                            walletNameError = false;
                          });
                        }
                        if (walletType == 'Select') {
                          setState(() {
                            walletTypeError = true;
                          });
                        } else {
                          setState(() {
                            walletTypeError = false;
                          });
                        }
                        if (walletNameError == true ||
                            walletTypeError == true) {
                          return false;
                        }
                        _store_wallet();
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

  showTooltipDialog(
      BuildContext context, tooltipTitle, tooltipText, screenWidth) {
    double insetHeightPadding = MediaQuery.of(context).size.height -
        72 -
        8 -
        24 -
        22 -
        24 -
        22 -
        23 -
        50;
    // set up the AlertDialog
    Dialog alert = Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(4),
        topLeft: Radius.circular(4),
      )),
      insetPadding: EdgeInsets.only(left: 0, right: 0, top: insetHeightPadding),
      child: Container(
        width: screenWidth,
        child: Padding(
          padding: EdgeInsets.only(left: 24, right: 24, top: 22, bottom: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topRight,
                height: 24,
                width: screenWidth - 24 - 24,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding:
                      EdgeInsets.only(left: 40, right: 0, top: 0, bottom: 0),
                  icon: Icon(
                    Icons.close,
                    color: tooltipIconColor,
                    size: 24,
                  ),
                ),
              ),
              Container(
                height: 22,
              ),
              Container(
                alignment: Alignment.topLeft,
                height: 24,
                child: Text(
                  tooltipTitle,
                  style: TextStyle(
                      height: 1.5,
                      color: tooltipDialogTitleColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 8,
              ),
              Container(
                alignment: Alignment.topLeft,
                height: 72,
                child: Text(
                  tooltipText,
                  style: TextStyle(
                    color: tooltipDialogTitleColor,
                    fontSize: 14.0,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
