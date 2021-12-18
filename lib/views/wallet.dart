import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  // const SecondRoute({Key? key}) : super(key: key);

  Color borderColor = Color(0xFFEBEDEF);
  Color backgroundColor = Color(0xFFFFFFFF);
  Color addButtonColor = Color(0xFF24324A);
  String walletType = 'Cash';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('New Wallet'),
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
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name your wallet',
                        hintStyle: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
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
                      'Wallet type',
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Expanded(
                      child: DropdownButton<String>(
                    icon: Visibility(
                      visible: false,
                      child: Icon(Icons.arrow_downward),
                    ),
                    items: <String>[
                      'Cash',
                      'Debit Card',
                      'Bank Account',
                      'Credit Card',
                      'Loan Account'
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          width: (width - 16 - 16) / 2,
                          child: Text(
                            value,
                            textAlign: TextAlign.right, //this will do that
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        walletType = value;
                      });
                      print('Changed wallet type');
                      print(walletType);
                    },
                    underline: SizedBox(),
                    value: walletType,
                  )),
                ],
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
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (walletType == 'Loan Balance')
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
                        'Loan balance',
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
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (walletType == 'Credit Card' || walletType == 'Loan Account')
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
                        'Pay from',
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
                          hintText: 'Select wallet',
                          hintStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (walletType == 'Credit Card')
              Container(
                height: 32,
              ),
            if (walletType == 'Credit Card')
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
                        'Settle on',
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
                          hintText: 'Select date',
                          hintStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (walletType == 'Credit Card')
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
                        'Pay on',
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
                          hintText: 'Select date',
                          hintStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                    ),
                  ],
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
                  hintText: 'Notes',
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
                      onPressed: () {},
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
