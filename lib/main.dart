import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'views/create_wallet.dart' as CreateWallet;
import 'views/transactions.dart' as Transactions;
import 'views/create_transaction.dart' as CreateTransaction;
import 'views/quick_add_transaction.dart' as QuickAddTransaction;
// import 'views/wallets.dart' as Wallets;
import 'views/settings.dart' as Settings;
import 'dart:convert';
import 'package:intl/intl.dart';
import "package:collection/collection.dart";

SharedPreferences sp;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: Colors.white),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Color income_color = Color(0xFF7CAC5F);
  Color expense_color = Colors.red;
  Color transfer_color = Color(0xFFC4C8CE);
  Color nav_border_color = Color(0xFF24324A1A);
  Color selected_nav_color = Color(0xFF0472FF);
  Color unselected_nav_color = Color(0xFF616C7D);
  Color selected_transaction_sub_type_color = Color(0xFF24324A);

  Color deleteButtonColor = Color(0xFFE36565);
  Color whenButtonInactiveColor = Color(0xFFC4C8CE);
  Color whenButtonInactiveTextColor = Color(0xFF9CA3AD);
  Color whenButtonActiveColor = Color(0xFF24324A);
  Color whenButtonActiveTextColor = Color(0xFF24324A);
  Color incomeTextColor = Color(0xFF7CAC5F);
  Color expenseTextColor = Color(0xFFDA5358);
  Color transferTextColor = Color(0xFFC4C8CE);
  Color activeTransactionColor = Color(0xFF3A475C);
  Color inActiveTransactionColor = Color(0xFFEBEDEF);
  Color transactionBackgroundColor = Color(0xFFF4F5F6);

  int month_counter = 0;
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat("MMMM yyyy");
  static final DateFormat formatterDay = DateFormat("d MMM, E");
  String current_month_year = formatter.format(now);
  String selected_page = 'transaction';
  String selected_transaction_type = 'income';
  String selected_transaction_sub_type = 'transactions';

  double total_income_amount = 0;
  double total_expense_amount = 0;
  double total_transfer_amount = 0;

  List expense_transactions = [];
  List income_transactions = [];
  List transfer_transactions = [];
  List active_transactions = [];

  List expense_transactions_by_category = [];
  List income_transactions_by_category = [];
  List transfer_transactions_by_category = [];
  List active_transactions_by_category = [];

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  calculateTransactionAmountByDay(transactions) {
    var transactions_to_calculate =
        transactions[transactions.keys.toList().first];

    double results = 0;

    transactions_to_calculate.forEach((transaction) {
      results = results + transaction['amount'];
    });

    return '\$' + results.toStringAsFixed(2);
  }

  _loadTransactions() async {
    active_transactions = [];
    expense_transactions = [];
    income_transactions = [];
    transfer_transactions = [];
    active_transactions_by_category = [];
    total_expense_amount = 0;
    total_income_amount = 0;
    total_transfer_amount = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List expense_transactions_local = [];
    List income_transactions_local = [];
    List transfer_transactions_local = [];

    if (prefs.getString('transactions') == null) {
      return 0;
    }

    List all_transactions = jsonDecode(prefs.getString('transactions'));

    all_transactions.forEach((transaction) {
      String transaction_month_year =
          formatter.format(DateTime.parse(transaction['date']));
      String transaction_month_day =
          formatterDay.format(DateTime.parse(transaction['date']));

      String transaction_month_day_today = formatterDay.format(now);

      if (transaction_month_day_today == transaction_month_day) {
        transaction_month_day = 'Today | ' + transaction_month_day;
      }

      transaction['displayed_date'] = transaction_month_day;

      if (transaction_month_year == current_month_year) {
        switch (transaction['category']['type']) {
          case 'expense':
            expense_transactions_local.add(transaction);
            total_expense_amount = total_expense_amount + transaction['amount'];
            break;
          case 'income':
            income_transactions_local.add(transaction);
            total_income_amount = total_income_amount + transaction['amount'];
            break;
          case 'transfer':
            transfer_transactions_local.add(transaction);
            total_transfer_amount =
                total_transfer_amount + transaction['amount'];
            break;
        }
      }
    });

    List temp_active_transactions = [];
    List temp_active_transactions_by_category = [];

    switch (selected_transaction_type) {
      case 'expense':
        temp_active_transactions = expense_transactions_local;
        temp_active_transactions_by_category = expense_transactions_local;
        break;
      case 'income':
        temp_active_transactions = income_transactions_local;
        temp_active_transactions_by_category = income_transactions_local;
        break;
      case 'transfer':
        temp_active_transactions = transfer_transactions_local;
        temp_active_transactions_by_category = transfer_transactions_local;
        break;
    }

    double total_active_transactions_by_category_amount = 0.0;

    for (var i = 0; i < temp_active_transactions_by_category.length; i++) {
      total_active_transactions_by_category_amount =
          total_active_transactions_by_category_amount +
              temp_active_transactions_by_category[i]['amount'];

      if (i == 0) {
        active_transactions_by_category.add({
          'category': temp_active_transactions_by_category[i]['category']
              ['name'],
          'amount': temp_active_transactions_by_category[i]['amount'],
          'data': [temp_active_transactions_by_category[i]]
        });
      } else {
        var category_exist = false;
        var category_array_key = 0;
        for (var j = 0; j < active_transactions_by_category.length; j++) {
          if (active_transactions_by_category[j]['category'] ==
              temp_active_transactions_by_category[i]['category']['name']) {
            category_exist = true;
            category_array_key = j;
            break;
          }
        }

        if (category_exist == false) {
          active_transactions_by_category.add({
            'category': temp_active_transactions_by_category[i]['category']
                ['name'],
            'amount': temp_active_transactions_by_category[i]['amount'],
            'data': [temp_active_transactions_by_category[i]]
          });
        } else {
          active_transactions_by_category[category_array_key]['data']
              .add(temp_active_transactions_by_category[i]);
          active_transactions_by_category[category_array_key]['amount'] =
              active_transactions_by_category[category_array_key]['amount'] +
                  temp_active_transactions_by_category[i]['amount'];
        }
      }
    }
    double current_total_percent = 0.0;
    for (var i = 0; i < active_transactions_by_category.length; i++) {
      if (i == active_transactions_by_category.length - 1) {
        active_transactions_by_category[i]['amount_percent'] =
            100 - current_total_percent;
        break;
      }
      active_transactions_by_category[i]['amount_percent'] =
          (active_transactions_by_category[i]['amount'] /
                  total_active_transactions_by_category_amount *
                  100)
              .toStringAsFixed(1);

      current_total_percent = current_total_percent +
          double.parse(active_transactions_by_category[i]['amount_percent']);
    }

    temp_active_transactions.sort((a, b) {
      //sorting in ascending order
      return DateTime.parse(b['date']).compareTo(DateTime.parse(a['date']));
    });

    for (var i = 0; i < temp_active_transactions.length; i++) {
      if (i == 0 ||
          temp_active_transactions[i]['displayed_date'] !=
              temp_active_transactions[i - 1]['displayed_date']) {
        var new_transaction = {
          temp_active_transactions[i]['displayed_date']: [
            temp_active_transactions[i]
          ]
        };
        active_transactions.add(new_transaction);
      } else if (temp_active_transactions[i]['displayed_date'] ==
          temp_active_transactions[i - 1]['displayed_date']) {
        active_transactions[active_transactions.length - 1]
                [temp_active_transactions[i]['displayed_date']]
            .add(temp_active_transactions[i]);
      }
    }
    print(active_transactions);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double scrollHeight = MediaQuery.of(context).size.height -
        72 -
        136 -
        MediaQuery.of(context).viewPadding.top - // height of status bar
        AppBar().preferredSize.height; //  height of AppBar

    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        backgroundColor: activeTransactionColor,
        child: const Icon(Icons.add),
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => CreateTransaction.CreateTransaction()),
          // );
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    QuickAddTransaction.QuickAddTransaction()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      bottomSheet: Padding(padding: EdgeInsets.only(bottom: 120.0)),
      appBar: AppBar(
        title: Text(current_month_year),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            month_counter = month_counter + 1;
            setState(() {
              var prevMonth =
                  new DateTime(now.year, now.month - month_counter, now.day);
              current_month_year = formatter.format(prevMonth);
              this._loadTransactions();
            });
          },
          icon: Icon(Icons.arrow_left_sharp),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_right_sharp,
            ),
            onPressed: () {
              month_counter = month_counter - 1;
              setState(() {
                var nextMonth =
                    new DateTime(now.year, now.month - month_counter, now.day);
                current_month_year = formatter.format(nextMonth);
                this._loadTransactions();
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 64,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: selected_transaction_type == 'income'
                                      ? 2
                                      : 1,
                                  color: selected_transaction_type == 'income'
                                      ? income_color
                                      : nav_border_color,
                                ),
                              ),
                            ),
                            height: 64,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected_transaction_type = 'income';
                                  this._loadTransactions();
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Income',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: income_color,
                                    ),
                                  ),
                                  Text(
                                    '\$' +
                                        total_income_amount.toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: income_color,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: selected_transaction_type == 'expense'
                                      ? 2
                                      : 1,
                                  color: selected_transaction_type == 'expense'
                                      ? expense_color
                                      : nav_border_color,
                                ),
                              ),
                            ),
                            height: 64,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected_transaction_type = 'expense';
                                  this._loadTransactions();
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Expense',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: expense_color,
                                    ),
                                  ),
                                  Text(
                                    '\$' +
                                        total_expense_amount.toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: expense_color,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 64,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: selected_transaction_type == 'transfer'
                                      ? 2
                                      : 1,
                                  color: selected_transaction_type == 'transfer'
                                      ? transfer_color
                                      : nav_border_color,
                                ),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected_transaction_type = 'transfer';
                                  this._loadTransactions();
                                });
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Transfer',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: transfer_color,
                                    ),
                                  ),
                                  Text(
                                    '\$' +
                                        total_transfer_amount
                                            .toStringAsFixed(2),
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: transfer_color,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 24,
                      bottom: 24,
                    ),
                    child: Container(
                      height: 24,
                      width: 174,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
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
                                  selected_transaction_sub_type =
                                      'transactions';
                                });
                              },
                              child: Container(
                                height: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: selected_transaction_sub_type ==
                                          'transactions'
                                      ? selected_transaction_sub_type_color
                                      : Colors.transparent,
                                ),
                                child: Text(
                                  'Transactions',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: selected_transaction_sub_type ==
                                              'transactions'
                                          ? Colors.white
                                          : unselected_nav_color,
                                      height:
                                          1.55 //HACK, need to find better way to align vertical center and horizontal center at the same time
                                      ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected_transaction_sub_type = 'category';
                                });
                              },
                              child: Container(
                                height: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: selected_transaction_sub_type ==
                                          'category'
                                      ? selected_transaction_sub_type_color
                                      : Colors.transparent,
                                ),
                                child: Text(
                                  'Category',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: selected_transaction_sub_type ==
                                              'category'
                                          ? Colors.white
                                          : unselected_nav_color,
                                      height:
                                          1.55 //HACK, need to find better way to align vertical center and horizontal center at the same time
                                      ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: SizedBox(
                      height: scrollHeight,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Stack(
                          children: [
                            if (selected_transaction_sub_type == 'transactions')
                              Column(
                                children: [
                                  for (var i = 0;
                                      i < active_transactions.length;
                                      i++)
                                    Container(
                                      margin: EdgeInsets.only(bottom: 16),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: transactionBackgroundColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 12,
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 24,
                                              width: double.infinity,
                                              child: Text(
                                                active_transactions[i]
                                                    .keys
                                                    .toList()
                                                    .first,
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
                                                if (selected_transaction_type ==
                                                    'income')
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.arrow_downward,
                                                          color:
                                                              incomeTextColor,
                                                          size: 12,
                                                        ),
                                                        Text(
                                                          calculateTransactionAmountByDay(
                                                              active_transactions[
                                                                  i]),
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            color:
                                                                incomeTextColor,
                                                            height:
                                                                1.35, //HACK, need to find better way to align vertical center and horizontal center at the same time
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                if (selected_transaction_type ==
                                                    'expense')
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.arrow_upward,
                                                          color:
                                                              expenseTextColor,
                                                          size: 12,
                                                        ),
                                                        Text(
                                                          calculateTransactionAmountByDay(
                                                              active_transactions[
                                                                  i]),
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            color:
                                                                expenseTextColor,
                                                            height:
                                                                1.35, //HACK, need to find better way to align vertical center and horizontal center at the same time
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                if (selected_transaction_type ==
                                                    'transfer')
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.arrow_forward,
                                                          color:
                                                              transferTextColor,
                                                          size: 12,
                                                        ),
                                                        Text(
                                                          calculateTransactionAmountByDay(
                                                              active_transactions[
                                                                  i]),
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            color:
                                                                transferTextColor,
                                                            height:
                                                                1.35, //HACK, need to find better way to align vertical center and horizontal center at the same time
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            for (var j = 0;
                                                j <
                                                    active_transactions[i][
                                                            active_transactions[
                                                                    i]
                                                                .keys
                                                                .toList()
                                                                .first]
                                                        .length;
                                                j++)
                                              Container(
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(
                                                      width: 1,
                                                      color:
                                                          inActiveTransactionColor,
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          top: 8,
                                                          bottom: 8,
                                                        ),
                                                        child: Container(
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        transfer_color,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(4),
                                                                  ),
                                                                  height: 20,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left: 5,
                                                                      right: 5,
                                                                    ),
                                                                    child: Text(
                                                                      "${active_transactions[i][active_transactions[i].keys.toList().first][j]['category']['name'].toString()[0].toUpperCase()}${active_transactions[i][active_transactions[i].keys.toList().first][j]['category']['name'].toString().substring(1)}",
                                                                      style:
                                                                          TextStyle(
                                                                        height:
                                                                            1.5, //HACK, need to find better way to align vertical center and horizontal center at the same time
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  )),
                                                              Container(
                                                                width: 4,
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                  active_transactions[
                                                                          i][active_transactions[
                                                                              i]
                                                                          .keys
                                                                          .toList()
                                                                          .first][j]['description']
                                                                      .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color:
                                                                        activeTransactionColor,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          // color: Colors.red,
                                                          // child: Column(
                                                          //   children: [
                                                          //     Expanded(
                                                          //       child:
                                                          //           Container(
                                                          //         color: Colors
                                                          //             .red,
                                                          //         alignment:
                                                          //             Alignment
                                                          //                 .topLeft,
                                                          //         child: Text(
                                                          //           'test',
                                                          //           // active_transactions[
                                                          //           //     i][active_transactions[
                                                          //           //         i]
                                                          //           //     .keys
                                                          //           //     .toList()
                                                          //           //     .first][j]['wallet']['name'],
                                                          //           style:
                                                          //               TextStyle(
                                                          //             color:
                                                          //                 whenButtonInactiveTextColor,
                                                          //             fontSize:
                                                          //                 12.0,
                                                          //           ),
                                                          //         ),
                                                          //       ),
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 100,
                                                      child: Text(
                                                        '\$' +
                                                            active_transactions[
                                                                        i][active_transactions[
                                                                            i]
                                                                        .keys
                                                                        .toList()
                                                                        .first][
                                                                    j]['amount']
                                                                .toStringAsFixed(
                                                                    2),
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              expenseTextColor,
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
                                  Container(
                                    height: 50,
                                  )
                                ],
                              )
                            else
                              Column(children: [
                                for (var i = 0;
                                    i < active_transactions_by_category.length;
                                    i++)
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 16.0),
                                    decoration: BoxDecoration(
                                      color: transactionBackgroundColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Theme(
                                      // data: ThemeData().copyWith(
                                      //     dividerColor: Colors.transparent),
                                      data: Theme.of(context).copyWith(
                                          dividerColor: Colors.transparent,
                                          accentColor: unselected_nav_color,
                                          unselectedWidgetColor:
                                              unselected_nav_color
                                                ..withOpacity(0.8)),
                                      child: ExpansionTile(
                                        title: Row(
                                          children: [
                                            Container(
                                              width: 50,
                                              child: Text(
                                                active_transactions_by_category[
                                                            i]['amount_percent']
                                                        .toString() +
                                                    '%',
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  color:
                                                      selected_transaction_sub_type_color,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Text(
                                                  "${active_transactions_by_category[i]['category'].toString()[0].toUpperCase()}${active_transactions_by_category[i]['category'].toString().substring(1)}",
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    color:
                                                        selected_transaction_sub_type_color,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                '\$' +
                                                    active_transactions_by_category[
                                                            i]['amount']
                                                        .toStringAsFixed(2),
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: expenseTextColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        children: [
                                          for (var j = 0;
                                              j <
                                                  active_transactions_by_category[
                                                          i]['data']
                                                      .length;
                                              j++)
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 16, right: 16),
                                              child: Container(
                                                height: 60,
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        top: BorderSide(
                                                          width: 1,
                                                          color:
                                                              inActiveTransactionColor,
                                                        ),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 8),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  Expanded(
                                                                    child: Container(
                                                                        width: double.infinity,
                                                                        child: Text('ASOS',
                                                                            style: TextStyle(fontSize: 14.0, color: activeTransactionColor, height: 1.4 //HACK, need to find better way to align vertical center and horizontal center at the same time
                                                                                ))),
                                                                  ),
                                                                  Expanded(
                                                                    child: Container(
                                                                        width: double.infinity,
                                                                        child: Text('OCBC 365 Credit Card',
                                                                            style: TextStyle(fontSize: 12.0, color: transferTextColor, height: 1.55 //HACK, need to find better way to align vertical center and horizontal center at the same time
                                                                                ))),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 100,
                                                              child: Column(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Expanded(
                                                                          child: Container(
                                                                              width: double.infinity,
                                                                              child: Text('S8.00',
                                                                                  textAlign: TextAlign.right,
                                                                                  style: TextStyle(fontSize: 14.0, color: expenseTextColor, height: 1.4 //HACK, need to find better way to align vertical center and horizontal center at the same time
                                                                                      ))),
                                                                        ),
                                                                        Expanded(
                                                                          child: Container(
                                                                              width: double.infinity,
                                                                              child: Text('28 Feb',
                                                                                  textAlign: TextAlign.right,
                                                                                  style: TextStyle(fontSize: 12.0, color: transferTextColor, height: 1.55 //HACK, need to find better way to align vertical center and horizontal center at the same time
                                                                                      ))),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ))),
                                              ),
                                            ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(
                                                      width: 1,
                                                      color:
                                                          inActiveTransactionColor,
                                                    ),
                                                  ),
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      print('pressedddd');
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: double.infinity,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8, bottom: 12),
                                                      child: Container(
                                                        child: Text(
                                                            'View all shopping transactions',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .underline,
                                                                fontSize: 12.0,
                                                                color:
                                                                    selected_nav_color,
                                                                height:
                                                                    1.45 //HACK, need to find better way to align vertical center and horizontal center at the same time
                                                                )),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                Container(
                                  height: 50,
                                )
                              ])
                          ],
                        ),
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
                    //  Wallet functionalities temporary disabled
                    // Expanded(
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => Wallets.Wallets()),
                    //       );
                    //     },
                    //     child: Padding(
                    //       padding: EdgeInsets.only(top: 12),
                    //       child: Column(
                    //         children: [
                    //           Icon(
                    //             Icons.folder_open_rounded,
                    //             size: 24,
                    //             color: selected_page == 'wallet'
                    //                 ? selected_nav_color
                    //                 : unselected_nav_color,
                    //           ),
                    //           Container(
                    //             height: 4,
                    //           ),
                    //           Icon(
                    //             Icons.circle,
                    //             size: 8,
                    //             color: selected_page == 'wallet'
                    //                 ? selected_nav_color
                    //                 : Colors.transparent,
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
}
