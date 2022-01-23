import 'package:flutter/material.dart';
import 'create_wallet.dart' as CreateWallet;

class CreateWalletLand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color borderColor = Color(0xFFEBEDEF);
    Color backgroundColor = Color(0xFFFFFFFF);
    Color iconColor = Color(0xFF0472FF);
    Color arrowColor = Color(0xFF616C7D);
    Color titleColor = Color(0xFF3A475C);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Select a wallet you wish to add'),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: SingleChildScrollView(
            child: Stack(children: [
              Column(children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateWallet.Wallet(
                                type: 'bank_account',
                              )),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1.0,
                          color: borderColor,
                        ),
                        bottom: BorderSide(
                          width: 1.0,
                          color: borderColor,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          width: 36,
                          child: Icon(
                            Icons.home_outlined,
                            color: iconColor,
                            size: 25,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 16,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Bank account',
                                  style: TextStyle(
                                      color: titleColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                height: 24,
                              ),
                              Container(
                                height: 2,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'For savings account, spending account, cash and debit card',
                                  style: TextStyle(
                                    color: arrowColor,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              Container(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 36,
                          child: Icon(
                            Icons.arrow_right,
                            color: arrowColor,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateWallet.Wallet(
                                type: 'cash',
                              )),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1.0,
                          color: borderColor,
                        ),
                        bottom: BorderSide(
                          width: 1.0,
                          color: borderColor,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          width: 36,
                          child: Icon(
                            Icons.money,
                            color: iconColor,
                            size: 25,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 16,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Cash',
                                  style: TextStyle(
                                      color: titleColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                height: 24,
                              ),
                              Container(
                                height: 2,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'For cash on hand',
                                  style: TextStyle(
                                    color: arrowColor,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              Container(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 36,
                          child: Icon(
                            Icons.arrow_right,
                            color: arrowColor,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateWallet.Wallet(
                                type: 'credit_card',
                              )),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1.0,
                          color: borderColor,
                        ),
                        bottom: BorderSide(
                          width: 1.0,
                          color: borderColor,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          width: 36,
                          child: Icon(
                            Icons.credit_card,
                            color: iconColor,
                            size: 25,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 16,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Credit card',
                                  style: TextStyle(
                                      color: titleColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                height: 24,
                              ),
                              Container(
                                height: 2,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'For credit cards',
                                  style: TextStyle(
                                    color: arrowColor,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              Container(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 36,
                          child: Icon(
                            Icons.arrow_right,
                            color: arrowColor,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateWallet.Wallet(
                                type: 'loan',
                              )),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1.0,
                          color: borderColor,
                        ),
                        bottom: BorderSide(
                          width: 1.0,
                          color: borderColor,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          width: 36,
                          child: Icon(
                            Icons.local_atm_rounded,
                            color: iconColor,
                            size: 25,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 16,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Loan',
                                  style: TextStyle(
                                      color: titleColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                height: 24,
                              ),
                              Container(
                                height: 2,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'For credit loan and loan repayment account',
                                  style: TextStyle(
                                    color: arrowColor,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              Container(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 36,
                          child: Icon(
                            Icons.arrow_right,
                            color: arrowColor,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateWallet.Wallet(
                                type: 'insurance',
                              )),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1.0,
                          color: borderColor,
                        ),
                        bottom: BorderSide(
                          width: 1.0,
                          color: borderColor,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          width: 36,
                          child: Icon(
                            Icons.list_alt,
                            color: iconColor,
                            size: 25,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 16,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Insurance',
                                  style: TextStyle(
                                      color: titleColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                height: 24,
                              ),
                              Container(
                                height: 2,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'For endowment, savings and investment insurance policies',
                                  style: TextStyle(
                                    color: arrowColor,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              Container(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 36,
                          child: Icon(
                            Icons.arrow_right,
                            color: arrowColor,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateWallet.Wallet(
                                type: 'investment',
                              )),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          width: 1.0,
                          color: borderColor,
                        ),
                        bottom: BorderSide(
                          width: 1.0,
                          color: borderColor,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          width: 36,
                          child: Icon(
                            Icons.attach_money,
                            color: iconColor,
                            size: 25,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                height: 16,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Investment',
                                  style: TextStyle(
                                      color: titleColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                height: 24,
                              ),
                              Container(
                                height: 2,
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'For investment accounts in MooMoo, StashAway, EndowUs, etc',
                                  style: TextStyle(
                                    color: arrowColor,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              Container(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 36,
                          child: Icon(
                            Icons.arrow_right,
                            color: arrowColor,
                            size: 24,
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
    );
  }
}
