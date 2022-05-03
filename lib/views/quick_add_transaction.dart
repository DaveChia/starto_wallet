import 'package:flutter/material.dart';
import './transaction_added_success.dart' as QuickAddTransactionSuccess;
import './quick_add_transaction_key.dart' as QuickAddTransactionKey;

class QuickAddTransaction extends StatefulWidget {
  QuickAddTransaction();
  @override
  _QuickAddTransactionState createState() => _QuickAddTransactionState();
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

  String selected_transaction_sub_type = 'expense';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Add Transaction'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.cancel_outlined),
        ),
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
                              Draggable(
                                // Data is the value this Draggable stores.
                                data: 'text',
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  height: 36,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 8),
                                    child: Text(
                                      'MRT \$2',
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
                                      'MRT \$2',
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
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
                                childWhenDragging: Container(
                                    // height: 36,
                                    ),
                              ),
                              Draggable(
                                // Data is the value this Draggable stores.
                                data: 'text',
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  height: 36,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 8),
                                    child: Text(
                                      'MRT \$2',
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
                                      'MRT \$2',
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
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
                                childWhenDragging: Container(
                                    // height: 36,
                                    ),
                              ),
                              Draggable(
                                // Data is the value this Draggable stores.
                                data: 'text',
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  height: 36,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 8),
                                    child: Text(
                                      'Breakfast \$5',
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
                                      'Breakfast \$5',
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
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
                                childWhenDragging: Container(
                                    // height: 36,
                                    ),
                              ),
                              Draggable(
                                // Data is the value this Draggable stores.
                                data: 'text',
                                child: Container(
                                  margin: EdgeInsets.only(right: 10, top: 5),
                                  height: 36,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 8),
                                    child: Text(
                                      'Lunch \$2',
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
                                      'MRT \$2',
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
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
                                childWhenDragging: Container(
                                    // height: 36,
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
                              child: Container(
                                  height: 150.0,
                                  width: 150.0,
                                  color: Colors.blue,
                                  child: Text('drop here')),
                            );
                          },
                          onWillAccept: (data) {
                            return true;
                          },
                          onAccept: (data) {
                            print(data);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      QuickAddTransactionSuccess
                                          .TransactionAddedSuccess()),
                            );
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => QuickAddTransactionKey
                                        .QuickAddTransactionKey()),
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
                                        'Food',
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
